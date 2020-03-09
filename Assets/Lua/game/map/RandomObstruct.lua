
---------------------------------------------------------------------------------------------------
--
--filename: game.map.RandomObstruct
--date:2019/12/17 22:06:52
--author:heguang
--desc:随机生成场景的障碍物
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.map.RandomObstruct'
local RandomObstruct = lua_declare(strClassName, lua_class(strClassName))
local math_floor = math.floor

function RandomObstruct:ctor(parentObj, astarGraph)
	self.parentObj = parentObj
	self.astarGraph = astarGraph

	self.totalRow = self.astarGraph.xNode
	self.totalColumn = self.astarGraph.zNode
end

function RandomObstruct:OnDestroy()

end

function RandomObstruct:IsWalkable(row, col)
	local t = self.astarGraph:GetTileValue(row, col)
	return t == TileType.None
end

function RandomObstruct:GetRandom()
	--return self:Random6()
	---[[
	local r = MathUtil.RandomInt(0, 6) + 1
	return self["Random".. r](self)
	--]]
end

function RandomObstruct:Random1()
	local posList = {}
	for i=1,2 do
		local x = MathUtil.RandomInt(0, self.totalRow)
		local y = MathUtil.RandomInt(0, self.totalColumn)
		if self:IsWalkable(x, y) then
			table.insert(posList, {x, y})
		end
	end
	return posList
end

--T型
function RandomObstruct:Random2()
	local posList = {}
	local xCenter = math_floor(self.totalRow * 0.5)
	local yStart = self.totalColumn - 8
	for x = 4,self.totalRow-4, 2 do
		table.insert(posList, {x, yStart})
	end
	for y = yStart - 2, yStart -16,-2 do
		table.insert(posList, {xCenter, y})
	end

	return posList
end

--x型
function RandomObstruct:Random3()
	local posList = {}
	local xCenter = math_floor(self.totalRow * 0.5)
	local yCenter = math_floor(self.totalColumn * 0.5)
	local x1 = math_floor(xCenter * 0.5)
	local x2 = x1 + xCenter
	local y1 = math_floor(yCenter * 0.5)
	local y2 = y1 + yCenter

	table.insert(posList, {x1, y1})
	table.insert(posList, {x1, y2})
	table.insert(posList, {xCenter, yCenter})
	table.insert(posList, {x2, y1})
	table.insert(posList, {x2, y2})

	return posList
end

--十字型
function RandomObstruct:Random4()
	local posList = {}
	local xCenter = math_floor(self.totalRow * 0.5)
	local yCenter = math_floor(self.totalColumn * 0.5)
	local xGrid = 6
	local yGrid = 10

	table.insert(posList, {xCenter, yCenter})
	table.insert(posList, {xCenter - xGrid, yCenter})
	table.insert(posList, {xCenter + xGrid, yCenter})
	table.insert(posList, {xCenter, yCenter - yGrid})
	table.insert(posList, {xCenter, yCenter + yGrid})

	return posList

end

--[[
         --
	--      --
	     --
--]]
function RandomObstruct:Random5()
	local posList = {}

	local xCenter = math_floor(self.totalRow * 0.5)
	local yCenter = math_floor(self.totalColumn * 0.5)
	local yGrid = 10

	table.insert(posList, {xCenter-1, yCenter-yGrid})
	table.insert(posList, {xCenter+1, yCenter-yGrid})
	table.insert(posList, {xCenter-1, yCenter+yGrid})
	table.insert(posList, {xCenter+1, yCenter+yGrid})
	table.insert(posList, {1, yCenter})
	table.insert(posList, {3, yCenter})
	table.insert(posList, {self.totalRow-3, yCenter})
	table.insert(posList, {self.totalRow-5, yCenter})

	return posList
end

--[[
------

            ------

------
--]]
function RandomObstruct:Random6()
	local posList = {}
	local xCenter = math_floor(self.totalRow * 0.5)
	local yCenter = math_floor(self.totalColumn * 0.5)
	local yGrid = 12

	for i=1,5 do
		table.insert(posList, {i*2-1, yCenter - yGrid})
	end

	for i=1,5 do
		table.insert(posList, {self.totalRow-2*i-1, yCenter})
	end

	for i=1,5 do
		table.insert(posList, {i*2-1, yCenter + yGrid})
	end

	return posList
end

return RandomObstruct
