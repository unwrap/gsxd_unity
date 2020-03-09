
---------------------------------------------------------------------------------------------------
--
--filename: game.weapon.WeaponBase
--date:2019/9/25 18:12:26
--author:heguang
--desc:武器
--
---------------------------------------------------------------------------------------------------
local BulletBase = require("game.bullet.BulletBase")

local strClassName = 'game.weapon.WeaponBase'
local WeaponBase = lua_declare(strClassName, lua_class(strClassName))

function WeaponBase:ctor(owner)
	self.owner = owner

	self.boxColliders = {}
	self.rayDir = Vector3(0, 1, 0)
	self.weaponSlots = self.owner.gameObject:GetComponentsInChildren(WeaponSlot)
	for i=1,#self.weaponSlots do
		local slotGameObject = self.weaponSlots[i].gameObject
		local boxCollider = slotGameObject:GetComponent(BoxCollider)
		table.insert(self.boxColliders, boxCollider)
	end

	self.bulletSpace = 0.5
	self.defaultBulletLogic = {logic="BulletBase"}
end

function WeaponBase:Update(deltaTime)
	--如果是近攻，则需要进行碰撞检测
	if self.checkCollider then
		for i=1,#self.boxColliders do
			local box = self.boxColliders[i]
			local tf = box.gameObject.transform
			local center = tf:TransformPoint(box.center)
			local halfExtents = (self.owner.transform.localScale.x * box.size) * 0.5
			local layer = GameUtil.CullingLayer(LayerManager.Player)
			local hitArray = GameUtil.BoxCastAll(center, halfExtents, self.rayDir, tf.rotation, 0, layer)
			for n=1,#hitArray do
				local hit = hitArray[n]
				if hit.collider ~= nil and hit.collider.gameObject ~= nil then
					local hitObj = hit.collider.gameObject
					if hitObj ~= self.owner.gameObject and hitObj ~= box.gameObject then
						if hitObj.layer == LayerManager.Player then
							self:TriggerExtra(hit)
						end
					end
				end
			end
		end
	end
end

function WeaponBase:TriggerExtra(rayHit)
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
			if not self.targetEntities[entity] then
				entity:OnDamage(self.owner)
				self.targetEntities[entity] = true
			end
		end
	end
end

function WeaponBase:GetBulletCreatePosition()
	local weaponData = self.owner.entityData:GetWeaponData()
	if weaponData ~= nil and weaponData.position ~= nil then
		if weaponData.position == 20 then
			return self.targetEntity:GetBulletCreateNode().position
		end
	end
	local node = self.owner:GetBulletCreateNode()
	return node.position
end

function WeaponBase:SetAttackTarget(entity)
	self.targetEntity = entity
end

function WeaponBase:RemoveAttackTarget(entity)
	if self.targetEntity == entity then
		self.targetEntity = nil
	end
end

function WeaponBase:OnShortAttackStart()
	self.targetEntities = {}
	self.checkCollider = true
	self:Update(0)
end

function WeaponBase:OnShortAttackEnd()
	self.checkCollider = false
	self.targetEntities = {}
end

function WeaponBase:OnAttack(attackEndCallback)
	local localPosition = self.owner.transform:InverseTransformPoint(self:GetBulletCreatePosition())
	self:CreateBullets(localPosition)
	if self.owner.entityData.bulletContinue > 0 then
		local coroutine = OzCoroutine(self.owner.gameObject)
		local co = coroutine:create(function()
			for i=1,self.owner.entityData.bulletContinue do
				yield(WaitForSeconds(0.1))
				self:CreateBullets(localPosition)
			end
			if attackEndCallback ~= nil then
				attackEndCallback()
			end
			coroutine:clear()
			coroutine:destroy()
		end)
		coroutine:resume(co)
	else
		if attackEndCallback ~= nil then
			attackEndCallback()
		end
	end
end

function WeaponBase:CreateBullet(position, rotationOffset)
	local weaponData = self.owner.entityData:GetWeaponData()
	if weaponData == nil then
		return
	end
	if self.targetEntity == nil or self.targetEntity:IsDead() then
		return
	end
	local bulletName = weaponData.bulletName
	if rotationOffset == nil then rotationOffset = 0 end
	local bullet = ObjectPool.Spawn(LuaGameUtil.GetBulletAbName(bulletName))
	local bulletTransform = bullet.transform
	GameUtil.SetLayer(bulletTransform, LayerManager.Bullet)
	local worldPos =  self.owner.transform:TransformPoint (position)
	bulletTransform.position = worldPos
	bulletTransform.rotation = Quaternion.Euler(0, self.owner.transform.eulerAngles.y + rotationOffset, 0)

	local bulletLogic = weaponData.bulletLogic
	if bulletLogic == nil then
		bulletLogic = self.defaultBulletLogic
	end
	local bulletCtrl = LuaGameUtil.DoFile(bullet, "game.bullet." .. bulletLogic.logic)
	bulletCtrl:Init(self.owner, bulletLogic.args)
	bulletCtrl:Fire(self.targetEntity)
end

function WeaponBase:CreateBullets(position)
	if self.owner.entityData.bulletRound > 0 then
		self:CreateBulletRound(self.owner.entityData.bulletRound, position)
	elseif self.owner.entityData.bulletTurbine > 0 then
		self:CreateBulletTurbine(self.owner.entityData.bulletTurbine, position)
	else
		self:CreateBulletForward(self.owner.entityData.bulletForward, position)
		self:CreateBulletBackward(self.owner.entityData.bulletBackward, position)
		self:CreateBulletSide(self.owner.entityData.bullet4Side, position)
		self:CreateBulletLeftRight(self.owner.entityData.bulletSide, position)
	end
end

function WeaponBase:CreateBulletRound(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	localPosition.x = 0
	localPosition.z = 0
	local preAngle = 360 / count
	local bulletDir = Vector3.forward
	local rotateQuate = Quaternion.AngleAxis(preAngle, Vector3.up)
	local radius = 0.6
	for i=1,count do
		self:CreateBullet(localPosition + bulletDir * radius, preAngle * (i-1))
		bulletDir = rotateQuate * bulletDir 
	end
end

function WeaponBase:CreateBulletTurbine(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	localPosition.x = 0
	localPosition.z = 0
	local preAngle = 360 / count
	local bulletDir = Vector3.forward
	local rotateQuate = Quaternion.AngleAxis(preAngle, Vector3.up)
	local radius = 0.1
	local coroutine = OzCoroutine(self.owner.gameObject)
	local co = coroutine:create(function()
		for i=1,count do
			self:CreateBullet(localPosition + bulletDir * radius, preAngle * (i-1))
			yield(WaitForSeconds(0.02))
			--yield(nil)
			bulletDir = rotateQuate * bulletDir 
			radius = radius + 0.2
		end
		coroutine:clear()
		coroutine:destroy()
	end)
	coroutine:resume(co)
end

function WeaponBase:CreateBulletForward(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	local halfDistance = self.bulletSpace * (count - 1) * 0.5
	for i=1,count do
		local offset = Vector3( (i -1) * self.bulletSpace - halfDistance, 0, 0)
		self:CreateBullet(localPosition + offset)
	end
end

function WeaponBase:CreateBulletBackward(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	local halfDistance = self.bulletSpace * (count - 1) * 0.5
	for i=1,count do
		local offset = Vector3( (i -1) * self.bulletSpace - halfDistance, 0, 0)
		self:CreateBullet(localPosition + offset, 180)
	end
end

function WeaponBase:CreateBulletSide(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	local angle = 90 / (count + 1)
	for i=1,count do
		local rotation = (-angle * i)
		self:CreateBullet(localPosition, rotation)
	end
	for i=1,count do
		local rotation = angle * i
		self:CreateBullet(localPosition, rotation)
	end
end

function WeaponBase:CreateBulletLeftRight(count, localPosition)
	if count == nil or count <= 0 then
		return
	end
	local halfDistance = self.bulletSpace * (count - 1) * 0.5
	for i=1,count do
		local offset = Vector3(0, 0, (i-1) * self.bulletSpace - halfDistance)
		self:CreateBullet(localPosition + offset, 90)
	end
	for i=1,count do
		local offset = Vector3(0, 0, (i-1) * self.bulletSpace - halfDistance)
		self:CreateBullet(localPosition + offset, -90)
	end
end

return WeaponBase
