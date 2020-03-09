
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.EntityMonster
--date:2019/9/30 9:47:36
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local EntityBase = require("game.entities.EntityBase")
local AnimationMonsterCtrl = require("game.entities.ctrl.AnimationMonsterCtrl")

local strClassName = 'game.entities.EntityMonster'
local EntityMonster = lua_declare(strClassName, lua_class(strClassName, EntityBase))

function EntityMonster:Start()
	EntityMonster.super.Start(self)
	self.entityType = EntityBase.Type_Monster
	
	self.animCtrl = AnimationMonsterCtrl(self, self.anim, self.rb)

	self.isMoving = false

	self.isCheckDead = false
	self.deadTimer = 0

	self.isInTrigger = false
	self.triggerTimer = 0
	self.triggerTime = 1.2
end

function EntityMonster:SetMoveDirection(x, y)
	self.direction.x = x
	self.direction.z = y
end

function EntityMonster:DoAttack(triggerName)
	EntityMonster.super.DoAttack(self, triggerName)

	local targetEntity = GameBattleManager.Instance().entityMgr.myself
	if targetEntity:IsDead() then
		self:OnAttackEnd()
		return
	end

	self.isAttacking = true
	self:SetAttackTarget(targetEntity)
	self.animCtrl:DoAttack(triggerName)
end

function EntityMonster:CheckTarget(distance)
	if GameBattleManager.Instance() == nil then
		return false
	end
	local targetEntity = GameBattleManager.Instance().entityMgr.myself
	local dis = Vector3.Distance(self:GetPosition(), targetEntity:GetPosition())
	return dis <= distance
end

function EntityMonster:DoDamage(dmg, headShot, crit)
	EntityMonster.super.DoDamage(self, dmg, headShot, crit)
	
	if not self:IsDead() then
		self.animCtrl:DoDamage()
	end

end

--死亡动作播放完成
function EntityMonster:OnDeadEnd()
	EntityMonster.super.OnDeadEnd(self)
	GameBattleManager.Instance().entityMgr:RemoveEntity(self)
	GameBattleManager.Instance():CreateNextWaveMonsters()
	self.isCheckDead = true
	self.deadTimer = 0
end

function EntityMonster:Update()
	if LuaGameUtil.IsPaused() then
		return
	end

	EntityMonster.super.Update(self)

	if self.isCheckDead then
		self.deadTimer = self.deadTimer + Time.deltaTime
		if self.deadTimer >= 2 then
			self.isCheckDead = false
			self:OnRemove()
		end
	end

	if self.brain and self.isReady and not self:IsDead() then
		self.brain:Update()
	end

	self.animCtrl:Update()

	if self.isReady and (not self:IsDead()) then
		self:TriggerUpdate()
	end
end

function EntityMonster:OnTriggerEnter(o)
	if self:IsColliderTrigger() then
		self:TriggerEnter(o.gameObject)
	end
end

function EntityMonster:OnTriggerExit(o)
	if self:IsColliderTrigger() then
		self:TriggerExit(o.gameObject)
	end
end

function EntityMonster:OnCollisionEnter(o)
	self:TriggerEnter(o.gameObject)
end

function EntityMonster:OnCollisionExit(o)
	self:TriggerExit(o.gameObject)
end

function EntityMonster:TriggerEnter(go)
	local layer = go.layer
	if layer == LayerManager.Player then
		local entity = GameBattleManager.Instance().entityMgr:FindEntity(go)
		if entity ~= nil and not LuaGameUtil.IsSameTeam(entity, self) then
			if self.triggerEntity == nil or self.triggerEntity ~= entity then
				self.triggerTimer = self.triggerTime
			end
			self.triggerEntity = entity
			self:TriggerStart()
		end
	end
end

function EntityMonster:TriggerExit(go)
	if self.triggerEntity ~= nil and go == self.triggerEntity.gameObject then
		self:TriggerEnd()
	end
end

function EntityMonster:TriggerStart()
	self.isInTrigger = true
end

function EntityMonster:TriggerEnd()
	self.isInTrigger = false
end

function EntityMonster:TriggerUpdate()
	if self.triggerEntity ~= nil then
		if self.triggerEntity:IsDead() then
			self:TriggerEnd()
			self.triggerEntity = nil
		else
			self.triggerTimer = self.triggerTimer + Time.deltaTime
			if self.triggerTimer >= self.triggerTime then
				if self.isInTrigger then
					self.triggerTimer = 0
					self.triggerEntity:OnBodyHit(self)
				end
			end
		end
	end
end

return EntityMonster
