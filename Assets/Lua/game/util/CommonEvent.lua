
---------------------------------------------------------------------------------------------------
--
--filename: game.util.CommonEvent
--date:2019/11/20 9:58:05
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'CommonEvent'
local CommonEvent = lua_declare(strClassName, lua_class(strClassName))

CommonEvent.OnSessionClose = "OnSessionClose"

CommonEvent.OnLogin = "OnLogin"

CommonEvent.ShowSceneTransition = "ShowSceneTransition"
CommonEvent.HideSceneTransition = "HideSceneTransition"

CommonEvent.ShowPausePanel = "ShowPausePanel"
CommonEvent.PauseStateChange = "PauseStateChange"

CommonEvent.MainPageChange = "MainPageChange"

CommonEvent.ShowGMPanel = "ShowGMPanel"

CommonEvent.UpdateNextWaveMonsterTime = "UpdateNextWaveMonsterTime"

return CommonEvent
