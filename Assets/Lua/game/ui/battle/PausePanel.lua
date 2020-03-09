
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.PausePanel
--date:2019/11/21 16:21:51
--author:heguang
--desc:暂停面板
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.PausePanel'
local PausePanel = lua_declare(strClassName, lua_class(strClassName))

function PausePanel:Start()
	local btnContinue = self.transform:Find("ButtonContinue")
	if btnContinue ~= nil then
		EventListener.Get(btnContinue, self).onClick = self.ContinuePlayHandler
	end

	local btnHome = self.transform:Find("ButtonHome")
	if btnHome ~= nil then
		EventListener.Get(btnHome, self).onClick = self.GoHomeHandler
	end

	LuaGameUtil.SetPause(true)
end

function PausePanel:OnDestroy()
	LuaGameUtil.SetPause(false)
end

function PausePanel:GoHomeHandler()
	Dialog.Hide()
	LuaGameUtil.LoadHomeScene()
end

function PausePanel:ContinuePlayHandler()
	Dialog.Hide()
end

return PausePanel
