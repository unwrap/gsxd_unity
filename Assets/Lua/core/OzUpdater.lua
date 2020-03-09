
---------------------------------------------------------------------------------------------------
--
--filename: core.OzUpdater
--date:2019/9/25 14:43:16
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------

-- Global to local
local str_len = string.len

---------------------------------------------------------------------------------------------------

local OzUpdateNode = lua_class("OzUpdateNode")
OzUpdateNode.m_object = nil
OzUpdateNode.m_objectType = nil
OzUpdateNode.m_bToggleUpdate = false
OzUpdateNode.m_bToggleLateUpdate = false
OzUpdateNode.m_bToggleFixedUpdate = false
OzUpdateNode.m_bToggleLiteUpdate = false
OzUpdateNode.m_bActive = false

function OzUpdateNode:ctor(obj, bUpdate, bLateUpdate, bFixedUpdate, bLiteUpdate)
	self.m_object = obj
	self.m_objectType = obj:gettype()
	self.m_bToggleUpdate = bUpdate
	self.m_bToggleLateUpdate = bLateUpdate
	self.m_bToggleFixedUpdate = bFixedUpdate
	self.m_bToggleLiteUpdate = bLiteUpdate
	self.m_bActive = true
end

function OzUpdateNode:dtor()
	self.m_object = nil
	self.m_objectType = nil
	self.m_bToggleUpdate = false
	self.m_bToggleLateUpdate = false
	self.m_bToggleFixedUpdate = false
	self.m_bToggleLiteUpdate = false
	self.m_bActive = false
end

---------------------------------------------------------------------------------------------------

local strClassName = 'OzUpdater'
local OzUpdater = lua_declare(strClassName, lua_class(strClassName))
OzUpdater.m_instance = nil
OzUpdater.m_objectList = nil
OzUpdater.m_objectListInOrder = nil

function OzUpdater:ctor()
	if OzUpdater.m_instance then
		printerror("You have already create a OzUpdater instance!")
		return
	end

	OzUpdater.m_instance = self
	self.m_objectList = {}
	self.m_objectListInOrder = {}
end

function OzUpdater:dtor()
	self.m_objectList = nil
	self.m_objectListInOrder = nil
end

function OzUpdater.Instance()
	if not OzUpdater.m_instance then
		OzUpdater.new()
	end
	return OzUpdater.m_instance
end

function OzUpdater:Update()
	local updateNode = nil
	local objectArray = self.m_objectListInOrder
	for i=1, #objectArray do
		updateNode = objectArray[i]
		if updateNode.m_bActive and updateNode.m_bToggleUpdate and updateNode.m_object.Update then
			GameUtil.BeginMarkTime()
			updateNode.m_object:Update()
			GameUtil.EndMarkTime(updateNode.m_objectType, 5)
		end
	end
end

function OzUpdater:LateUpdate()
	local updateNode = nil
	local objectArray = self.m_objectListInOrder
	for i=1, #objectArray do
		updateNode = objectArray[i]
		if updateNode.m_bActive and updateNode.m_bToggleLateUpdate and updateNode.m_object.LateUpdate then
			updateNode.m_object:LateUpdate()
		end
	end
end

function OzUpdater:FixedUpdate()
	local updateNode = nil
	local objectArray = self.m_objectListInOrder
	for i=1, #objectArray do
		updateNode = objectArray[i]
		if updateNode.m_bActive and updateNode.m_bToggleFixedUpdate and updateNode.m_object.FixedUpdate then
			updateNode.m_object:FixedUpdate()
		end
	end
end

function OzUpdater:LiteUpdate()
	local updateNode = nil
	local objectArray = self.m_objectListInOrder
	for i=1, #objectArray do
		updateNode = objectArray[i]
		if updateNode.m_bActive and updateNode.m_bToggleLiteUpdate and updateNode.m_object.LiteUpdate then
			updateNode.m_object:LiteUpdate()
		end
	end
end

function OzUpdater:RegisterUpdate(obj, bUpdate, bLateUpdate, bFixedUpdate, bLiteUpdate)
	if (not obj) then
		return false
	end

	if bUpdate and (not obj.Update) then
		warn("Lua class \"" .. obj:gettype() .. "\" used \"Update\" without providing a function!")
	end

	if bLateUpdate and (not obj.LateUpdate) then
    	DLogWarn("Lua class \"" .. obj:gettype() .. "\" used \"LateUpdate\" without providing a function!")
    end

    if bFixedUpdate and (not obj.FixedUpdate) then
    	DLogWarn("Lua class \"" .. obj:gettype() .. "\" used \"FixedUpdate\" without providing a function!")
    end

    if bLiteUpdate and (not obj.LiteUpdate) then
    	DLogWarn("Lua class \"" .. obj:gettype() .. "\" used \"LiteUpdate\" without providing a function!")
    end

	local objList = self.m_objectList
	if objList[obj] then
		return true
	end

	local updateNode = OzUpdateNode(obj, bUpdate, bLateUpdate, bFixedUpdate, bLiteUpdate)
	table.insert(self.m_objectListInOrder, updateNode)
	objList[obj] = #self.m_objectListInOrder

	return true
end

function OzUpdater:UnregisterUpdate(obj)
	if (not obj) then
		return false
	end

	local objList = self.m_objectList
	local objIdx = objList[obj]
	if not objIdx then
		return false
	end

	local orderObjList = self.m_objectListInOrder
	table.remove(orderObjList, objIdx)
	objList[obj] = nil

	for i = objIdx, #orderObjList do
		objList[orderObjList[i].m_object] = i
	end

	return true
end

return OzUpdater
