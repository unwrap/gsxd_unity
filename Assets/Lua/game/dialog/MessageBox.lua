
---------------------------------------------------------------------------------------------------
--
--filename: game.dialog.MessageBox
--date:2019/11/20 11:30:06
--author:heguang
--desc:通用消息框
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.dialog.MessageBox'
local MessageBox = lua_declare(strClassName, lua_class(strClassName))

function MessageBox:Start()
	self.messageText = self.transform:FindChild("Text"):GetComponent(UnityEngine.UI.Text)
	local btnClose = self.transform:FindChild("ButtonClose").gameObject

	self.btnList = self.transform:FindChild("btn")
	local btnCancel = self.btnList:FindChild("ButtonCancel").gameObject
	if btnCancel ~= nil then
		self.cancelText = LuaGameUtil.GetTextComponent(self.btnList, "ButtonCancel/Text")
	end
	local btnOK = self.btnList:FindChild("ButtonOK").gameObject
	if btnOK ~= nil then
		self.okText = LuaGameUtil.GetTextComponent(self.btnList, "ButtonOK/Text")
	end

	EventListener.Get(btnClose, self).onClick = self.CloseHandler
	EventListener.Get(btnCancel, self).onClick = self.CancelHandler
	EventListener.Get(btnOK, self).onClick = self.OKHandler

	self.dialogType = "normal"
end

function MessageBox:CloseHandler(go)
	if self.dialogType == "normal" then
        Dialog.Hide(DialogState.CLOSE, nil)
    elseif self.dialogType == "dialogEx" then
        Dialog.HideEx(self.transform.gameObject, DialogState.CLOSE)
    end
end

function MessageBox:CancelHandler(go)
	if self.dialogType == "normal" then
        Dialog.Hide(DialogState.CANCEL, nil)
    elseif self.dialogType == "dialogEx" then
        Dialog.HideEx(self.transform.gameObject, DialogState.CANCEL)
    end
end

function MessageBox:OKHandler(go)
	if self.dialogType == "normal" then
        Dialog.Hide(DialogState.OK, nil)
    elseif self.dialogType == "dialogEx" then
        Dialog.HideEx(self.transform.gameObject, DialogState.OK)
    end
end

function MessageBox:SetCancelText(strCancel)
	if self.cancelText ~= nil then
		self.cancelText.text = strCancel
	end
end

function MessageBox:SetOkText(strOk)
	if self.okText ~= nil then
		self.okText.text = strOk
	end
end

function MessageBox:SetMessageText(messageText, messageBoxType)
	if messageBoxType ~= nil then
		self.dialogType = messageBoxType
	end
	self.messageText.text = messageText
end

return MessageBox
