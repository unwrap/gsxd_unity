
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.data.RoomData
--date:2019/10/17 11:58:22
--author:heguang
--desc:管理房间数据
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.mgr.data.RoomData'
local RoomData = lua_declare(strClassName, lua_class(strClassName))

function RoomData:SetRoomID(room_id)
	self.roomID = room_id
	self.room_data = cfg_room[room_id]
	self.mapIds = self.room_data.mapIDs
	self.currentMapIdx = 1
	self.waveIdx = 1
end

function RoomData:GetAllMaps()
	if self.maps == nil then
		self.maps = {}
		for i=1,#self.mapIds do
			local mapId = self.mapIds[i]
			local map = cfg_map[mapId]
			if map ~= nil then
				table.insert(self.maps, map)
			end
		end
	end
	return self.maps
end

function RoomData:GetCurrentMap()
	local mapId = self.mapIds[self.currentMapIdx]
	return cfg_map[mapId].mapRes
end

function RoomData:GetMapMonsters()
	local mapId = self.mapIds[self.currentMapIdx]
	local waveGroup = cfg_map[mapId].monsterWaveGroup

	local waveGroups = cfg_map_monster_waves[waveGroup]
	if waveGroups == nil then
		return nil
	end
	local waveMonster = waveGroups[self.waveIdx]
	if waveMonster == nil then
		return nil
	end
	return waveMonster
end

function RoomData:EnterMap(mapId)
	for i=1,#self.mapIds do
		if self.mapIds[i] == mapId then
			self.currentMapIdx = i
			self.waveIdx = 1
			break
		end
	end
end

function RoomData:EnterNextMap()
	if self.currentMapIdx < #self.mapIds then
		self.currentMapIdx = self.currentMapIdx + 1
		self.waveIdx = 1
		return true, self:GetCurrentMap()
	end
	return false
end

return RoomData
