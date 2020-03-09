
---------------------------------------------------------------------------------------------------
--
--filename: game.LuaGameManager
--date:2019/11/21 15:11:13
--author:heguang
--desc:游戏全局管理类
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.LuaGameManager'
local LuaGameManager = lua_declare(strClassName, lua_class(strClassName))

function LuaGameManager:Start()
	GameNetMgr:Init()
	OzMessage:addEvent(CommonEvent.ShowGMPanel, self.ShowGM, self)
end

function LuaGameManager:OnDestroy()
	OzMessage:removeEvent(CommonEvent.ShowGMPanel, self.ShowGM, self)
	GameNetMgr:OnDestroy()
end

function LuaGameManager:Update()
	Dialog.Update()
end

function LuaGameManager:OnApplicationPause(pauseStatus)
	if not pauseStatus then
		OzMessage:dispatchEvent(CommonEvent.ShowPausePanel)
	end
end

function LuaGameManager:OnApplicationQuit()
end

function LuaGameManager:ShowGM()
	local canCreate = true -- GameUtil.IsEditor
	if canCreate then
		local console = AssetBundleManager.InstantiateGameObject("ui/debugconsole.u3d","DebugConsole")
		UIManager.Instance:AddAlert(console)
		local tf = console.transform
		tf.offsetMax = Vector2.zero
		tf.offsetMin = Vector2.zero
		tf.anchorMin = Vector2.zero
		tf.anchorMax = Vector2.one
	end
end

return LuaGameManager
