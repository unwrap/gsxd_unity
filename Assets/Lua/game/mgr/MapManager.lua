
---------------------------------------------------------------------------------------------------
--
--filename: game.mgr.MapManager
--date:2019/11/8 9:34:50
--author:heguang
--desc:场景管理
--
---------------------------------------------------------------------------------------------------
local Pathfinder = require("game.astar.Pathfinder")
local RandomObstruct = require("game.map.RandomObstruct")

local strClassName = 'game.mgr.MapManager'
local MapManager = lua_declare(strClassName, lua_class(strClassName))

function MapManager:ctor(mapObj)
	self.mapObj = mapObj
	self.astarGraph = self.mapObj:GetComponent(TileMapGraph)

	self.floor = self.mapObj.transform:Find("floor")
	self.floor.localScale = Vector3(1, 1, CommonUtil.mapScaleZ)

	self.obstruct = self.mapObj.transform:Find("obstruct")
	self.randomObstruct = RandomObstruct(self.obstruct, self.astarGraph)

	self.width = self.astarGraph.width
	self.length = self.astarGraph.length

	self.totalRow = self.astarGraph.xNode
	self.totalColumn = self.astarGraph.zNode
	self.nodeSize = self.astarGraph.nodeSize

	self.offset = Vector3(-self.totalRow * self.nodeSize * 0.5, 0, -self.totalColumn * self.nodeSize * 0.5);
	self.pathFind = Pathfinder(self.astarGraph)

	self.offsetList = {-1, 0, 1, 2}
	self:CreateObstruct()
end

function MapManager:OnDestroy()
	if self.randomObstruct ~= nil then
		self.randomObstruct:OnDestroy()
	end
end

function MapManager:WorldPos2TilePos(wp)
	local current = wp - self.offset
	local xPos = math.floor(current.x / self.nodeSize)
	local zPos = math.floor(current.z / self.nodeSize)
	return xPos, zPos
end

function MapManager:TilePos2WorldPos(row, col)
	local pos = Vector3((row + 0.5) * self.nodeSize, 0, (col + 0.5) * self.nodeSize)
	pos = pos + self.offset
	return pos 
end

function MapManager:IsWalkable(wp)
	local row, col = self:WorldPos2TilePos(wp)
	local t = self.astarGraph:GetTileValue(row, col)
	return t == TileType.None
end

function MapManager:GetObstructWorldPos(row, col)
	local pos = Vector3((row + 1) * self.nodeSize, 0, (col + 1) * self.nodeSize)
	pos = pos + self.offset
	return pos
end

function MapManager:CreateObstruct()
	local posList = self.randomObstruct:GetRandom()
	for _,v in ipairs(posList) do
		local x, y = v[1], v[2]
		
		for _,ox in ipairs(self.offsetList) do
			for _,oy in ipairs(self.offsetList) do
				self.astarGraph:SetTileValue(x + ox, y + oy, TileType.Block)
			end
		end

		local pos = self:GetObstructWorldPos(x, y)
		local obj = ObjectPool.Spawn("obstruct/box_002.u3d", "box_002")
		local objTransform = obj.transform
		objTransform:SetParent(self.obstruct)
		GameUtil.SetLayer(objTransform, LayerManager.Obstruct)
		objTransform.position = pos
		objTransform.localScale = Vector3.one
	end
end

function MapManager:FindPath(startPos, endPos)
	local start_row, start_col = self:WorldPos2TilePos(startPos)
	local end_row, end_col = self:WorldPos2TilePos(endPos)
	local path = self.pathFind:FindPath(start_row, start_col, end_row, end_col)
	local worldPath = nil
	if path ~= nil and #path > 0 then
		worldPath = {endPos}
		if #path > 1 then
			for i=2,#path - 1 do
				local tp = path[i]
				worldPath[#worldPath + 1] = self:TilePos2WorldPos(tp.row, tp.col)
			end
		end
		worldPath[#worldPath + 1] = startPos
	end
	return worldPath
end

return MapManager
