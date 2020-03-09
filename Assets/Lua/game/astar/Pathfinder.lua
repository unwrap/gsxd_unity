
---------------------------------------------------------------------------------------------------
--
--filename: game.astar.Pathfinder
--date:2019/11/8 14:29:04
--author:heguang
--desc:寻路
--
---------------------------------------------------------------------------------------------------

local strClassName = 'game.astar.Pathfinder'
local Pathfinder = lua_declare(strClassName, lua_class(strClassName))

-- 行走的4个方向
local four_dir = {
    {1, 0},
    {0, 1},
    {0, -1},
    {-1, 0},
}

-- 行走的8个方向
local eight_dir = {
    {1, 1},
    {1, 0},
    {1, -1},
    {0, 1},
    {0, -1},
    {-1, 1},
    {-1, 0},
    {-1, -1}
}

function Pathfinder:ctor(astarGraph)
	self.astarGraph = astarGraph
	self.totalRow = self.astarGraph.xNode
	self.totalColumn = self.astarGraph.zNode

	self.isFourDir = false
	self.cost       = 10 -- 单位花费
    self.diag       = 1.4 -- 对角线长， 根号2 一位小数
	self.open_list = {}
	self.close_list = {}
end

function Pathfinder:IsInMap(row, column)
	if row < 0 or row >= self.totalRow then
		return false
	end
	if column < 0 or column >= self.totalColumn then
		return false
	end
	return true
end

function Pathfinder:GetMapIndex(row, col)
	local idx = col * self.totalRow + row;
	return idx
end

function Pathfinder:IsWalkable(row, col)
	local t = self.astarGraph:GetTileValue(row, col)
	return t == TileType.None
end

function Pathfinder:Check(row, col)
	if self:IsInMap(row, col) then
		return self:IsWalkable(row, col)
	end
	return false
end

--在open_list中找到最佳点，并删除
function Pathfinder:GetMinNode()
	if #self.open_list < 1 then
		return nil
	end
	local min_node = self.open_list[1]
	local min_i = 1
	for i,v in ipairs(self.open_list) do
		if min_node.f > v.f then
			min_node = v
			min_i = i
		end
	end

	table.remove(self.open_list, min_i)
	return min_node
end

function Pathfinder:FindPath(from_row, from_column, to_row, to_column)
	if not self:IsWalkable(to_row, to_column) then
		return nil
	end

	self.open_list = {}
	self.close_list = {}

	local startNode = {}
	startNode.row = from_row
	startNode.col = from_column
	startNode.g = 0
	startNode.h = 0
	startNode.f = 0
	table.insert(self.open_list, startNode)

	local dir = self.isFourDir and four_dir or eight_dir
	while #self.open_list > 0 do
		local node = self:GetMinNode()
		if node.row == to_row and node.col == to_column then
			--找到路径
			return self:BuildPath(node)
		end
		for i=1, #dir do
			local row = node.row + dir[i][1]
			local col = node.col + dir[i][2]
			if self:IsInMap(row, col) and self:IsWalkable(row, col) then
				local curNode = self:GetFGH(node, row, col, (row ~= node.row and col ~= node.col), to_row, to_column)
				local openNode, openIndex = self:NodeInOpenList(row, col)
				local closeNode, closeIndex = self:NodeInCloseList(row, col)
				if not openNode and not closeNode then
					-- 不在OPEN表和CLOSE表中
                    -- 添加特定节点到 open list
                    table.insert(self.open_list, curNode)
				elseif openNode then
					-- 在OPEN表
                    if openNode.f > curNode.f then
                        -- 更新OPEN表中的估价值
                        self.open_list[openIndex] = curNode
                    end
				else
					-- 在CLOSE表中
                    if closeNode.f > curNode.f then
                        table.insert(self.open_list, curNode)
                        table.remove(self.close_list, closeIndex)
                    end
				end
			end
		end

		--节点放入到close_list里面
		table.insert(self.close_list, node)
	end
	-- 不存在路径
	return nil
end

--估价函数
-- 曼哈顿估价法（用于不能对角行走）
function Pathfinder:Manhattan(row, col, to_row, to_column)
	local h = math.abs(row - to_row) + math.abs(col - to_column)
	return h * self.cost
end

-- 对角线估价法,先按对角线走，一直走到与终点水平或垂直平行后，再笔直的走
function Pathfinder:Diagonal(row, col, to_row, to_column)
	local dx = math.abs(row - to_row)
	local dy = math.abs(col - to_column)
	local minD = math.min(dx, dy)
	local h = minD * self.diag + dx + dy - 2 * minD
	return h * self.cost
end

function Pathfinder:GetFGH(father, row, col, isdiag, to_row, to_column)
	local node = {}
	local cost = self.cost
	if isdiag then
		cost = cost * self.diag
	end

	node.father = father
	node.row = row
	node.col = col
	node.g = father.g + cost
	--估计值h
	if self.isFourDir then
		node.h = self:Manhattan(row, col, to_row, to_column)
	else
		node.h = self:Diagonal(row, col, to_row, to_column)
	end
	node.f = node.g + node.h

	return node
end

-- 判断节点是否已经存在 open list 里面
function Pathfinder:NodeInOpenList(row, col)
	for i = 1, #self.open_list do
		local node = self.open_list[i]
		if node.row == row and node.col == col then
			return node, i
		end
	end
	return nil
end

-- 判断节点是否已经存在 close list 里面
function Pathfinder:NodeInCloseList(row, col)
	for i = 1, #self.close_list do
		local node = self.close_list[i]
		if node.row == row and node.col == col then
			return node, i
		end
	end
	return nil
end

function Pathfinder:BuildPath(node)
	local path = {}
	--路径的总花费
	local sumCost = node.f
	while node do
		path[#path + 1] = {row = node.row, col = node.col}
		node = node.father
	end
	return path, sumCost
end

return Pathfinder
