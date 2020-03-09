
---------------------------------------------------------------------------------------------------
--
--filename: game.bullet.BulletBase
--date:2019/9/25 18:13:29
--author:heguang
--desc:子弹
--
---------------------------------------------------------------------------------------------------
local TrailCtrl = require("game.effect.TrailCtrl")
local math_abs = math.abs

local strClassName = 'game.bullet.BulletBase'
local BulletBase = lua_declare(strClassName, lua_class(strClassName))
BulletBase.Ballistic_Straight = 0
BulletBase.Ballistic_Raycast = 1
BulletBase.Ballistic_Parabola = 2
BulletBase.Ballistic_Horizontal = 3
BulletBase.Ballistic_Rotation = 4

function BulletBase:dtor()
	print("****bullet base dtor.")
end

function BulletBase:Start()
	self.childMesh = self.transform:Find("mesh")
	self.childMeshRotation = self.childMesh.localRotation

	self.boxList = self.gameObject:GetComponents(BoxCollider)
	self.boxListCount = #self.boxList

	self.sphereList = self.gameObject:GetComponents(SphereCollider)
	self.sphereListCount = #self.sphereList

	self.capsuleList = self.gameObject:GetComponents(CapsuleCollider)
	self.capsuleListCount = #self.capsuleList

	self.trailCtrl = TrailCtrl(self.childMesh)
end

function BulletBase:Init(owner, args)
	self.owner = owner

	self.entityData = self.owner.entityData
	self.srcMoveSpeed = self.entityData:GetBulletMoveSpeed()
	self.moveSpeed = self.srcMoveSpeed
	self.ballistic = self.entityData:GetBallistic()
	self.bulletRotateAngle = self.entityData:GetBulletRotateAngle()
	self.rotateSpeed = self.entityData:GetRotateSpeed()
	self.aliveTime = self.entityData:GetAliveTime()
	self.reboundWallCount = self.entityData.reboundWall
	self.arrowEjectCount = self.owner.entityData.arrowEjectCount
	self.bulletDistance = self.owner.entityData:GetBulletDistance()
	self.throuthEnemy = self.owner.entityData:GetThrouthEnemy()
	self.checkDeadTime = self.owner.entityData:GetDeadDelayTime()
	self.deadEffectName = self.owner.entityData:GetDeadEffectName()
	self.knockbackRation = self.owner.entityData:GetBulletKnockback()
	self.dmg, self.headShot, self.crit = self.owner:CreateDamage()

	self.triggerTestVector = Vector3(0, 1, 0)

	self.moveDirection = Vector3.zero
	self.moveVector = Vector3.zero
	self.moveX = 0
	self.moveY = 0
	self.flyRotate = true
	self.bulletAngle = self.transform.eulerAngles.y
	self:UpdateMoveDirection()
	self.startPosition = Vector3(self.transform.position.x, 0, self.transform.position.z)
	self.startPositionY = self.transform.position.y
	self.targetPosition = nil
	
	self.totalDistance = 0
	self.currentDistance = 0

	self.currentFrame = 0
	self.triggerFrame = 0
	self.triggerInterval = 0

	self.hitWall = nil

	if self.ballistic == BulletBase.Ballistic_Parabola then
		self.parabola_maxHeight = 2
		self.parabola_curve = GameCurve.Instance:GetCurve(1)
	elseif self.ballistic == BulletBase.Ballistic_Horizontal then
		self.horizontal_vec = Vector3.zero
		self.horizontal_curve = GameCurve.Instance:GetCurve(2)
	end

	self.checkAliveTime = false
	self.startAliveTime = Time.realtimeSinceStartup
	self.isAlive = true

	self.checkDead = false
	self.checkDeadTimer = 0

	self.damageTickEntities = {}
	self.damageTickTime = 5

	self:OnInit(args)
end

function BulletBase:OnInit(args)

end

function BulletBase:Fire(entity)
	self:SetTarget(entity)

	self.startPosition = self.transform.position
	self:UpdateMoveDirection()
	
	self.currentDistance = 0
	self.moveTime = self.totalDistance / self.moveSpeed
	self.moveTimer = 0
	
	self:UpdateParabolaArgs()

	if self.aliveTime > 0 then
		self.checkAliveTime = true
		self.startAliveTime = Time.realtimeSinceStartup
		self.aliveTime = self.aliveTime
	end

	if self.reboundWallCount > 0 then
		self.reboundWall = true
	else
		self.reboundWall = false
	end

	if self.trailCtrl then
		self.trailCtrl:TrailShow(true)
	end

	self:OnFire(entity)
	self.isMove = true
end

function BulletBase:OnFire(entity)
	
end

function BulletBase:OnMoveEnd()
	--self:ShowDeadEffect()
	self.damageTickEntities = {}
	self.isMove = false
	self.checkAliveTime = false
	self.hitWall = nil
	if self.isAlive then
		self.isAlive = false
		ObjectPool.Recycle(self.gameObject)
		if self.childMesh ~= nil then
			self.childMesh.localRotation = self.childMeshRotation
		end
	end
	if self.trailCtrl then
		self.trailCtrl:TrailShow(false)
	end
	--collectgarbage("collect")
end

function BulletBase:SetTarget(entity)
	self.startPosition = self.transform.position
	if entity then
		self.targetPosition = entity.transform.position
		if self.ballistic == BulletBase.Ballistic_Parabola then
			self.totalDistance = Vector3.Distance(self.targetPosition, self.startPosition)
		else
			self.totalDistance = self.bulletDistance
		end
	else
		local dis = self.bulletDistance
		self.targetPosition = self.transform.position + self.transform.forward * dis
		self.totalDistance = self.bulletDistance
	end
	if self.totalDistance < 0.01 then
		self.totalDistance = 0
	end
end

function BulletBase:UpdateParabolaArgs()
	if self.ballistic == BulletBase.Ballistic_Parabola then
		local beforeframe = self.parabola_curve.keys[1]
		local afterframe = Keyframe(0, self.startPositionY / self.parabola_maxHeight)
		afterframe.outTangent = beforeframe.outTangent
        self.parabola_curve:MoveKey(0, afterframe)
	end
end

function BulletBase:GetFrameDistance(deltaTime)
	return self.moveSpeed * deltaTime
end

function BulletBase:Update()
	if LuaGameUtil.IsPaused() then
		return
	end

	local deltaTime = Time.deltaTime

	for k,v in pairs(self.damageTickEntities) do
		self.damageTickEntities[k] = v + deltaTime
	end

	if self.checkDead then
		self.checkDeadTimer = self.checkDeadTimer + deltaTime
		if self.checkDeadTimer > self.checkDeadTime then
			self.checkDead = false
			self:OnMoveEnd()
		end
	end

	local frameDistance = self:GetFrameDistance(deltaTime)
	self:CheckTriggerObject(frameDistance)

	self:OnUpdate(deltaTime)

	self:HanleBulletRotate(deltaTime)
	if self.checkAliveTime then
		if (Time.realtimeSinceStartup - self.startAliveTime) > self.aliveTime then
			self.checkAliveTime = false
			self:OnMoveEnd()
		end
	end
end

function BulletBase:OnUpdate(deltaTime)
	if self.ballistic == BulletBase.Ballistic_Straight then
		self:BulletStraight(deltaTime)
	elseif self.ballistic == BulletBase.Ballistic_Raycast then
		self:BulletRayCast(deltaTime)
	elseif self.ballistic == BulletBase.Ballistic_Parabola then
		self:BulletParabola(deltaTime)
	elseif self.ballistic == BulletBase.Ballistic_Horizontal then
		self:BulletHorizontal(deltaTime)
	elseif self.ballistic == BulletBase.Ballistic_Rotation then
		self:BulletRotation(deltaTime)
	end
end

function BulletBase:HanleBulletRotate(deltaTime)
	if not self.isMove then
		return
	end
	if self.rotateSpeed > 0 then
		if self.childMesh ~= nil then
			local rotate = self.childMesh.localEulerAngles
			self.childMesh.localRotation = Quaternion.Euler(rotate.x, rotate.y + self.rotateSpeed, rotate.z)
		end
	end
end

function BulletBase:UpdateMoveDirection()
	--[[
	self.moveDirection = self.targetPosition - self.startPosition
	self.moveDirection:Normalize()
	self.transform.rotation = Quaternion.LookRotation(self.moveDirection, Vector3.up)
	--]]
	self.moveX = LuaMath.Sin(self.bulletAngle)
	self.moveY = LuaMath.Cos(self.bulletAngle) --* CommonUtil.mapScaleZ
	self.moveDirection = Vector3(self.moveX, 0, self.moveY)
	if self.flyRotate then
		local eulerAngles = self.transform.eulerAngles
		self.transform.rotation = Quaternion.Euler(eulerAngles.x, self.bulletAngle, eulerAngles.z)
	end

	local srcY = self.moveY / CommonUtil.mapScaleZ
	local srcAngle = LuaMath.GetAngle(self.moveX, srcY)
	local rate = self.moveX / LuaMath.Sin(srcAngle)
	if self.moveX == 0 then
		rate = CommonUtil.mapScaleZ
	else
		rate = 1 / rate
	end
	--print("****", self.bulletAngle,  srcAngle, rate)
	self.moveSpeed = self.srcMoveSpeed * rate
end

function BulletBase:CheckTriggerObject(frameDistance)
	if not self.isMove then
		return
	end
	if frameDistance > 0 then
		self.triggerInterval = math.floor(0.1 / frameDistance)
	else
		self.triggerInterval = 0
	end

	if (Time.frameCount - self.triggerFrame) > self.triggerInterval then
		self.triggerFrame = Time.frameCount
		self:DoCheckTriggerObject(frameDistance)
	end

end

function BulletBase:DoCheckTriggerObject(frameDistance)
	if self.currentFrame ~= Time.frameCount then
		self.triggerHits = nil
		self.beforeHit = frameDistance
		local layer = GameUtil.CullingLayer(LayerManager.MapOutWall, LayerManager.Player, LayerManager.Obstruct)
		if self.ballistic == BulletBase.Ballistic_Raycast then
			self.beforeHit = Mathf.Clamp(frameDistance, 0, 0.8)
			local raycastOrigin = self.transform.position - self.moveDirection * self.beforeHit
			self.triggerHits = GameUtil.Raycast(raycastOrigin, self.moveDirection.normalized, frameDistance + self.beforeHit, layer)
		elseif self.boxListCount > 0 then
			self.triggerHits = {}
			for i=1,self.boxListCount do
				local box = self.boxList[i]
				local center = self.transform:TransformPoint( (Vector3(0, 0, -1) * self.beforeHit) + box.center)
				local halfExtents = (self.transform.localScale.x * box.size) * 0.5
				local hitArray = GameUtil.BoxCastAll(center, halfExtents, self.moveDirection.normalized, self.transform.rotation, frameDistance + self.beforeHit, layer)
				for n=1,#hitArray do
					local hit = hitArray[n]
					if hit.collider ~= nil and hit.collider.gameObject ~= nil then
						table.insert(self.triggerHits, hit)
					end
				end
			end
		elseif self.sphereListCount > 0 then
			local sphere = self.sphereList[1]
			local origin =  self.transform.position - self.moveDirection * self.beforeHit
			local radius = self.transform.localScale.x * sphere.radius
			self.triggerHits = GameUtil.SphereCastAll(origin, radius, self.moveDirection.normalized, frameDistance + self.beforeHit, layer)
		elseif self.capsuleListCount > 0 then
			local capsule = self.capsuleList[1]
			local point1 = self.transform.position + ( (self.triggerTestVector * (capsule.height - 1)) * 0.5 ) - self.moveDirection * self.beforeHit
			local point2 = self.transform.position - ( (self.triggerTestVector * (capsule.height - 1)) * 0.5 ) - self.moveDirection * self.beforeHit
			local radius = self.transform.localScale.x * capsule.radius
			self.triggerHits = GameUtil.CapsuleCastAll(point1, point2, radius, self.moveDirection.normalized, frameDistance + self.beforeHit, layer)
		end

		if self.triggerHits ~= nil then
			local minRayhit = nil
			local minDistance = 10000
			local tempDistance, tempMin
			for i=1, #self.triggerHits do
				local hit = self.triggerHits[i]
				if hit.collider ~= nil and hit.collider.gameObject ~= nil then
					local hitObj = hit.collider.gameObject
					if hitObj ~= self.owner.gameObject and hitObj ~= self.gameObject then
						tempDistance = hit.distance
						tempMin = Mathf.Abs(tempDistance - self.beforeHit)
						if tempMin <= minDistance then
							minDistance = tempMin
							minRayhit = hit
						end
					end
				end
			end
			if minRayhit ~= nil then
				self:TriggerEnter(minRayhit)
			end
			self.currentFrame = Time.frameCount
		end
	end
end

function BulletBase:TriggerEnter(rayHit)
	local collider = rayHit.collider
	if collider == nil then
		return
	end
	local go = collider.gameObject
	if go == nil then
		return
	end
	if go.layer == LayerManager.MapOutWall or go.layer == LayerManager.Obstruct then
		if self.reboundWall then
			self:ExcuteReboundWall(rayHit)
		else
			self:ExcuteOverDistance()
		end
	else
		self:TriggerExtra(rayHit)
	end
end

function BulletBase:TriggerExtra(rayHit)
	local collider = rayHit.collider
	if collider == nil then
		return
	end
	local go = collider.gameObject
	if go == nil then
		return
	end
	if go.layer == LayerManager.Player then
		if GameBattleManager.Instance() == nil then
			return
		end
		local entity = GameBattleManager.Instance().entityMgr:FindEntity(go)
		if entity == nil then
			return
		end
		if entity == self.owner then
			print("hit self")
			return
		end
		if not LuaGameUtil.IsSameTeam(entity, self.owner) then
			--判断是弹射
			local isEject = self:ExcuteArrowEject(entity)
			--判断是否穿透
			local isThrouthEnemy = self.throuthEnemy
			if isThrouthEnemy then
				self:CheckEnemyDamage(entity)
			elseif not isEject then
				self:ExcuteHitEnemy(entity)
			end
		end
	end
end

function BulletBase:ExcuteArrowEject(entity)
	if self.arrowEjectCount < 1 then
		return false
	end
	if GameBattleManager.Instance() == nil then
		return false
	end
	local nextEntity = GameBattleManager.Instance().entityMgr:FindArrowEject(entity)
	if nextEntity == nil then
		return false
	end

	self:CheckEnemyDamage(entity)
	self.damageTickEntities = {}
	
	self.arrowEjectCount = self.arrowEjectCount - 1
	local currentPosition = entity:GetPosition()
	local nextPosition = nextEntity:GetPosition()
	self.transform.position = Vector3(currentPosition.x, self.transform.position.y, currentPosition.z)
	local x = nextPosition.x - self.transform.position.x
	local y = nextPosition.z - self.transform.position.z
	self.bulletAngle = LuaMath.GetAngle(x, y)
	self:UpdateMoveDirection()

	return true
end

function BulletBase:ExcuteReboundWall(rayHit)
	if self.reboundWallCount < 1 then
		self:ExcuteOverDistance()
		return
	end
	local collider = rayHit.collider
	local raycastPoint = rayHit.point
	if collider.gameObject ~= self.hitWall then
		self.damageTickEntities = {}
		local reflect = Vector3.Reflect(self.moveDirection, rayHit.normal)
		self.bulletAngle = LuaMath.GetAngle(reflect.x, reflect.z)
		self:UpdateMoveDirection()
		self.hitWall = collider.gameObject
		self.reboundWallCount = self.reboundWallCount - 1
	end
end

--完成路程 
function BulletBase:ExcuteOverDistance()
	if not self.isMove then
		return
	end
	self.damageTickEntities = {}
	if self.ballistic ~= BulletBase.Ballistic_Parabola then
		self.isMove = false
		self.checkDead = true
		self.checkDeadTimer = 0
		
	else
		self:ShowDeadEffect()
	end
end

function BulletBase:ExcuteHitEnemy(entity)
	self:CheckEnemyDamage(entity)
	self:OnMoveEnd()
end

function BulletBase:CheckEnemyDamage(entity)
	if self.damageTickEntities[entity] == nil then
		entity:DoDamage(self.dmg, self.headShot, self.crit)
		self.damageTickEntities[entity] = 0
		entity:Knockback(self.transform.forward, self.knockbackRation)
	else
		local t = self.damageTickEntities[entity]
		if t >= self.damageTickTime then
			entity:DoDamage(self.dmg, self.headShot, self.crit)
			self.damageTickEntities[entity] = 0
			entity:Knockback(self.transform.forward, self.knockbackRation)
		end
	end
end

function BulletBase:BulletStraight(deltaTime)
	if not self.isMove then
		return
	end
	local moveDistance = self:GetFrameDistance(deltaTime)
	self.moveVector.x = self.moveX
	self.moveVector.y = 0
	self.moveVector.z = self.moveY
	self.transform:Translate( self.moveVector * moveDistance, UnityEngine.Space.World )
	self.currentDistance = self.currentDistance + moveDistance
	if self.currentDistance >= self.totalDistance then
		self.isMove = false
		self:OnMoveEnd()
	end
end

function BulletBase:BulletRayCast(deltaTime)
	if not self.isMove then
		return
	end
	local moveDistance = self:GetFrameDistance(deltaTime)
	self.transform:Translate(self.moveDirection * moveDistance, UnityEngine.Space.World)
	self.currentDistance = self.currentDistance + moveDistance
	if self.currentDistance >= self.totalDistance then
		self.isMove = false
		self:OnMoveEnd()
	end
end

function BulletBase:BulletRotation(deltaTime)
	if not self.isMove then
		return
	end
	local moveDistance = self:GetFrameDistance(deltaTime)

	self.transform.position = self.transform.position + Vector3(self.moveX, 0, self.moveY * 1.23) * moveDistance
	self.bulletAngle = self.bulletAngle + self.bulletRotateAngle
    self:UpdateMoveDirection()
	self.currentDistance = self.currentDistance + moveDistance
	if self.currentDistance >= self.totalDistance then
		self.isMove = false
		self:OnMoveEnd()
	end
end

function BulletBase:BulletParabola(deltaTime)
	if not self.isMove then
		return
	end
	local moveDistance = self:GetFrameDistance(deltaTime)
	self.currentDistance = self.currentDistance + moveDistance
	if self.currentDistance < self.totalDistance then
		local t = self.currentDistance / self.totalDistance
		local h = Mathf.Sin(180 * t * Mathf.Deg2Rad) * 0.5
		local pos = self.transform.position
		pos.x = pos.x + self.moveDirection.x * moveDistance
		--pos.y = self.startPositionY + h
		pos.y = self.parabola_curve:Evaluate(t) * self.parabola_maxHeight
		pos.z = pos.z + self.moveDirection.z * moveDistance
		self.transform.position = pos
	else
		self.isMove = false
		self:ShowDeadEffect()
		self:OnMoveEnd()
	end
end

function BulletBase:BulletHorizontal(deltaTime)
	if not self.isMove then
		return
	end
	local moveDistance = self:GetFrameDistance(deltaTime)
	self.currentDistance = self.currentDistance + moveDistance
	if self.currentDistance < self.totalDistance then
		local t = self.currentDistance / self.totalDistance
		local pos = self.transform.position
		self.horizontal_vec.x = pos.x + self.moveDirection.x * moveDistance
		local v = self.horizontal_curve:Evaluate(t)
		self.horizontal_vec.y = self.startPositionY * v
		self.horizontal_vec.z = pos.z + self.moveDirection.z * moveDistance
		self.transform.position = self.horizontal_vec
	else
		self.isMove = false
		self:OnMoveEnd()
	end
end

function BulletBase:ShowDeadEffect()
	
	if self.deadEffectName ~= nil then
		self:PlayEffect(self.deadEffectName, self.transform.position, self.transform.rotation)
	end
end

function BulletBase:PlayEffect(effectName, position, rotation)
	local effectObj = ObjectPool.Spawn(LuaGameUtil.GetEffectAbName(effectName))
	if effectObj ~= nil then
		local effectTransform = effectObj.transform
		effectTransform.position = position
		if rotation then
			effectTransform.rotation = rotation
		end
		local effect = effectObj:GetComponent(EffectController)
		if effect ~= nil then
			effect:Play()
		end
		return effect
	end
end

return BulletBase
