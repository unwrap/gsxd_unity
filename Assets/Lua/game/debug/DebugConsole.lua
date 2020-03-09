
---------------------------------------------------------------------------------------------------
--
--filename: game.debug.DebugConsole
--date:2019/10/9 16:40:52
--author:heguang
--desc:�������
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.debug.DebugConsole'
local DebugConsole = lua_declare(strClassName, lua_class(strClassName))

function DebugConsole:Start()
	self.debugLogWindow = self.transform:FindChild("DebugLogWindow")
	self.logWindowCanvasGroup = self.debugLogWindow.gameObject:GetComponent(CanvasGroup)
	local btnCloseWindow = self.debugLogWindow:FindChild("TopButtons/CloseButton")
	EventListener.Get(btnCloseWindow, self).onClick = self.OnWindowClose

	self.debugLogPopup = self.transform:FindChild("DebugLogPopup")
	self.debugLogPopupCanvasGroup = self.debugLogPopup.gameObject:GetComponent(CanvasGroup)

	local btnDrag = self.debugLogWindow:FindChild("DebugLogWindowDrag")
	local windowDragListener = DragEventListener.Get(btnDrag, self)
	windowDragListener.onBeginDrag = self.OnWindowDragStarted
	windowDragListener.onDrag = self.OnWindowDrag
	windowDragListener.onEndDrag = self.OnWindowDragEnded

	local btnResize = self.debugLogWindow:FindChild("DebugLogWindowResize")
	DragEventListener.Get(btnResize, self).onDrag = self.OnWindowResize

	self.isPopupBeingDragged = false
	local popupDragListener = DragEventListener.Get(self.debugLogPopup, self)
	popupDragListener.onBeginDrag = self.OnPopupDragStarted
	popupDragListener.onDrag = self.OnPopupDrag
	popupDragListener.onEndDrag = self.OnPopupDragEnded

	EventListener.Get(self.debugLogPopup, self).onClick = self.OnPopupClick
	DropEventListener.Get(self.debugLogPopup, self).onDrop = self.OnWindowDrop

	self.halfSize = self.debugLogPopup.sizeDelta * 0.5
	--self.halfSize = Vector2.zero

	self.isPopupMoveAnim = false
	self.popupMoveTime = 0
	self.popupMoveTimer = 0
	self.popupStartPos = nil
	self.popupEndPos = nil

	self.isPopupFadeAnim = false
	self.popupFadeTime = 0.2
	self.popupFadeTimer = 0
	self.popupFadeStartAlpha = 0
	self.popupFadeEndAlpha = 0

	self.isLogWindowVisible = false
	self.logWindowMinWidth = 250
	self.logWindowMinHeight = 200

	local size = self.debugLogWindow.sizeDelta
	local w = PlayerPrefs.GetFloat("DebugLogWindowWidth", size.x)
	local h = PlayerPrefs.GetFloat("DebugLogWindowHeight", size.y)
	self.debugLogWindow.sizeDelta = Vector2(w,h)

	local pos = self.debugLogWindow.anchoredPosition
	local x = PlayerPrefs.GetFloat("DebugLogWindowX", pos.x)
	local y = PlayerPrefs.GetFloat("DebugLogWindowY", pos.y)
	self.debugLogWindow.anchoredPosition = Vector3( x, y, 0 )

	pos = self.debugLogPopup.anchoredPosition
	x = PlayerPrefs.GetFloat("DebugLogPopupX", pos.x)
	y = PlayerPrefs.GetFloat("DebugLogPopupY", pos.y)
	self.debugLogPopup.anchoredPosition = Vector2(x,y)

	--��ʼ��ʾ����������GM��
	self:SetWindowInvisible()
	self:SetPopupVisible()

	self.debugShow = true
	self.isOverturn = false
	self.debugLogPopup.gameObject:SetActive(self.debugShow)

	OzMessage:addEvent("MsgOpenGmPanel", self.MsgOpenGmPanel, self)
end

function DebugConsole:OnDestroy()
	OzMessage:removeEvent("MsgOpenGmPanel", self.MsgOpenGmPanel, self)
end

function DebugConsole:MsgOpenGmPanel(msg)
	if msg.open then
		self.logWindowCanvasGroup.interactable = true
		self.logWindowCanvasGroup.blocksRaycasts = true
		self.logWindowCanvasGroup.alpha = 1
		self.isLogWindowVisible = true

		if self.windowLastPosition ~= nil then
			self.debugLogWindow.localPosition = self.windowLastPosition
		end

		self.debugLogWindow.gameObject:SetActive(true)
	end
end

function DebugConsole:CheckOverturn()
	if Input.acceleration.z  > 0.8 then
		if not self.isOverturn then
			self.isOverturn = true
			self.debugShow = not self.debugShow
			self.debugLogPopup.gameObject:SetActive(self.debugShow)
		end
	else
		self.isOverturn = false
	end
end

function DebugConsole:Update()
	self:CheckOverturn()

	local deltaTime = Time.deltaTime
	if self.isPopupMoveAnim then
		self.popupMoveTimer = self.popupMoveTimer + deltaTime
		if self.popupMoveTimer < self.popupMoveTime then
			local pos = Vector2.Lerp( self.popupStartPos, self.popupEndPos, self.popupMoveTimer / self.popupMoveTime)
			self.debugLogPopup.anchoredPosition = pos
		else
			self.isPopupMoveAnim = false
			self.debugLogPopup.anchoredPosition = self.popupEndPos
		end
	end

	if self.isPopupFadeAnim then
		self.popupFadeTimer = self.popupFadeTimer + deltaTime
		if self.popupFadeTimer < self.popupFadeTime then
			local a = Mathf.Lerp( self.popupFadeStartAlpha, self.popupFadeEndAlpha, self.popupFadeTimer / self.popupFadeTime)
			self.debugLogPopupCanvasGroup.alpha = a
		else
			self.isPopupFadeAnim = false
			self.debugLogPopupCanvasGroup.alpha = self.popupFadeEndAlpha
		end
	end
end

--��ʾGM��
function DebugConsole:SetWindowVisible()
	--OzMessage:SendMessage({}, "MsgOpenGmPanel")
	OzMessage:dispatchEvent("MsgOpenGmPanel", {open=true})
end

--����GM��
function DebugConsole:SetWindowInvisible()
	self.logWindowCanvasGroup.interactable = false
	self.logWindowCanvasGroup.blocksRaycasts = false
	self.logWindowCanvasGroup.alpha = 0
	self.isLogWindowVisible = false
	self.debugLogWindow.gameObject:SetActive(false)
end

function DebugConsole:OnWindowDragStarted(eventData)
	local pos = GameUtil.ScreenToUIPoint(eventData.position)
	self.windowDragDeltaPosition = self.debugLogWindow.localPosition - pos
	self.windowLastPosition = self.debugLogWindow.localPosition
	self:SetPopupVisible()
end

function DebugConsole:OnWindowDrag(eventData)
	local pos = GameUtil.ScreenToUIPoint(eventData.position)
	self.debugLogWindow.localPosition = pos + self.windowDragDeltaPosition
end

function DebugConsole:OnWindowDragEnded(eventData)
	--[[
	local pos = self.debugLogWindow.anchoredPosition
	local canvas = UIManager.Instance.canvas
	local canvasTransform = canvas.transform
	local size = canvasTransform.sizeDelta
	pos.x = Mathf.Clamp( pos.x, 0, size.x )
	pos.y = Mathf.Clamp( pos.y, -size.y, 0 )
	self.debugLogWindow.anchoredPosition = pos + self.windowDragDeltaPosition
	--]]
	if self.isLogWindowVisible then
		self:SetPopupInvisible()
	end
end

function DebugConsole:OnWindowResize(eventData)
	local pos = GameUtil.ScreenToUIPoint(eventData.position)

	local newSize = pos - self.debugLogWindow.localPosition
	newSize.y = -newSize.y

	if newSize.x < self.logWindowMinWidth then
		newSize.x = self.logWindowMinWidth
	end

	if newSize.y < self.logWindowMinHeight then
		newSize.y = self.logWindowMinHeight
	end

	self.debugLogWindow.sizeDelta = newSize

	PlayerPrefs.SetFloat("DebugLogWindowWidth", newSize.x)
	PlayerPrefs.SetFloat("DebugLogWindowHeight", newSize.y)
end

function DebugConsole:OnWindowClose()
	self:SetWindowInvisible()
	self:SetPopupVisible()

	self.windowLastPosition = self.debugLogWindow.localPosition

	local pos = self.debugLogWindow.anchoredPosition
	PlayerPrefs.SetFloat("DebugLogWindowX", pos.x)
	PlayerPrefs.SetFloat("DebugLogWindowY", pos.y)
end

function DebugConsole:OnWindowDrop(eventData)
	self:SetWindowInvisible()
end

--��ʾ������
function DebugConsole:SetPopupVisible()
	self.debugLogPopupCanvasGroup.interactable = true
	self.debugLogPopupCanvasGroup.blocksRaycasts = true

	self:OnPopupDragEnded()

	self.isPopupFadeAnim = true
	self.popupFadeTime = 0.2
	self.popupFadeTimer = 0
	self.popupFadeStartAlpha = self.debugLogPopupCanvasGroup.alpha
	self.popupFadeEndAlpha = 1
end

--���ظ�����
function DebugConsole:SetPopupInvisible()
	self.debugLogPopupCanvasGroup.interactable = false
	self.debugLogPopupCanvasGroup.blocksRaycasts = false

	self.isPopupFadeAnim = true
	self.popupFadeTime = 0.2
	self.popupFadeTimer = 0
	self.popupFadeStartAlpha = self.debugLogPopupCanvasGroup.alpha
	self.popupFadeEndAlpha = 0
end

function DebugConsole:OnPopupClick()
	if not self.isPopupBeingDragged then
		self:SetWindowVisible()
		self:SetPopupInvisible()
	end
end

function DebugConsole:OnPopupDragStarted(eventData)
	self.isPopupBeingDragged = true
end

function DebugConsole:OnPopupDrag(eventData)
	local pos = GameUtil.ScreenToUIPoint(eventData.position)
	self.debugLogPopup.localPosition = pos
end

function DebugConsole:OnPopupDragEnded(eventData)
	self.isPopupBeingDragged = false

	local canvas = UIManager.Instance.canvas
	local canvasTransform = canvas.transform
	local size = canvasTransform.sizeDelta

	local pos = self.debugLogPopup.anchoredPosition

	local dist2Left = pos.x
	local dist2Right = size.x - pos.x
	local dist2Top = Mathf.Abs(pos.y)
	local dist2Bottom = size.y - Mathf.Abs(pos.y)

	local horDistance = Mathf.Min( dist2Left, dist2Right )
	local vertDistance = Mathf.Min( dist2Top, dist2Bottom )
	self.popupStartPos = pos

	if horDistance < vertDistance then
		if dist2Left < dist2Right then
			pos = Vector2(self.halfSize.x, pos.y)
		else
			pos = Vector2(size.x - self.halfSize.x, pos.y)
		end
	else
		if dist2Top < dist2Bottom then
			pos = Vector2(pos.x, -self.halfSize.y)
		else
			pos = Vector2(pos.x, -(size.y - self.halfSize.y))
		end
	end

	--self.debugLogPopup.anchoredPosition = pos
	self.isPopupMoveAnim = true
	self.popupEndPos = pos
	self.popupMoveTime = Vector2.Distance( self.popupStartPos, self.popupEndPos) / 1000
	self.popupMoveTimer = 0

	PlayerPrefs.SetFloat("DebugLogPopupX", pos.x)
	PlayerPrefs.SetFloat("DebugLogPopupY", pos.y)
end


return DebugConsole
