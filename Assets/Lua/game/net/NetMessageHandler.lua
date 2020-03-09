
---------------------------------------------------------------------------------------------------
--
--filename: game.net.NetMessageHandler
--date:2019/12/23 22:48:49
--author:heguang
--desc:消息处理
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.net.NetMessageHandler'
local NetMessageHandler = lua_declare(strClassName, lua_class(strClassName))

function NetMessageHandler:OnDestroy()

end

function NetMessageHandler:MsgResponseRegister(msg)
	print(">***", msg.Account, tostring(msg.AccountID))
end

function NetMessageHandler:MsgLoginResponse(msg)
	print("********", msg.Error, msg.Address, msg.Key)
	table.print(msg)
end

function NetMessageHandler:R2C_Ping(msg)
	print(">>>>", msg.Address)
end

function NetMessageHandler:R2C_Login(msg)
	print("*******R2C_Login")
end

return NetMessageHandler
