
---------------------------------------------------------------------------------------------------
--
--filename: game.net.GameNetMgr
--date:2019/12/23 16:59:45
--author:heguang
--desc:网络消息处理
--
---------------------------------------------------------------------------------------------------
local MsgNameSpace = "GameCommon.NetMsg."
local NetMessageHandler = require("game.net.NetMessageHandler")

OzMsgData = lua_declare("OzMsgData", lua_class("OzMsgData"))
OzMsgData.listener = nil
OzMsgData.target = nil

local strClassName = 'GameNetMgr'
local GameNetMgr = lua_declare(strClassName, lua_class(strClassName))

function GameNetMgr.OnGetServerMessage(session, packet, opcode)
	local messageName = ProtoDef.name[opcode]
	local msg = pb.decode(MsgNameSpace .. messageName, packet)
	if msg ~= nil then
		GameNetMgr:HandleNetMessage(messageName, msg)
		OzMessage:dispatchEvent(messageName, msg)
	end
end

function GameNetMgr.OnSessionClose(session, error)
	print("SessionClose Error:", error)
	OzMessage:dispatchEvent(CommonEvent.OnSessionClose, session, error)
end

function GameNetMgr:Init()
	self.msgHandler = NetMessageHandler()
	self.currentSession = nil

	self._eventDict = {}

	GameNetMgr.Send = {}
	GameNetMgr.AddHandler = {}
	GameNetMgr.RemoveHandler = {}
	for _,v in pairs(ProtoDef.name) do
		local func = function(msg)
			GameNetMgr:SendMessage(msg, v)
		end
		GameNetMgr.Send[v] = func

		GameNetMgr.AddHandler[v] = function(target)
			local handler = target[v]
			if handler ~= nil then
				GameNetMgr:AddMsgHandler(v, handler, target)
			end
		end

		GameNetMgr.RemoveHandler[v] = function(target)
			local handler = target[v]
			if handler ~= nil then
				GameNetMgr:RemoveMsgHandler(v, handler, target)
			end
		end
	end

	OzNetClient.Instance.OnGetServerMessage = GameNetMgr.OnGetServerMessage
	OzNetClient.Instance.OnClose = GameNetMgr.OnSessionClose
end

function GameNetMgr:GetErrorCode()
	if self.currentSession ~= nil then
		return self.currentSession.Error
	end
	return ErrorCode.ERR_Success
end

function GameNetMgr:ConnectServer(address)
	print("ConnectServer:", address)
	if self.currentSession ~= nil then
		self.currentSession:Dispose()
		self.currentSession = nil
	end
	self.currentSession = OzNetClient.Instance:ConnectServer(address)
end

function GameNetMgr:SendMessage(msg, msgName)
	if self.currentSession ==  nil then
		return
	end
	local bytes = pb.encode(MsgNameSpace .. msgName, msg)
	local opcode = ProtoDef.opcode[msgName]
	self.currentSession:Send(bytes, opcode)
end

function GameNetMgr:AddMsgHandler(msgName, handler, target)
	if not handler then
		return
	end

	local listeners = self._eventDict[msgName] or {}
	self._eventDict[msgName] = listeners

	for _,v in ipairs(listeners) do
		if v.listener == handler and v.target == target then
			return
		end
	end

	local event = OzMsgData.new()
	event.listener = handler
	event.target = target

	table.insert(listeners, event)
end

function GameNetMgr:RemoveMsgHandler(msgName, handler, target)
	if not self._eventDict then
		return
	end
	local listeners = self._eventDict[msgName]
	if not listeners then
		return
	end
	for i, event in ipairs(listeners) do
        if event.listener == handler and event.target == target then
            table.remove(listeners, i)
            break
        end
    end
end

function GameNetMgr:OnDestroy()
	if self.msgHandler ~= nil then
		self.msgHandler:OnDestroy()
	end
	self.msgHandler = nil

	self._eventDict = nil
end

function GameNetMgr:HandleNetMessage(messageName, msg)
	if self.msgHandler == nil then
		return
	end
	
	local msgMgrHandlerFunc = self[messageName]
	if msgMgrHandlerFunc ~= nil then
		msgMgrHandlerFunc(self, msg)
	end

	local msgHandlerFunc = self.msgHandler[messageName]
	if msgHandlerFunc ~= nil then
		msgHandlerFunc(self.msgHandler, msg)
	end

	local listeners = self._eventDict[messageName]
    if listeners then
        for _, v in ipairs(listeners) do
			local handler = v.listener
			if v.target then
				handler(v.target, msg)
			else
				handler(msg)
			end
		end
    end

end

return GameNetMgr
