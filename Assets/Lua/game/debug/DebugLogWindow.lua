
---------------------------------------------------------------------------------------------------
--
--filename: game.debug.DebugLogWindow
--date:2019/10/9 16:43:10
--author:heguang
--desc:GM面板
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.debug.DebugLogWindow'
local DebugLogWindow = lua_declare(strClassName, lua_class(strClassName))

function DebugLogWindow:Start()
	self.commandInputField = self.transform:FindChild("CommandInputField")
	self.commandInputField = self.commandInputField.gameObject:GetComponent(InputField)

	self.btnsContainer = self.transform:FindChild("Debugs/Viewport/LogsContainer")
	self.btnPrefab = self.btnsContainer:GetChild(0).gameObject
	self.btnPrefab:SetActive(false)

	self.pageBtnContainer = self.transform:FindChild("TopButtons/ScrollView/Viewport/Content")
	self.pageBtnPrefab = self.pageBtnContainer:GetChild(0).gameObject
	self.pageBtnPrefab:SetActive(false)

	self.inputContainer = self.transform:FindChild("DebugDetails/Viewport/Content")
	self.inputBtnPrefab = self.inputContainer:GetChild(0).gameObject
	self.inputBtnPrefab:SetActive(false)

	self.btn2InputCmd = {}
	self.inputCmd = {}
	local msg = PlayerPrefs.GetString("DebugLogInputCmd")
	if msg ~= nil then
		local dataList = string.split(msg, "|")
		if dataList ~= nil then
			for _,v in ipairs(dataList) do
				table.insert(self.inputCmd, v)
			end
		end
	end
	self:UpdateInputList()

	local OnValidateCommand = function(text, charIndex, addedChar)
		if addedChar == 10 then
			self.commandInputField.text = ""
			if #text > 0 then
				self:ExecuteCommand(text)

				if #self.inputCmd >= 5 then
					table.remove(self.inputCmd)
				end
				table.insert(self.inputCmd,1, text)
				self:UpdateInputList()
			end
			return 0
		end
		return addedChar
	end
	local inputFieldSubmit = function(val)
		local text = self.commandInputField.text
		self.commandInputField.text = ""
		if #text > 0 then
			self:ExecuteCommand(text)
			if #self.inputCmd >= 5 then
				table.remove(self.inputCmd)
			end
			table.insert(self.inputCmd,1, text)
			self:UpdateInputList()
		end
	end
	self.commandInputField.onEndEdit:AddListener(inputFieldSubmit)
	self.commandInputField.onValidateInput = { "+=", OnValidateCommand}

	self.page2Gm = {}
	for k, v in pairs( cfg_gm ) do
		local pageGm = self.page2Gm[v.page] or {}
		local cfgList = pageGm.cfgList
		if cfgList == nil then
			cfgList = {}
			pageGm.cfgList = cfgList
		end
		table.insert(cfgList, v)
		self.page2Gm[v.page] = pageGm
	end

	--临时增加技能的ＧＭ指令
	local addPage = #self.page2Gm + 1
	for _,skill in pairs(cfg_skill) do
		local v = {ID = skill.skillID, name = skill.name, page = addPage, command = "skill " .. skill.skillID}
		local pageGm = self.page2Gm[v.page] or {}
		local cfgList = pageGm.cfgList
		if cfgList == nil then
			cfgList = {}
			pageGm.cfgList = cfgList
		end
		table.insert(cfgList, v)
		self.page2Gm[v.page] = pageGm
	end

	local cfgGmSort = function(a, b)
		if a.ID < b.ID then
			return true
		else
			return false
		end
	end
	local pageList = {}
	for k,v in pairs(self.page2Gm) do
		table.sort(v.cfgList, cfgGmSort)
		table.insert(pageList, {ID = k})
	end
	table.sort(pageList, cfgGmSort)

	self.pageBtn2Index = {}
	local defaultBtn = nil
	for i,v in ipairs(pageList) do
		local btn = GameUtil.Instantiate(self.pageBtnPrefab)
		btn:SetActive(true)
		btn.transform:SetParent(self.pageBtnContainer)
		btn.transform.localScale = Vector3.one
		local txt = LuaGameUtil.GetTextComponent(btn.transform, "Text")
		txt.text = v.ID
		EventListener.Get(btn, self).onClick = self.OnClickPageButton
		self.pageBtn2Index[btn] = v.ID
		if defaultBtn == nil then
			defaultBtn = btn
		end
	end
	self:OnClickPageButton(defaultBtn)

	self.debugDetailText = LuaGameUtil.GetTextComponent(self.transform, "DebugDetailText/ScrollView/Viewport/Content/Text")

	local btnClear = self.transform:FindChild("DebugDetailText/ClearButton")
	EventListener.Get(btnClear, self).onClick = self.OnClearDebugDetailText
end

function DebugLogWindow:UpdateInputList()
	local num = self.inputContainer.childCount

	for i=0, num-1 do
        self.inputContainer:GetChild(i).gameObject:SetActive(false)
    end

    self.btn2InputCmd = {}
	for k,v in ipairs(self.inputCmd) do
		local btn
		if k <= num then
			btn = self.inputContainer:GetChild(k-1).gameObject
			btn:SetActive(true)
		else
			btn = GameUtil.Instantiate(self.inputBtnPrefab)
			btn:SetActive(true)
			btn.transform:SetParent(self.inputContainer)
			btn.transform.localScale = Vector3.one
		end
		local txt = LuaGameUtil.GetTextComponent(btn.transform, "Text")
		txt.text = v
		self.btn2InputCmd[btn] = v
		EventListener.Get(btn, self).onClick = self.OnClickInputCmdButton
	end

	local msg = table.concat(self.inputCmd, "|")
	PlayerPrefs.SetString("DebugLogInputCmd", msg)
end

function DebugLogWindow:OnClickInputCmdButton(go)
	local cmd = self.btn2InputCmd[go]
	if cmd ~= nil then
		self:ExecuteCommand(cmd)
	end
end

function DebugLogWindow:OnClickPageButton(go)
	for btn,index in pairs(self.pageBtn2Index) do
		local img = btn:GetComponent(Image)
		if btn == go then
			img.color = CommonUtil.highlightColor
		else
			img.color = Color.white
		end
		local btnList = self.page2Gm[index].btnList
		if btnList ~= nil then
			for btn,data in pairs(btnList) do
				btn:SetActive(false)
			end
		end
	end

	local page = self.pageBtn2Index[go]
	local pageGm = self.page2Gm[page].cfgList
	local btnList = self.page2Gm[page].btnList
	if pageGm ~= nil then
		if btnList ~= nil then
			self.btn2GM = btnList
			for btn,data in pairs(btnList) do
				btn:SetActive(true)
			end
		else
			self.btn2GM = {}
			for i,v in ipairs(pageGm) do
				local btn = GameUtil.Instantiate(self.btnPrefab)
				btn:SetActive(true)
				btn.transform:SetParent(self.btnsContainer)
				btn.transform.localScale = Vector3.one
				local txt = LuaGameUtil.GetTextComponent(btn.transform, "Text")
				txt.text = v.name
				EventListener.Get(btn, self).onClick = self.OnClickGMButton
				self.btn2GM[btn] = v
			end
			self.page2Gm[page].btnList = self.btn2GM
		end

	end
end

function DebugLogWindow:OnClickGMButton(go)
	for btn,data in pairs(self.btn2GM) do
		if btn == go then
			local text = data.command
			local cmdList = string.split(text, ";")
			if cmdList ~= nil then
				for _,cmd in ipairs(cmdList) do
					self:ExecuteCommand(cmd)
				end
			end
		end
	end
end

function DebugLogWindow:ExecuteCommand(text)
	local cmdList = string.split(text, ";")
	if cmdList ~= nil then
		for _,cmd in ipairs(cmdList) do
			self:ExecuteCommandSingle(cmd)
		end
	end
end

function DebugLogWindow:ExecuteCommandSingle(text)
	if text == "config" then
		self.debugDetailText.text = Application.persistentDataPath
		return
	end

	if text == "showAds" then
		OzAdsManager.Instance:ShowTestView()
		--OzAdsManager.Instance:ShowAd("zftec8JjiMqez0dajlG")
		return
	end

	if text.StartWith(text, "dostring") then
		local subStr = string.Replace(text, "dostring", "")
		if OzLuaManager.Instance ~= nil then
			OzLuaManager.Instance:DoString(subStr)
		end
		return
	end

	if text.StartWith(text, "dofile") then
		local subStr = string.Replace(text, "dofile", "")
		subStr = string.Trim(subStr)
		if OzLuaManager.Instance ~= nil then
			local logic = OzLuaManager.Instance:DoFile(subStr)
			if logic ~= nil then
				logic:Start()
			end
		end
		return
	end

	if text.StartWith(text, "skill") then
		local subStr = string.Replace(text, "skill", "")
		subStr = string.Trim(subStr)
		local skill_id = tonumber(subStr)
		local myself = GameBattleManager.Instance().myself
		if myself ~= nil then
			myself:AddSkill(skill_id)
		end
	end

	if text == "clear_all_skill" then
		local myself = GameBattleManager.Instance().myself
		if myself ~= nil then
			myself:RemoveAllSkill()
		end
	end

	self.debugDetailText.text = text
end

function DebugLogWindow:OnClearDebugDetailText()
	self.debugDetailText.text = ""
	self.inputCmd = {}
	self:UpdateInputList()
end

return DebugLogWindow
