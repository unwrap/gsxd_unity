
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.data.GlobalData
--date:2019/12/27 11:04:30
--author:heguang
--desc:全局数据
--
---------------------------------------------------------------------------------------------------
local RoomData = require("game.mgr.data.RoomData")

local strClassName = 'GlobalData'
local GlobalData = lua_declare(strClassName, lua_class(strClassName))

function GlobalData:Reset()
	self.roomData = RoomData()
	self.roomData:SetRoomID(1000)
end

function GlobalData:GetAllMaps()
	return self.roomData:GetAllMaps()
end

function GlobalData:EnterMap(mapId)
	self.roomData:EnterMap(mapId)
end

return GlobalData
