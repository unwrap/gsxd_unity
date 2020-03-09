
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.MainPageScrollSnap
--date:2019/11/20 17:06:27
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.MainPageScrollSnap'
local MainPageScrollSnap = lua_declare(strClassName, lua_class(strClassName))

function MainPageScrollSnap:Start()
	---[[
	self.scroll = self.gameObject:GetComponent(ScrollRect)
	self.scroll.inertia = false
	self.scroll.horizontal = true
	self.scroll.vertical = false
	--]]
	self.isDrag = false
	self.scrollSpeed = 8
	self.targetPagePosition = 0
	self.currentIdx = 1
	self.pageArray = {}

	self.dragSpeedCritical = 20
	self.dragSpeed = 0

	self.contentContainer = self.transform:Find("Content")
	self:SetPageSize()
end

function MainPageScrollSnap:SetPageSize()
	self.totalPage = self.contentContainer.childCount
	local logicList = {
		"game.ui.page.StorePage",
		"game.ui.page.BagPage",
		"game.ui.page.ScenePage",
		"game.ui.page.MissionPage",
		"game.ui.page.SettingPage",
	}
	for i=0, self.totalPage - 1 do
		local tf = self.contentContainer:GetChild(i)
		tf.sizeDelta = UIManager.Instance.size
		local logic = LuaGameUtil.DoFile(tf.gameObject, logicList[i+1])
		logic:SetPosition( i / (self.totalPage - 1), i + 1)
		table.insert(self.pageArray,logic)
	end

	local drag = DragEventListener.Get(self.gameObject, self)
	drag.onBeginDrag = self.OnBeginDrag
	drag.onEndDrag = self.OnEndDrag
	drag.onDrag = self.OnDrag

	--self:SetCurrentPageIndex(self.currentIdx)
end

function MainPageScrollSnap:Update()
	if not self.isDrag then
		self.scroll.horizontalNormalizedPosition = Mathf.Lerp(self.scroll.horizontalNormalizedPosition, self.targetPagePosition, self.scrollSpeed * Time.deltaTime)
	end
end

function MainPageScrollSnap:SetCurrentPageIndex(idx)
	self.currentIdx = idx
	local logic = self.pageArray[self.currentIdx]
	self.targetPagePosition = logic.pos
	logic:ShowPage()
end

function MainPageScrollSnap:GetCurrentPageIndex()
	return self.currentIdx
end

function MainPageScrollSnap:ToLeft()
	if self.currentIdx > 1 then
		self:SetCurrentPageIndex(self.currentIdx - 1)
		self:DispatchPageEvent()
	end
end

function MainPageScrollSnap:ToRight()
	if self.currentIdx < self.totalPage then
		self:SetCurrentPageIndex(self.currentIdx + 1)
		self:DispatchPageEvent()
	end
end

function MainPageScrollSnap:DispatchPageEvent()
	OzMessage:dispatchEvent(CommonEvent.MainPageChange, self.currentIdx)
end

function MainPageScrollSnap:FindNearest()
	local posX = self.scroll.horizontalNormalizedPosition
	local idx = 1
	local minOffset = Mathf.Abs(self.pageArray[idx].pos - posX)
	for i,v in ipairs(self.pageArray) do
		local offset = Mathf.Abs(v.pos - posX)
		if offset < minOffset then
			idx = i
			minOffset = offset
		end
	end
	return idx
end

function MainPageScrollSnap:OnBeginDrag(eventData)
	self.isDrag = true
end

function MainPageScrollSnap:OnEndDrag(eventData)
	self.isDrag = false
	if Mathf.Abs(self.dragSpeed) > self.dragSpeedCritical then
		if self.dragSpeed > 0 then
			self:ToLeft()
		else
			self:ToRight()
		end
	else
		local idx = self:FindNearest()
		if self.currentIdx ~= idx then
			self.currentIdx = idx
			self:DispatchPageEvent()
		end
		self.targetPagePosition = self.pageArray[self.currentIdx].pos
	end
end

function MainPageScrollSnap:OnDrag(eventData)
	self.dragSpeed = eventData.delta.x
end

return MainPageScrollSnap
