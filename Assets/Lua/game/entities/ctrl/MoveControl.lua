
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.MoveControl
--date:2019/10/6 0:18:18
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.entities.ctrl.MoveControl'
local MoveControl = lua_declare(strClassName, lua_class(strClassName))

function MoveControl:ctor(owner)
	self.owner = owner
	self.transform = self.owner.transform

	self.isMoving = false
	self.vector3zero = Vector3.zero
	self.moveDirection = Vector3(0, 0, 0)
	self.moveSpeed = self.owner.entityData:GetEntityMoveSpeed()

	self.totalDistance = 0

	self.attackDirection = Vector3.zero
	self.moveSpeedRatio = 1
	
	self.checkStopMove = false

	self.forceMoveSpeed = 0

	self.isJumping = false
	self.jumpSpeed = 0
	self.gravity = 9.8

	self.isKnockback = false
	self.knockbackMaxLength = 30
	self.knockbackMaxSpeed = 3
	self.knockbackSpeed = 0
end

function MoveControl:GetIsMoving()
	return self.isMoving
end

function MoveControl:SetAttackTarget(target)
	if self.isMoving then
		return
	end
	if target == nil then
		return
	end
	self.attackTarget = target

	local targetPosition = self.attackTarget:GetPosition()
	local attackerPosition = self.owner:GetPosition()

	self.attackDirection.x = targetPosition.x - attackerPosition.x
	self.attackDirection.z = targetPosition.z - attackerPosition.z
	self.attackDirection:Normalize()
	self.transform.rotation = Quaternion.LookRotation(self.attackDirection)
end

function MoveControl:CheckMovePath()
	if self.movePath == nil then
		return
	end
	
	if #self.movePath > 0 then
		local pos = table.remove(self.movePath)
		local ownerPosition = self.owner:GetPosition()
		self.targetPosition = pos
		self.totalDistance = Vector3.Distance(pos, ownerPosition)
		if self.totalDistance > 0.1 then
			self.moveDirection.x = self.targetPosition.x - ownerPosition.x
			self.moveDirection.z = self.targetPosition.z - ownerPosition.z
			self.moveDirection:Normalize()
			self.transform.rotation = Quaternion.LookRotation(self.moveDirection)
			self.moveTimer = 0
			self.moveTime = self.totalDistance / self.moveSpeed
			self.isMoving = true
		else
			self:CheckMovePath()
		end
	else
		self.isMoving = false
		self.checkStopMove = true
	end
end

function MoveControl:MoveTo(pos)
	local ownerPosition = self.owner:GetPosition()
	self.movePath = GameBattleManager.Instance().mapMgr:FindPath(ownerPosition, pos)
	self.checkStopMove = false
	self:CheckMovePath()
end

function MoveControl:StopMove()
	self.isMoving = false
	self.movePath = {}
	self.checkStopMove = true
end

function MoveControl:Knockback(backDir, backRatio)
	local mass = self.owner.entityData:GetBodyMass()
	--重量大于10,无法击退
	if mass >= 10 then
		return
	end

	if self.isKnockback then
		return
	end
	self.isKnockback = true
	self.knockbackDirection = backDir
	self.knockbackMaxLength = 30 / (1*mass)
	if self.knockbackMaxLength > 30 then
		self.knockbackMaxLength = 30
	end
	if backRatio ~= nil then
		self.knockbackMaxLength = self.knockbackMaxLength * backRatio
	end
	--print("****", self.knockbackMaxLength, mass, self.owner.entityData:GetBodyMass(), backRatio)
	self.knockbackSpeed = self.knockbackMaxSpeed
end

function MoveControl:ForceMove(speed)
	self.forceMoveSpeed = speed
end

function MoveControl:Jump(jumpSpeed)
	if self.isJumping then
		return
	end
	self.isJumping = true
	self.jumpSpeed = jumpSpeed
end

function MoveControl:DoMoving(deltaTime)
	if self.isMoving then
		self.moveTimer = self.moveTimer + deltaTime
		if self.moveTimer < self.moveTime then
			self.owner:SetSpeed(self.moveSpeedRatio)
			self.transform.rotation = Quaternion.Lerp(self.transform.rotation, Quaternion.LookRotation(self.moveDirection), 0.3);
			local moveVelocity = self.transform.forward
			moveVelocity.z = moveVelocity.z * CommonUtil.mapScaleZ
			local dis =  moveVelocity * self.moveSpeed *  self.moveSpeedRatio * deltaTime
			dis = self:RestrictPosition(dis)
			self.transform.position = self.transform.position + dis
		else
			self:CheckMovePath()
		end
	end
end

function MoveControl:RestrictPosition(pos)
	local hitArray = self.owner.hitCtrl:CastAll(pos)
	if hitArray == nil then
		return pos
	end
	for n=1,#hitArray do
		local hit = hitArray[n]
		if hit.collider ~= nil and hit.collider.gameObject ~= nil and hit.distance > 0 then
			local normal = hit.normal
			local x = math.abs(normal.x)
			local z = math.abs(normal.z)
			if x > z then
				pos.x = 0
			else
				if x < z then
					pos.z = 0
				elseif math.abs(pos.x) > math.abs(pos.z) then
					pos.z = 0
				else
					pos.x = 0
				end
			end
		end
	end
	return pos
end

function MoveControl:ResetMoving()
	if self.isMoving and self.targetPosition ~= nil then
		local ownerPosition = self.owner:GetPosition()
		self.totalDistance = Vector3.Distance(self.targetPosition, ownerPosition)
		if self.totalDistance > 0.1 then
			self.moveDirection.x = self.targetPosition.x - ownerPosition.x
			self.moveDirection.z = self.targetPosition.z - ownerPosition.z
			self.moveDirection:Normalize()
			self.transform.rotation = Quaternion.LookRotation(self.moveDirection)
			self.moveTimer = 0
			self.moveTime = self.totalDistance / self.moveSpeed
		else
			self:CheckMovePath()
		end
	end
end

function MoveControl:Update(deltaTime)
	if self.isKnockback then
		local speed = self.knockbackMaxLength * self.knockbackSpeed / self.knockbackMaxSpeed
		local dis =  self.knockbackDirection * speed * deltaTime
		dis = self:RestrictPosition(dis)
		self.transform.position = self.transform.position + dis
		self.knockbackSpeed = self.knockbackSpeed - 1
		if self.knockbackSpeed < 0 then
			self.isKnockback = false
			self:ResetMoving()
		end
		return
	end

	self:DoMoving(deltaTime)

	if self.forceMoveSpeed > 0 then
		local dis =  self.transform.forward * self.forceMoveSpeed * deltaTime
		dis = self:RestrictPosition(dis)
		self.transform.position = self.transform.position + dis		
	end

	if self.isJumping then
		self.jumpSpeed = self.jumpSpeed - (self.gravity * deltaTime)
		local dis = Vector3.up * self.jumpSpeed * deltaTime
		dis = self:RestrictPosition(dis)
		local pos = self.transform.position + dis
		if pos.y <= 0 then
			pos.y = 0
			self.isJumping = false
		end
		self.transform.position = pos
	end
end

function MoveControl:LateUpdate()
	if LuaGameUtil.IsPaused() then
		return
	end
	if self.checkStopMove then
		self.checkStopMove = false
		self.moveDirection = self.vector3zero
		self.owner:SetSpeed(0)
	end
end

return MoveControl
