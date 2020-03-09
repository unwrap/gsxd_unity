
---------------------------------------------------------------------------------------------------
--
--filename: game.dialog.Dialog
--date:2019/11/20 10:42:24
--author:heguang
--desc:弹窗管理
--
---------------------------------------------------------------------------------------------------
local strClassName = 'Dialog'
local Dialog = lua_declare(strClassName, lua_class(strClassName))
Dialog.currentAlert = nil
Dialog.alertItemDict = {}
Dialog.isPlayEffect = false
Dialog.playTimer = 0
Dialog.playTime = 0.8

function Dialog.Update()
	if Dialog.isPlayEffect then
		Dialog.playTimer = Dialog.playTimer + Time.deltaTime
		local t = Dialog.playTime
		if Dialog.currentAlert ~= nil then
			t = Dialog.currentAlert:GetTotalTime()
		end
		if (Dialog.playTimer > t) then
			Dialog.playTimer = 0
			Dialog.isPlayEffect = false

			if #Dialog.alertItemDict > 0 then
				if Dialog.currentAlert == nil then
					local msg =Dialog.alertItemDict[1]
					table.remove(Dialog.alertItemDict,1)
					local go = ObjectPool.Spawn("base/alerttext.u3d", "alerttext")
					UIManager.Instance:AddAlert(go)
					go.transform:SetAsFirstSibling()
					GameUtil.SetLayer(go.transform, LayerManager.UI)
					Dialog.currentAlert = LuaGameUtil.DoFile(go, "game.dialog.AlertController")
					Dialog.currentAlert:Show(msg.msg, msg.sp)
					Dialog.playTimer = 0
					Dialog.isPlayEffect = true
				end
			else
				Dialog.isPlayEffect = false
			end
		end
	end
end

function Dialog.Alert(message, spriteName)
	if #Dialog.alertItemDict > 10 then
		table.remove(Dialog.alertItemDict, 1)
	end
	--相同的提示就不弹了
	local res = false
	if spriteName == nil then
		if Dialog.currentAlert ~= nil then
			res = ( Dialog.currentAlert.message == message )
		end
		if not res then
			for _,v in ipairs(Dialog.alertItemDict) do
				if v.msg == message then
					res = true
					break
				end
			end
		end
	end
	if not res then
		table.insert(Dialog.alertItemDict, {msg=message, sp=spriteName})
		if not Dialog.isPlayEffect then
			Dialog.playTimer = Dialog.playTime
			Dialog.isPlayEffect = true
		end
	end
end

function Dialog.ClearAlert(go)
	Dialog.currentAlert = nil
	if not Dialog.isPlayEffect then
		Dialog.playTimer = Dialog.playTime
		Dialog.isPlayEffect = true
	end
end

function Dialog.ClearAllAlert()
	if Dialog.currentAlert ~= nil then
		Dialog.currentAlert:Remove()
	end
	Dialog.currentAlert = nil
	Dialog.alertItemDict = {}
end

function Dialog.ShowMessage(message,closeCallback, showOK, showCancel, showClose)
	if showOK == nil then showOK = true end
	if showCancel == nil then showCancel = false end
	if showClose == nil then showClose = true end
	UI.Dialog.ShowMessage(message,closeCallback, showOK, showCancel, showClose)
end

function Dialog.ShowWaiting(message)
	UI.Dialog.ShowWaiting(message)
end

function Dialog.CloseWaiting()
	UI.Dialog.CloseWaiting()
end

function Dialog.Show(go, isModal, closeCallback, showCallback)
	if isModal == nil then
		isModal = true
	end
	UI.Dialog.Show(go,isModal,closeCallback, showCallback)
end

function Dialog.Hide(state, callBack)
	if state == nil then
		state = DialogState.OK
	end
	UI.Dialog.Hide(state,callBack)
end

return Dialog
