
---------------------------------------------------------------------------------------------------
--
--filename: game.login.LoginController
--date:2020/1/15 15:46:49
--author:heguang
--desc:登录游戏
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.login.LoginController'
local LoginController = lua_declare(strClassName, lua_class(strClassName))

function LoginController:Start()
	GameNetMgr.AddHandler.MsgResponseRegister(self)
	GameNetMgr.AddHandler.MsgLoginResponse(self)

	OzMessage:addEvent(CommonEvent.OnSessionClose, self.OnSessionClose, self)
	OzMessage:addEvent(CommonEvent.OnLogin, self.DoLogin, self)

	self:AutoLogin()
end

function LoginController:OnDestroy()
	GameNetMgr.RemoveHandler.MsgResponseRegister(self)
	GameNetMgr.RemoveHandler.MsgLoginResponse(self)
	OzMessage:removeEvent(CommonEvent.OnSessionClose, self.OnSessionClose, self)
	OzMessage:removeEvent(CommonEvent.OnLogin, self.DoLogin, self)
end

function LoginController:AutoLogin()
	--登录
	local session = GameNetMgr:ConnectServer(GameConfig.server)
	local localAccountName = PlayerPrefs.GetString(CommonUtil.localkey_accountname .. GameUtil.CurrentPlatform, "")
	local localPassword = PlayerPrefs.GetString(CommonUtil.localkey_password .. GameUtil.CurrentPlatform, "")
	if localAccountName ~= "" then
		local localKey = PlayerPrefs.GetString(CommonUtil.localkey_key .. GameUtil.CurrentPlatform, "")
		local key = lutil.encrypt_key(localKey)
		local pw = XXTEA.DecryptBase64StringToString(localPassword, GameUtil.md5(key))
		self:DoLogin(localAccountName, pw)
	else
		--注册
		GameNetMgr.Send.MsgRequestRegister({	})
	end
	Dialog.ShowWaiting()
end

function LoginController:DoLogin(accountName, password, saveLocal)
	self.currentAccountName = accountName

	local t = os.time()
	local r = LuaMath.Random(0, 2000)
	local flag = GameUtil.md5(lutil.encrypt_key(accountName .. "|" .. password .. "|" .. t .. "|" .. r ))
	GameNetMgr.Send.MsgLoginRequest({
		Account = accountName,
		TimeStamp = t,
		Salt = r,
		Flag = flag
	})

	if saveLocal then
		local key = t .. "|" .. r
		local savePw = XXTEA.EncryptToBase64String(password, GameUtil.md5(lutil.encrypt_key(key)));
		PlayerPrefs.SetString(CommonUtil.localkey_accountname .. GameUtil.CurrentPlatform, accountName)
		PlayerPrefs.SetString(CommonUtil.localkey_password .. GameUtil.CurrentPlatform, savePw)
		PlayerPrefs.SetString(CommonUtil.localkey_key .. GameUtil.CurrentPlatform, key)
	end

	Dialog.ShowWaiting()
end

function LoginController:OnSessionClose(session, error)
	Dialog.CloseWaiting()
	Dialog.ShowMessage(LuaGameUtil.GetText(200100), function()
		self:AutoLogin()
	end)
end

function LoginController:MsgResponseRegister(msg)
	if msg.Error ~= 0 then
		Dialog.Alert(LuaGameUtil.GetText(msg.Error))
	else
		--注册成功,账号信息保存到本地
		local accountName = msg.Account
		local pw = msg.Password
		local key = msg.RandomKey

		PlayerPrefs.SetString(CommonUtil.localkey_accountname .. GameUtil.CurrentPlatform, accountName)
		PlayerPrefs.SetString(CommonUtil.localkey_password .. GameUtil.CurrentPlatform, pw)
		PlayerPrefs.SetString(CommonUtil.localkey_key .. GameUtil.CurrentPlatform, key)

		LuaGameUtil.LoadHomeScene()
	end
end

function LoginController:MsgLoginResponse(msg)
	Dialog.CloseWaiting()
	if msg.Error ~= 0 then
		if msg.Error == 200106 then
			--账号不存在，重新注册
			Dialog.ShowWaiting()
			GameNetMgr.Send.MsgRequestRegister({	})
		elseif msg.Error == 200107 then
			--密码不正确，请重新输入
			local obj = AssetBundleManager.InstantiateGameObject("login/loginpanel.u3d", "LoginPanel")
			local logic = LuaGameUtil.DoFile(obj, "game.login.LoginPanel")
			logic:SetAccountName(self.currentAccountName)
			Dialog.Show(obj)
		else
			Dialog.Alert(LuaGameUtil.GetText(msg.Error))
		end
	else
		LuaGameUtil.LoadHomeScene()
	end
end

return LoginController
