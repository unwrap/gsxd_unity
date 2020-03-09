
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.battle.BattleMain
--date:2019/11/29 18:05:53
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.battle.BattleMain'
local BattleMain = lua_declare(strClassName, lua_class(strClassName))

function BattleMain:Start()
	local btnPause = self.transform:Find("ButtonPause")
	EventListener.Get(btnPause, self).onClick = self.ShowPausePanel
end

function BattleMain:ShowPausePanel()
	OzMessage:dispatchEvent(CommonEvent.ShowPausePanel)
end

return BattleMain
