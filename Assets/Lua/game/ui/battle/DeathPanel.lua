
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.DeathPanel
--date:2019/11/21 10:45:57
--author:heguang
--desc:死亡
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.DeathPanel'
local DeathPanel = lua_declare(strClassName, lua_class(strClassName))

function DeathPanel:Start()
	local btnClose = self.transform:Find("ButtonClose")
	if btnClose ~= nil then
		EventListener.Get(btnClose, self).onClick = self.GoHomeHandler
	end

	local btnHome = self.transform:Find("ButtonHome")
	if btnHome ~= nil then
		EventListener.Get(btnHome, self).onClick = self.GoHomeHandler
	end
end

function DeathPanel:GoHomeHandler()
	LuaGameUtil.LoadHomeScene()
end

function DeathPanel:ReplayHandler()
	
end

return DeathPanel
