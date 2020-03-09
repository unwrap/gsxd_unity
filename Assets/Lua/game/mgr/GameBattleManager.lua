
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.GameBattleManager
--date:2019/10/7 7:41:00
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local EntityManager = require("game.mgr.EntityManager")
local MapManager = require("game.mgr.MapManager")

local strClassName = 'GameBattleManager'
local GameBattleManager = lua_declare(strClassName, lua_class(strClassName))
GameBattleManager.m_instance = nil

function GameBattleManager:ctor()
	if GameBattleManager.m_instance then
		error("You have already create a GameBattleManager instance!")
		return
	end
	GameBattleManager.m_instance = self
	OzUpdater.Instance():RegisterUpdate(self, true)

	self.allSkills = {}
	for _,skill in pairs(cfg_skill) do
		if skill.skillID > 5000 and skill.skillID < 6000 then
			table.insert(self.allSkills, skill)
		end
	end

	self:AddEventListener()
end

function GameBattleManager:OnDestroy()
	self.entityMgr:Release()
	if self.mapMgr ~= nil then
		self.mapMgr:OnDestroy()
	end
	OzUpdater.Instance():RegisterUpdate(self)
	self:RemoveEventListener()
	GameBattleManager.m_instance = nil
end

function GameBattleManager.Instance()
	return GameBattleManager.m_instance
end

function GameBattleManager:AddEventListener()
	OzMessage:addEvent(CommonEvent.ShowPausePanel, self.ShowPausePanel, self)
end

function GameBattleManager:RemoveEventListener()
	OzMessage:removeEvent(CommonEvent.ShowPausePanel, self.ShowPausePanel, self)
end

function GameBattleManager:Random3Skill()
	local skills = {}
	for i=1,3 do
		if #self.allSkills > 0 then
			local r = LuaMath.Random(1, #self.allSkills)
			table.insert(skills, self.allSkills[r])
			table.remove(self.allSkills, r)
		end
	end
	return skills
end

function GameBattleManager:LoadScene(mapId)
	--LuaGameUtil.LoadLevel("showcase")
	GlobalData:EnterMap(mapId)
	self.roomData = GlobalData.roomData
	local mapName = self.roomData:GetCurrentMap()
	LuaGameUtil.LoadLevel(mapName, true)
end

function GameBattleManager:EnterScene()
	self.isShowPause = false
	self.isShowSelectSkill = false

	--[[
	local coroutine = OzCoroutine(self.gameObject)
	local co = coroutine:create(function()
		coroutine:clear()  --supprot clear
		coroutine:destroy()  --only destroy LuaCoroutine MonoBehaviour
	end)
	coroutine:resume(co)
	--]]

	self:CreateBattleUI()
	self:CreateMap()
	self:CreateEntity()
	self:CreateCamera()	

	self:ShowSelectSkill()
end

function GameBattleManager:ShowSelectSkill()
	if self.isShowSelectSkill then
		return
	end

	if self.entityMgr ~= nil then
		self.entityMgr:BattleStop()
	end
	self.isShowSelectSkill = true
	self.checkNextWaveMonsters = false
	self.nextWaveMonstersTimer = 0
	OzMessage:dispatchEvent(CommonEvent.UpdateNextWaveMonsterTime, self.nextWaveMonstersTimer)

	local skills = self:Random3Skill()
	local go = AssetBundleManager.InstantiateGameObject("battle/selectskill.u3d", "SelectSkill")
	local luaMono = LuaGameUtil.DoFile(go, "game.ui.battle.SelectSkill")
	luaMono:SetSkills(skills)
	Dialog.Show(go)
end

function GameBattleManager:BattleStart(skill)
	self.isShowSelectSkill = false
	if self.myself ~= nil then
		self.myself:AddSkill(skill.skillID)
	end
	if self.entityMgr ~= nil then
		self:CreateMonster()
	end
end

--重置下一波怪刷新的时间
function GameBattleManager:CreateMonster()
	if self.entityMgr ~= nil then
		local ret, nextTime = self.entityMgr:CreateMonster()
		if nextTime > 0 then
			self.checkNextWaveMonsters = true
			self.nextWaveMonstersTimer = nextTime
		end
		self.entityMgr:BattleStart()
	end
end

--检查是否开始下一波怪
function GameBattleManager:CreateNextWaveMonsters()
	local enemyNum = self.entityMgr:GetEnemyNum()
	if enemyNum <= 0 then
		local ret = self.entityMgr:CheckCanCreateMonster()
		--没有下一波怪了
		if not ret then
			local go = AssetBundleManager.InstantiateGameObject("battle/victorypanel.u3d", "VictoryPanel")
			local luaMono = LuaGameUtil.DoFile(go, "game.ui.battle.VictoryPanel")
			Dialog.Show(go)
		else
			self:ShowSelectSkill()
		end
	end
end

function GameBattleManager:EnterNextMap()
	local res,mapName = self.roomData:EnterNextMap()
	if res then
		LuaGameUtil.LoadLevel(mapName)
	end
end

function GameBattleManager:IsWalkable(wp)
	if self.mapMgr ~= nil then
		return self.mapMgr:IsWalkable(wp)
	end
	return false
end

function GameBattleManager:CreateBattleUI()
	local obj = AssetBundleManager.InstantiateGameObject("battle/battlemain.u3d", "BattleMain")
	LuaGameUtil.DoFile(obj, "game.ui.battle.BattleMain")
	local objTransform = obj.transform
	objTransform:SetParent(UIManager.Instance.ContentRoot)
	objTransform.offsetMax = Vector2.zero
    objTransform.offsetMin = Vector2.zero
    objTransform.anchorMin = Vector2.zero
    objTransform.anchorMax = Vector2.one
	objTransform.localScale = Vector3.one

	local textContainerObj = GameObject("textContainer")
	self.textContainer = GameUtil.AddComponent(textContainerObj, RectTransform)
	self.textContainer:SetParent(UIManager.Instance.ContentRoot)
	self.textContainer.offsetMax = Vector2.zero
	self.textContainer.offsetMin = Vector2.zero
	self.textContainer.anchorMin = Vector2.zero
	self.textContainer.anchorMax = Vector2.one
	self.textContainer.localScale = Vector3.one
	self.textContainer:SetAsFirstSibling()

	OzMessage:dispatchEvent(CommonEvent.ShowGMPanel)
end

function GameBattleManager:CreateMap()
	local mapObj = GameObject.Find("map")
	if mapObj == nil then
		mapObj = GameObject("map");
		mapObj.transform.localPosition = Vector3.zero
	end
	self.mapMgr = MapManager(mapObj)
end

function GameBattleManager:CreateEntity()
	local entityObj = GameObject.Find("entity")
	if entityObj == nil then
		entityObj = GameObject("entity")
		entityObj.transform.localPosition = Vector3.zero
	end
	self.entityMgr = EntityManager(entityObj, self)
	self.myself = self.entityMgr.myself
end

function GameBattleManager:CreateCamera()
	local cameraFollowObj = GameObject.Find("CameraFollow")
	--self.cameraCtrl = LuaGameUtil.DoFile(cameraFollowObj, "game.camera.PerspectiveCameraFollow")
	self.cameraCtrl = LuaGameUtil.DoFile(cameraFollowObj, "game.camera.CameraFollow")
	--self.cameraCtrl = GameUtil.AddComponent(cameraFollowObj, CameraController)
	if self.myself ~= nil then
		self.cameraCtrl:SetTarget(self.myself.effectPoint)
	end
	local cameraObj = cameraFollowObj.transform:GetChild(0).gameObject
	self.cameraShaker = GameUtil.AddComponent(cameraObj, EZCameraShake.CameraShaker)
	self.cameraCtrl:SetCameraSize(self.mapMgr.width * 0.5, self.mapMgr.length * 0.5)
end

function GameBattleManager:Update()
	--print("***Update GameBattleManager")

	if self.checkNextWaveMonsters then
		self.nextWaveMonstersTimer = self.nextWaveMonstersTimer - Time.deltaTime
		OzMessage:dispatchEvent(CommonEvent.UpdateNextWaveMonsterTime, self.nextWaveMonstersTimer)
		if self.nextWaveMonstersTimer <= 0 then
			self.checkNextWaveMonsters = false
			self:CreateMonster()
		end
	end

end

function GameBattleManager:FindEntity(go)
	return self.entityMgr:FindEntity(go)
end

function GameBattleManager:ShakeCamera(power)
	if self.cameraShaker ~= nil then
		--self.cameraShaker:Shake(EZCameraShake.CameraShakePresets.RoughDrivingFast)
		self.cameraShaker:ShakeOnce(power, 2, 0.1, 0.1)
	end
end

function GameBattleManager:ShowPausePanel()
	if self.isShowPause then
		return
	end
	self.isShowPause = true
	local obj = AssetBundleManager.InstantiateGameObject("battle/pausepanel.u3d", "PausePanel")
	local luaMono = LuaGameUtil.DoFile(obj, "game.ui.battle.PausePanel")
	Dialog.Show(obj, true, function()
		self.isShowPause = false
	end)
end

function GameBattleManager:CreateDamageText(dmg, owner, hitType)
	local localPos = GameUtil.WorldToUIPoint(owner:GetPosition())
	local textObj = ObjectPool.Spawn("effect/damgagetext.u3d","DamgageText")
	local textObjTransform = textObj.transform
	textObjTransform:SetParent(self.textContainer,false)
	textObjTransform.position = localPos
	textObjTransform.localScale = Vector3.one
	dmg = LuaMath.GetIntPart(dmg)
	local luaMono = LuaGameUtil.DoFile(textObj, "game.effect.text.DamageTextController")
	luaMono:SetEntity(owner)
	luaMono:Show(dmg, hitType)
end

function GameBattleManager:CreateCriticalText(dmg, owner)
	local localPos = GameUtil.WorldToUIPoint(owner:GetPosition())
	local textObj = ObjectPool.Spawn("effect/criticaltext.u3d","CriticalText")
	local textObjTransform = textObj.transform
	textObjTransform:SetParent(self.textContainer,false)
	textObjTransform.position = localPos
	textObjTransform.localScale = Vector3.one
	local luaMono = LuaGameUtil.DoFile(textObj, "game.effect.text.CriticalTextController")
	luaMono:SetEntity(owner)
	luaMono:Show(dmg)
end

function GameBattleManager:CreateRecoveryText(val, owner)
	local localPos = GameUtil.WorldToUIPoint(owner:GetPosition())
	local textObj = ObjectPool.Spawn("effect/recoverytext.u3d","RecoveryText")
	local textObjTransform = textObj.transform
	textObjTransform:SetParent(self.textContainer,false)
	textObjTransform.position = localPos
	textObjTransform.localScale = Vector3.one
	local luaMono = LuaGameUtil.DoFile(textObj, "game.effect.text.RecoveryTextController")
	luaMono:SetEntity(owner)
	luaMono:Show(val)
end

return GameBattleManager
