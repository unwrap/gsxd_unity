
---------------------------------------------------------------------------------------------------
--
--filename: game.login.LoginPanel
--date:2020/1/16 17:23:14
--author:heguang
--desc:µÇÂ¼Ãæ°å
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.login.LoginPanel'
local LoginPanel = lua_declare(strClassName, lua_class(strClassName))

function LoginPanel:Start()
	
	local nameObj = self.transform:Find("Name/InputField").gameObject
	self.nameInput = nameObj:GetComponent(InputField)

	local pwObj = self.transform:Find("Password/InputField").gameObject
	self.pwInput = pwObj:GetComponent(InputField)
	self.pwTips = self.transform:Find("Password/TextTips").gameObject
	self.pwTips:SetActive(false)

	local btnLogin = self.transform:Find("btnLogin")
	EventListener.Get(btnLogin, self).onClick = self.ClickLoginHandler

	local onValidatePassword = function(text)
		local pw =self.pwInput.text
		if #pw > 0 then
			self.pwTips:SetActive(false)
		else
			self.pwTips:SetActive(true)
		end
	end
	self.pwInput.onValueChanged:AddListener(onValidatePassword)
end

function LoginPanel:SetAccountName(accountName)
	self.nameInput.text = accountName
	self.pwTips:SetActive(true)
end

function LoginPanel:ClickLoginHandler()
	local accountName = self.nameInput.text
	if accountName == nil or #accountName <= 0 then
		Dialog.Alert(LuaGameUtil.GetText(301002))
		return
	end

	local pw = self.pwInput.text
	if pw == nil or #pw <= 0 or pw == LuaGameUtil.GetText(301003) then
		Dialog.Alert(LuaGameUtil.GetText(301003))
		return
	end

	OzMessage:dispatchEvent(CommonEvent.OnLogin, accountName, pw, true)

	Dialog.Hide()
end

return LoginPanel
