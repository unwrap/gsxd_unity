
---------------------------------------------------------------------------------------------------
--
--filename: game.bullet.BulletBomb
--date:2019/11/4 15:31:04
--author:heguang
--desc:爆炸类子弹
--
---------------------------------------------------------------------------------------------------
local BulletBase = require("game.bullet.BulletBase")

local strClassName = 'game.bullet.BulletBomb'
local BulletBomb = lua_declare(strClassName, lua_class(strClassName, BulletBase))

function BulletBomb:Start()
	BulletBomb.super.Start(self)
	self.effectCtrl = self.gameObject:GetComponent(EffectController)
end

function BulletBomb:OnInit(args)
	self.bombArgs = args
	if self.bombArgs ~= nil then
		self.startCheckTime = self.bombArgs.startTime
		self.endCheckTime = self.bombArgs.endTime
		self.checkTickTime = self.bombArgs.tick
	end
	if self.startCheckTime == nil then
		self.startCheckTime = 0
	end
	self.targetEntities = {}
end

function BulletBomb:OnFire(entity)
	self.aliveTime = math.max(self.effectCtrl.EffectTime, self.aliveTime)
	if self.endCheckTime == nil then
		self.endCheckTime = self.aliveTime
	end
	if self.checkTickTime == nil then
		self.checkTickTime = self.endCheckTime - self.startCheckTime
	end
	self.checkAliveTime = true
	self.aliveTimer = 0
	self.isAlive = true
end

function BulletBomb:Update()
	if LuaGameUtil.IsPaused() then
		return
	end

	local deltaTime = Time.deltaTime

	if self.checkAliveTime then
		self.aliveTimer = self.aliveTimer + deltaTime
		if self.aliveTimer > self.aliveTime then
			self.checkAliveTime = false
			self.checkCollider = false
			self:OnMoveEnd()
		else
			if self.aliveTimer >= self.endCheckTime then
				self.checkCollider = false
			elseif self.aliveTimer >= self.startCheckTime then
				if not self.checkCollider then
					self.targetEntities = {}
				end
				self.checkCollider = true
			end
		end
	end

	if self.checkCollider then
		self:CheckTriggerObject(0)
	end
end

function BulletBomb:DoCheckTriggerObject(frameDistance)
	if self.currentFrame ~= Time.frameCount then
		self.triggerHits = nil
		self.beforeHit = frameDistance
		local layer = GameUtil.CullingLayer(LayerManager.MapOutWall, LayerManager.Player, LayerManager.Obstruct)
		if self.boxListCount > 0 then
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
			self.triggerHits = GameUtil.SphereCastAll(origin, radius, self.moveDirection, frameDistance + self.beforeHit, layer)
		elseif self.capsuleListCount > 0 then
			local capsule = self.capsuleList[1]
			local point1 = self.transform.position + ( (self.triggerTestVector * (capsule.height - 1)) * 0.5 ) - self.moveDirection * self.beforeHit
			local point2 = self.transform.position - ( (self.triggerTestVector * (capsule.height - 1)) * 0.5 ) - self.moveDirection * self.beforeHit
			local radius = self.transform.localScale.x * capsule.radius
			self.triggerHits = GameUtil.CapsuleCastAll(point1, point2, radius, self.moveDirection.normalized, frameDistance + self.beforeHit, layer)
		end

		if self.triggerHits ~= nil then
			for i=1, #self.triggerHits do
				local hit = self.triggerHits[i]
				if hit.collider ~= nil and hit.collider.gameObject ~= nil then
					local hitObj = hit.collider.gameObject
					if hitObj ~= self.owner.gameObject and hitObj ~= self.gameObject then
						self:TriggerEnter(hit)
					end
				end
			end
			self.currentFrame = Time.frameCount
		end
	end
end

function BulletBomb:TriggerExtra(rayHit)
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
			local entityCheckTime = self.targetEntities[entity]
			if (entityCheckTime == nil) or (entityCheckTime + self.checkTickTime <= Time.realtimeSinceStartup) then
				entity:DoDamage(self.dmg, self.headShot, self.crit)
				self.targetEntities[entity] = Time.realtimeSinceStartup
			end
		end
	end
end

return BulletBomb
