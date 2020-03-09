
---------------------------------------------------------------------------------------------------
--
--filename: core.OzMessage
--date:2019/9/21 10:43:04
--author:heguang
--desc:通用事件派发器
--
--[[
    eg: OzMessage:addEvent(
            "eventName", 
            function(data) 
                print(data[1], data[2], data[3])  --1, 2, 3
            end
        )
        OzMessage:dispatchEvent("eventName", {1, 2, 3})
--]]
---------------------------------------------------------------------------------------------------

OzEventData = lua_declare("OzEventData", lua_class("OzEventData"))
OzEventData.name = ""
OzEventData.listener = nil
OzEventData.target = nil

local strClassName = 'OzMessage'
OzMessage = lua_declare(strClassName, lua_class(strClassName))
OzMessage._eventDict = {}

--[[
    注册事件
    @param eventName 事件名
    @param listener 回调函数
    @param target 注册者(类似使用target:listener())
--]]
function OzMessage:addEvent(eventName, listener, target)
	assert(type(eventName) == "string" or eventName ~= "", "invalid event name")

	if not listener then
        return
    end

	local listeners = OzMessage._eventDict[eventName] or {}
	OzMessage._eventDict[eventName] = listeners

	for _,v in ipairs(listeners) do
		if v.listener == listener and v.target == target then
			return
		end
	end

	local event = OzEventData.new()
	event.listener = listener
	event.name = eventName
	event.target = target

	table.insert(listeners, event)
end

function OzMessage:removeEvent(eventName, listener, target)
	local listeners = OzMessage._eventDict[eventName]
	if not listeners then
		return
	end
	for i, event in ipairs(listeners) do
        if event.listener == listener and event.target == target then
            table.remove(listeners, i)
            break
        end
    end
end

function OzMessage:dispatchEvent(eventName, ...)
	local listeners = OzMessage._eventDict[eventName]
    if not listeners then
        return
    end
	for _, v in ipairs(listeners) do
        local callback = v.listener
        if v.target then
            callback(v.target, ...)
        else
            callback(...)
        end
    end
end

function OzMessage:removeAllEvent(eventName)
    OzMessage._eventDict[eventName] = nil
end

function OzMessage:hasEvent(eventName, listener)
    local listeners = OzMessage._eventDict[eventName]
    if not listeners then
        return false
    end
    for _, event in ipairs(listeners) do
        if event.listener == listener then
            return true
        end
    end
    return false
end

function OzMessage:SendMessage(msg, msgName)
	GameNetMgr:SendMessage(msg, msgName)
end
