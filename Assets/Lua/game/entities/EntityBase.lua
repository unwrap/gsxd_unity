
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.EntityBase
--date:2019/9/23 15:37:56
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local EntityData = require("game.entities.data.EntityData")
local MoveControl = require("game.entities.ctrl.MoveControl")
local BuffController = require("game.entities.ctrl.BuffController")
local AnimationCtrlBase = require("game.entities.ctrl.AnimationCtrlBase")
local WeaponBase = require("game.weapon.WeaponBase")
local HealthBarCtrl = require("game.entities.ctrl.HealthBarCtrl")
local EntityHitCtrl = require("game.entities.ctrl.EntityHitCtrl")
local EntityLineCtrl = require("game.entities.ctrl.EntityLineCtrl")

local strClassName = 'game.entities.EntityBase'
local EntityBase = lua_declare(strClassName, lua_class(strClassName))
EntityBase.Type_Invalid = 0
EntityBase.Type_Hero = 1
EntityBase.Type_Monster = 2

function EntityBase:Start()
	self.entityData = EntityData(self)
	self.entityType = EntityBase.Type_Invalid

	self.anim = self.gameObject:GetComponent(Animator)
	self.rb = self.gameObject:GetComponent(Rigidbody)
	self.effectPoint = self.transform:Find("EffectPoint")
	self.topPoint = self.transform:Find("TopPoint")
	self.bulletPoint = self.transform:Find("BulletPoint")
	self.bornPosition = self.transform.position
	
	self.hitCtrl = EntityHitCtrl(self)
	self.buffCtrl = BuffController(self)
	self.weaponCtrl = WeaponBase(self)
	self.lineCtrl = EntityLineCtrl(self)

	self.isReady = false
	self.isAttacking = false

	--保持瞄准目标
	self.aimTarget = true

	OzMessage:addEvent(CommonEvent.PauseStateChange, self.OnPauseStateChange, self)
end

function EntityBase:OnDestroy()
	OzMessage:removeEvent(CommonEvent.PauseStateChange, self.OnPauseStateChange, self)

	if self.lineCtrl ~= nil then
		self.lineCtrl:OnDestroy()
		self.lineCtrl = nil
	end
end

function EntityBase:SetReady(val)
	self.isReady = val
end

function EntityBase:SetCharacter(cfgChar, attackInc, maxHPInc, bodyHitInc)
	self.cfgChar = cfgChar
	self.entityData:SetCharacter(self.cfgChar, attackInc, maxHPInc, bodyHitInc)

	self.rb.mass = self.entityData:GetBodyMass()

	local scale = self.cfgChar.scale
	if scale == nil then scale = 1 end
	self.transform.localScale = Vector3(scale, scale, scale)

	self:CreateMoveCtrl()

	self.healthBar = HealthBarCtrl(self)
	self:SetHealthBar()

	if self.animCtrl ~= nil then
		self.animCtrl:SetAnimStateConfig(self.entityData:GetStateCfg())
		self.animCtrl:SetAnimController(self.cfgChar.animState)
	end

	local brainName = self.cfgChar.aiLogic
	if brainName == nil then
		brainName = "BrainMonster"
	end
	local BrainClass = require("game.brains." .. brainName)
	self.brain = BrainClass.new(self)
	self.brain:Start()
end

function EntityBase:IsSelf()
	return self == GameBattleManager.Instance().myself
end

function EntityBase:GetIsMoving()
	if self.moveCtrl ~= nil then
		return self.moveCtrl:GetIsMoving()
	end
	return false
end

function EntityBase:IsColliderTrigger()
	if self.hitCtrl ~= nil then
		return self.hitCtrl:IsColliderTrigger()
	end
	return false
end

function EntityBase:CreateMoveCtrl()
	self.moveCtrl = MoveControl(self)
end

function EntityBase:MoveTo(pos)
	if self.moveCtrl ~= nil then
		self.moveCtrl:MoveTo(pos)
	end
end

function EntityBase:ForceMove(speed)
	if self.moveCtrl ~= nil then
		self.moveCtrl:ForceMove(speed)
	end
end

function EntityBase:Jump(jumpSpeed)
	if self.moveCtrl ~= nil then
		self.moveCtrl:Jump(jumpSpeed)
	end
end

function EntityBase:SetHealthBar()
	if self.healthBar ~= nil then
		self.healthBar:SetHP(self.entityData.hp, self.entityData:GetEntityMaxHP())
	end
end

function EntityBase:ShowLine(rebound)
	if self.lineCtrl ~= nil then
		self.lineCtrl:Show(rebound)
	end
end

function EntityBase:HideLine()
	if self.lineCtrl ~= nil then
		self.lineCtrl:Hide()
	end
end

function EntityBase:StopAimTarget()
	self.aimTarget = false
end

function EntityBase:GetBulletCreateNode()
	if self.bulletPoint ~= nil then
		return self.bulletPoint
	end
	if self.effectPoint ~= nil then
		return self.effectPoint
	end
	return self.transform
end

function EntityBase:SetSpeed(val)
	if self.animCtrl ~= nil then
		self.animCtrl:SetSpeed(val)
	end
end

function EntityBase:SetAttackTarget(entity)
	self.attackTarget = entity
	if self.attackTarget == nil then
		return
	end
	self.weaponCtrl:SetAttackTarget(self.attackTarget)
	if self.moveCtrl ~= nil then
		self.moveCtrl:SetAttackTarget(self.attackTarget)
	end	
end

function EntityBase:GetAttackTarget()
	if self.attackTarget == nil then
		
	end
	return self.attackTarget
end

function EntityBase:RemoveAttackTarget(entity)
	if self.attackTarget == entity then
		self.attackTarget = nil
	end
	if self.weaponCtrl ~= nil then
		self.weaponCtrl:RemoveAttackTarget(entity)
	end
end

function EntityBase:DoAttack(triggerName)
	self.attackActionName = triggerName
end

--攻击动作完成
function EntityBase:OnAttackEnd()
	self.isAttacking = false
	self.aimTarget = true
	if self.animCtrl ~= nil then
		self.animCtrl:CleanAttackFlag(self.attackActionName)
	end
end

--近距离攻击开始
function EntityBase:OnShortAttackStart()
	self.weaponCtrl:OnShortAttackStart()
end

function EntityBase:OnShortAttackEnd()
	self.weaponCtrl:OnShortAttackEnd()
end

function EntityBase:CheckTarget(distance)
	return true
end

function EntityBase:OnWeaponAttack(weaponid, skills)
	self:HideLine()
	if not self:IsSelf() then
		self:StopAimTarget()
	end
	if not self:GetIsMoving() then
		self.entityData:SetOnceWeapon(weaponid, skills)
		local attackEnd = function()
			self.entityData:CleanOnceWeapon()
		end
		self.weaponCtrl:OnAttack(attackEnd)
	end
end

function EntityBase:OnBodyHit(attacker)
	if self:IsDead() then
		return
	end
	local dmg = attacker.entityData:GetEntityBodyHit()
	if dmg > 0 then
		self:PlayEffect("MagicSwordHitRed")	
		self.entityData:OnDamage(dmg)
		GameBattleManager.Instance():CreateDamageText(dmg, self, CommonUtil.hitType_body)
		self:SetHealthBar()
		if self:IsDead() then
			self.animCtrl:DoDeath()
			self.moveCtrl:StopMove()
		end
	end
end

--需要在子弹生成的同时,决定伤害
--因为避免子弹飞行的过程中,有可能自身的数值会发生变化,从而导致最后的伤害计算不正确
function EntityBase:CreateDamage()
	local headShot = self.entityData:CheckHeadShot()
	local crit = self.entityData:CheckCrit()
	local dmg = self.entityData:GetEntityAttack(crit)
	return dmg, headShot, crit
end

function EntityBase:DoDamage(dmg, headShot, crit)
	if self:IsDead() then
		return
	end
	if headShot then
		dmg = self.entityData.hp
		GameBattleManager.Instance():ShakeCamera(5)
		GameBattleManager.Instance():CreateDamageText(dmg, self, CommonUtil.hitType_headShot)
	elseif crit then
		GameBattleManager.Instance():CreateCriticalText(dmg, self)
	else
		GameBattleManager.Instance():CreateDamageText(dmg, self, CommonUtil.hitType_normal)
	end

	self:PlayEffect("MagicSwordHitRed")	
	self.entityData:OnDamage(dmg)
	self:SetHealthBar()
	if self:IsDead() then
		self.animCtrl:DoDeath()
		self.moveCtrl:StopMove()
	end
end

function EntityBase:OnDamage(attacker)
	local dmg, headShot, crit = attacker:CreateDamage()
	self:DoDamage(dmg, headShot, crit)
end

--击退
function EntityBase:Knockback(hitDir, backRatio)
	if not self:IsSelf() then
		self.moveCtrl:Knockback(hitDir, backRatio)
	end
end

--死亡动作播放完成
function EntityBase:OnDeadEnd()
	if self.healthBar ~= nil then
		self.healthBar:Remove()
		self.healthBar = nil
	end
end

function EntityBase:OnRemove()
	if self.healthBar ~= nil then
		self.healthBar:Remove()
		self.healthBar = nil
	end
	self.this:CleanLuaTable()
	ObjectPool.Recycle(self.gameObject)
end

function EntityBase:GetEffectPoint()
	if self.effectPoint ~= nil then
		return self.effectPoint.position
	end
	return self.transform.position
end

function EntityBase:GetPosition()
	return self.transform.position
end

function EntityBase:GetTopPosition()
	if self.topPoint ~= nil then
		local pos = self.topPoint.position
		--pos.y = pos.y + 0.5
		return pos
	end
	return self.transform.position + Vector3(0, 1, 0)
end

function EntityBase:GetBornPosition()
	return self.bornPosition
end

function EntityBase:AddSkill(skillID)
	return self.entityData:AddSkill(skillID)
end

function EntityBase:RemoveSkill(skillData)
	self.entityData:RemoveSkill(skillData)
end

function EntityBase:RemoveAllSkill()
	self.entityData:RemoveAllSkill()
end

function EntityBase:AddBuff(buffID, attacker)
	if self.buffCtrl ~= nil then
		self.buffCtrl:AddBuff(buffID, attacker)
	end
end

function EntityBase:RemoveBuff(buffID)
	if self.buffCtrl ~= nil then
		self.buffCtrl:RemoveBuff(buffID)
	end
end

function EntityBase:IsValid()
	return true
end

function EntityBase:IsDead()
	if self.entityData.hp <= 0 then
		return true
	end
	return false
end

function EntityBase:PlayEffect(effectName)
	if effectName == nil then
		return
	end
	local obj = ObjectPool.Spawn(LuaGameUtil.GetEffectAbName(effectName))
	if obj == nil then
		return
	end
	local objTransform = obj.transform
	objTransform:SetParent(self.transform)
	objTransform.position = self:GetEffectPoint()
	GameUtil.SetLayer(objTransform, self.gameObject.layer)

	local effect = obj:GetComponent(EffectController)
	if effect ~= nil then
		effect:Play()
	end
	return effect
end

--Event

function EntityBase:AddEventListener(eventName, listener, target)
	assert(type(eventName) == "string" or eventName ~= "", "invalid event name")

	if not listener then
        return
    end

	if not self.eventDict then
		self._eventDict = {}
	end

	local listeners = self._eventDict[eventName] or {}
	self._eventDict[eventName] = listeners

	for _,v in iparis(listeners) do
		if v.listener == listener then
			return
		end
	end

	local event = OzEventData.new()
	event.listener = listener
	event.name = eventName
	event.target = target

	table.insert(listeners, event)
end

function EntityBase:RemoveEventListener(eventName, listener)
	if not self._eventDict then
		return
	end
	local listeners = self._eventDict[eventName]
	if not listeners then
		return
	end
	for i, event in ipairs(listeners) do
        if event.listener == listener then
            table.remove(listeners, i)
            break
        end
    end
end

function EntityBase:DispatchEvent(eventName, ...)
	if not self._eventDict then
		return
	end
	local listeners = self._eventDict[eventName]
    if not listeners then
        return
    end
	for _, v in ipairs(listeners) do
        local callback = v.listener
        if v.target then
            callback(v.target, ...)
        else
            callback(...)
        end
    end
end

function EntityBase:RemoveAllEvent(eventName)
	if not self._eventDict then
		return
	end
    self._eventDict[eventName] = nil
end

---end event

function EntityBase:OnPauseStateChange()
	if self.animCtrl ~= nil then
		self.animCtrl:SetPause(LuaGameUtil.IsPaused())
	end
end

function EntityBase:Update()
	if LuaGameUtil.IsPaused() then
		return
	end
	local deltaTime = Time.deltaTime
	if self.healthBar ~= nil then
		self.healthBar:Update(deltaTime)
	end
	if self.moveCtrl ~= nil then
		self.moveCtrl:Update(deltaTime)

		if self.isAttacking and not self:IsDead() and self.aimTarget then
			self.moveCtrl:SetAttackTarget(self.attackTarget)
		end
	end
	if self.buffCtrl ~= nil then
		self.buffCtrl:Update(deltaTime)
	end
	if self.lineCtrl ~= nil then
		self.lineCtrl:Update(deltaTime)
	end
end

function EntityBase:LateUpdate()
	if LuaGameUtil.IsPaused() then
		return
	end
	local deltaTime = Time.deltaTime
	if self.weaponCtrl ~= nil then
		self.weaponCtrl:Update(deltaTime)
	end
	if self.moveCtrl ~= nil then
		self.moveCtrl:LateUpdate()
	end
end

function EntityBase:OnTriggerEnter(o)
	--print("OnTriggerEnter")
end

function EntityBase:OnTriggerExit(o)
	--print("OnTriggerExit")
end

function EntityBase:OnCollisionEnter(o)
	--print("OnCollisionEnter")
end

function EntityBase:OnCollisionExit(o)
	--print("OnCollisionExit")
end

return EntityBase
