
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.MainBottom
--date:2019/11/22 23:11:45
--author:heguang
--desc:主界面底部
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.MainBottom'
local MainBottom = lua_declare(strClassName, lua_class(strClassName))

function MainBottom:Start()
	local buttonList = self.transform:Find("ButtonList")
	local numChild = buttonList.childCount
	self.offset = 750 / 2
	self.defaultSize = 750 / (numChild + 1)

	self.buttons = {}
	self.selectedIndex = 1
	for i=0, numChild-1 do
		local childTransform =buttonList:GetChild(i)
		EventListener.Get(childTransform, self).onClick = self.OnClickButton
		table.insert(self.buttons, {tf = childTransform})
	end
	self.selectedButton = self.buttons[self.selectedIndex].tf.gameObject

	self.selectedFlag = self.transform:Find("ImageFlag")
	self.selectedFlag.sizeDelta = Vector2(self.defaultSize*2, 125)
	self.selectedFlagCurrentPosition = self.selectedFlag.anchoredPosition

	self.selectedAnim = false
	self.selectedTimer = 0
	self.selectedTime = 1.0

	self.adjust = false
	self.adjustTimer = 0
	self.adjustTime = 0.1

	--self:OnClickButton(self.selectedButton)
end

function MainBottom:Update()
	if self.adjust then
		self.adjustTimer = self.adjustTimer + Time.deltaTime
		if self.adjustTimer < self.adjustTime then
			local t = self.adjustTimer / self.adjustTime
			for i,item in ipairs(self.buttons) do
				local pos = Vector2.Lerp(item.currentPos, item.pos, t)
				local size = Vector2.Lerp(item.currentSize, item.size, t)
				item.tf.anchoredPosition = pos
				item.tf.sizeDelta = size
			end
		else
			self.adjust = false
			for i,item in ipairs(self.buttons) do
				item.tf.anchoredPosition = item.pos
				item.tf.sizeDelta = item.size
			end
		end
	end

	if self.selectedAnim then
		self.selectedTimer = self.selectedTimer + Time.deltaTime
		if self.selectedTimer < self.selectedTime then
			local t = self.selectedTimer / self.selectedTime
			self.selectedFlag.anchoredPosition = Vector2.Lerp(self.selectedFlagCurrentPosition, self.selectedFlagPosition, Ease.ElasticOut(t))
		else
			self.selectedAnim = false
			self.selectedFlag.anchoredPosition = self.selectedFlagPosition
		end
	end
end

function MainBottom:SetCurrentIndex(idx)
	if idx < 1 or idx > #self.buttons then
		return
	end
	self:OnClickButton(self.buttons[idx].tf.gameObject, false)
end

function MainBottom:OnClickButton(go, notify)
	if self.selectedButton == go then
		return
	end
	if notify == nil then
		notify = true
	end
	local pos = 0
	for i,v in ipairs(self.buttons) do
		local size
		local yPos = 0
		local textObj = v.tf:Find("Text").gameObject
		if v.tf.gameObject == go then
			self.selectedIndex = i
			self.selectedButton = go
			size = self.defaultSize * 2
			yPos = 20
			textObj:SetActive(true)
		else
			size = self.defaultSize
			yPos = 0
			textObj:SetActive(false)
		end
		v.size = Vector2(size, 125)
		v.pos = Vector2(pos + size * 0.5 - self.offset, yPos)
		v.currentSize = v.tf.sizeDelta
		v.currentPos = v.tf.anchoredPosition
		pos = pos + size
	end
	self.adjust = true
	self.adjustTimer = 0

	self.selectedAnim = true
	self.selectedTimer = 0
	self.selectedFlagCurrentPosition = self.selectedFlag.anchoredPosition
	self.selectedFlagPosition = Vector2(self.buttons[self.selectedIndex].pos.x, 0)

	if notify then
		OzMessage:dispatchEvent(CommonEvent.MainPageChange, self.selectedIndex)
	end
end


return MainBottom
