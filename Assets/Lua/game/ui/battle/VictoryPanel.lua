
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.VictoryPanel
--date:2019/11/21 10:45:57
--author:heguang
--desc:胜利面板
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.VictoryPanel'
local VictoryPanel = lua_declare(strClassName, lua_class(strClassName))

function VictoryPanel:Start()
	local btnClose = self.transform:Find("ButtonClose")
	if btnClose ~= nil then
		EventListener.Get(btnClose, self).onClick = self.GoHomeHandler
	end

	local btnHome = self.transform:Find("ButtonHome")
	if btnHome ~= nil then
		EventListener.Get(btnHome, self).onClick = self.GoHomeHandler
	end
end

function VictoryPanel:GoHomeHandler()
	LuaGameUtil.LoadHomeScene()
end

function VictoryPanel:ReplayHandler()
	
end

return VictoryPanel
