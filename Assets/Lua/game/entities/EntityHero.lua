
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.EntityHero
--date:2019/9/24 0:19:37
--author:heguang
--desc:主角实体
--
---------------------------------------------------------------------------------------------------
local EntityBase = require("game.entities.EntityBase")
local AnimationHeroCtrl = require("game.entities.ctrl.AnimationHeroCtrl")
local MoveControlHero = require("game.entities.ctrl.MoveControlHero")

local strClassName = 'game.entities.EntityHero'
local EntityHero = lua_declare(strClassName, lua_class(strClassName, EntityBase))

function EntityHero:Start()
	EntityHero.super.Start(self)
	self.entityType = EntityBase.Type_Hero
	self.animCtrl = AnimationHeroCtrl(self, self.anim, self.rb)

	--测试数据
	--self.entityData.bullet4Side = 5
	--self.entityData.bulletSide = 1
	--self.entityData.bulletContinue = 1
	--self:AddSkill(1000001)
	self:SetCharacter(cfg_char[1])

	--self:ShowLine()
end

function EntityHero:CreateMoveCtrl()
	self.moveCtrl = MoveControlHero(self)
end

function EntityHero:DoAttack(triggerName)
	EntityHero.super.DoAttack(self, triggerName)
	
	if GameBattleManager.Instance() == nil then
		return
	end

	local targetEntity = GameBattleManager.Instance().entityMgr:FindTarget()
	if targetEntity == nil or targetEntity:IsDead() then
		self:OnAttackEnd()
		return
	end
	self.isAttacking = true
	self:SetAttackTarget(targetEntity)
	self.animCtrl:DoAttack(triggerName)
end

function EntityHero:CheckTarget(distance)
	local targetEntity = GameBattleManager.Instance().entityMgr:FindTarget()
	local dis = Vector3.Distance(self:GetPosition(), targetEntity:GetPosition())
	return dis <= distance
end

function EntityHero:DoDamage(dmg, headShot, crit)
	EntityHero.super.DoDamage(self, dmg, headShot, crit)
	self.animCtrl:DoDamage()
end

--死亡动作播放完成
function EntityHero:OnDeadEnd()
	EntityHero.super.OnDeadEnd(self)
	local go = AssetBundleManager.InstantiateGameObject("battle/deathpanel.u3d", "DeathPanel")
	local luaMono = LuaGameUtil.DoFile(go, "game.ui.battle.DeathPanel")
	Dialog.Show(go)
end

function EntityHero:OnTriggerEnter(o)
	local go = o.gameObject
	if go == nil then
		return
	end
	local layer = go.layer
	local tag = go.tag
	if layer == LayerManager.Map and tag == "Map_Door" then
		self:TriggerDoor(go)
	end
end

function EntityHero:TriggerDoor(go)
	GameBattleManager.Instance():EnterNextMap()
end

function EntityHero:Update()
	--self.transform:Translate(Vector3(0, 0, 0))
	if LuaGameUtil.IsPaused() then
		return
	end
	EntityHero.super.Update(self)
	self.animCtrl:Update()

	if self.brain and self.isReady and not self:IsDead() then
		self.brain:Update()
	end

	---[[
	--测试，打印最近怪的距离
	if Input.GetButtonDown("Jump") then
		local targetEntity = GameBattleManager.Instance().entityMgr:FindTarget()
		if targetEntity ~= nil then
			local dis = Vector3.Distance(self:GetPosition(), targetEntity:GetPosition())
			print("[最近怪的距离]：" , dis)
		end
		--self:OnWeaponAttack()
	end
	--]]
end

return EntityHero
