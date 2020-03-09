
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.LayerManager
--date:2019/10/7 0:24:36
--author:heguang
--desc:层管理
--
---------------------------------------------------------------------------------------------------
local strClassName = 'LayerManager'
local LayerManager = lua_declare(strClassName, lua_class(strClassName))
LayerManager.UI = LayerMask.NameToLayer("UI")
LayerManager.Player = LayerMask.NameToLayer("Player")
LayerManager.Map = LayerMask.NameToLayer("Map")
LayerManager.Goods = LayerMask.NameToLayer("Goods")
LayerManager.Bullet = LayerMask.NameToLayer("Bullet")
LayerManager.Hide = LayerMask.NameToLayer("Hide")
LayerManager.MapOutWall = LayerMask.NameToLayer("MapOutWall")
LayerManager.Obstruct = LayerMask.NameToLayer("Obstruct")

return LayerManager
