
---------------------------------------------------------------------------------------------------
--
--filename: game.joystick.JoystickCtrl
--date:2019/9/23 11:55:04
--author:heguang
--desc:虚拟摇杆
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.joystick.JoystickCtrl'
local JoystickCtrl = lua_declare(strClassName, lua_class(strClassName))

function JoystickCtrl:Start()
	self.mIsVirtualJoystick = false
	self.mIsKeyboard = false

	local touchInput = OzTouchInput.Get (self.gameObject)
	touchInput:SetRetrictArea(ScreenArea.FullScreen)

	local scale = 0.8
	self.transform.localScale = Vector3(scale, scale, scale)

	self.joystick = self.transform:FindChild("Joystick")
	self.joystickObj = self.joystick.gameObject
	self.thumb = self.joystick:FindChild ("thumb")
	self.direction = self.joystick:FindChild("direction")
	local thumbSize = self.thumb.sizeDelta
	local size = self.joystick.sizeDelta
	self.realRadius = size.x * 0.5 - thumbSize.x * 0.5
	self.directionAngle = Vector3(0, 0, 0)
	self.defaultCenter = self.joystick.localPosition
	self.joystickObj:SetActive(false)

	local function OnTouchDown (pos)
		self.mIsVirtualJoystick = touchInput:CheckPosition(pos)
		if not self.mIsVirtualJoystick then
			return
		end
		self.joystickObj:SetActive(true)
		self.center = self:SetJoystickCenter(pos)
		self.joystick.localPosition = self.center
		self:CalculateJoystickAxis(pos)
		if OzJoystick.On_JoystickMoveStart ~= nil then 
			OzJoystick.On_JoystickMoveStart(OzJoystick)
		end
	end

	local function OnTouchMove (pos)
		if not self.mIsVirtualJoystick then 
			return
		end
		self:CalculateJoystickAxis(pos);

		if OzJoystick.On_JoystickMove ~= nil then 
			OzJoystick.On_JoystickMove(OzJoystick)
		end
	end

	local function OnTouchUp (pos)
		self.mIsVirtualJoystick = false;
		self.thumb.localPosition = Vector3.zero
		self.joystick.localPosition = self.defaultCenter
		self.joystickObj:SetActive(false)
		OzJoystick.joystickAxis.x = 0
		OzJoystick.joystickAxis.y = 0
		if OzJoystick.On_JoystickMoveEnd ~= nil then 
			OzJoystick.On_JoystickMoveEnd(OzJoystick)
		end
	end

	local function OnCheckGUI(pos)
		local hittedObject = self:UiHitted(pos)
		if hittedObject ~= nil then
			return true
		end
		return false
	end

	touchInput.touchInputDownEventHandler = OnTouchDown;
	touchInput.touchInputMoveEventHandler = OnTouchMove;
	touchInput.touchInputUpEventHandler = OnTouchUp;
	touchInput.touchInputCancelEventHandler = OnTouchUp;
	touchInput.checkGUIHandler = OnCheckGUI
end

function JoystickCtrl:Update()
	if not self.mIsVirtualJoystick then
		local offset = Vector2(Input.GetAxis("Horizontal"), Input.GetAxis("Vertical"));
		if offset.sqrMagnitude > 0.01 then
			offset = offset * self.realRadius
			if offset.magnitude > self.realRadius then
				offset = offset.normalized * self.realRadius
			end
			self.thumb.localPosition = offset
			local angle = Mathf.Atan2(offset.y, offset.x) * 180 / Mathf.PI
			self.directionAngle.z = angle
			self.direction.eulerAngles = self.directionAngle
			OzJoystick.joystickAxis.x = offset.x / self.realRadius
			OzJoystick.joystickAxis.y = offset.y / self.realRadius
			if self.mIsKeyboard then 
				if OzJoystick.On_JoystickMove ~= nil then 
					OzJoystick.On_JoystickMove(OzJoystick)
				end
			else
				self.mIsKeyboard = true
				self.joystickObj:SetActive(true)
				if OzJoystick.On_JoystickMoveStart ~= nil then 
					OzJoystick.On_JoystickMoveStart(OzJoystick)
				end
			end
		else
			if self.mIsKeyboard then 
				self.mIsKeyboard = false
				OzJoystick.joystickAxis.x = 0
				OzJoystick.joystickAxis.y = 0
				self.thumb.localPosition = Vector2.zero
				self.joystick.localPosition = self.defaultCenter
				self.joystickObj:SetActive(false)
				if OzJoystick.On_JoystickMoveEnd ~= nil then 
					OzJoystick.On_JoystickMoveEnd(OzJoystick)
				end
			end
		end
	end
end

function JoystickCtrl:UiHitted(pos)
	if EventSystem.current ~= nil then
		local pe = PointerEventData(EventSystem.current)
		pe.position = pos

		local hits = ListRaycastResult()
		EventSystem.current:RaycastAll( pe, hits )
		for i=0,hits.Count-1 do
			local raycast = hits:getItem(i)
			local go = raycast.gameObject
			local rct = go:GetComponent(RectTransform)
			if rct ~= nil then
				return go
			end
		end
	end
end

function JoystickCtrl:SetJoystickCenter (pos)
	local center = self:Screen2LocalPos (pos)
	return center
	--[[
	if center.magnitude > self.realRadius then
		return center
	else
		return Vector2.zero
	end
	--]]
end

function JoystickCtrl:Screen2LocalPos (pos)
	local camera = UIManager.Instance.uiCamera
	local res, localPosition = RectTransformUtility.ScreenPointToLocalPointInRectangle (self.transform, pos, camera, Slua.out)
	return localPosition
end

function JoystickCtrl:CalculateJoystickAxis(pos)
	local offset = self:Screen2LocalPos(pos)
	offset = offset - self.center
	if offset.magnitude > self.realRadius then
		offset = offset.normalized * self.realRadius
	end
	self.thumb.localPosition = offset

	local angle = Mathf.Atan2(offset.y, offset.x) * 180 / Mathf.PI
	self.directionAngle.z = angle
	self.direction.eulerAngles = self.directionAngle

	OzJoystick.joystickAxis.x = offset.x / self.realRadius
	OzJoystick.joystickAxis.y = offset.y / self.realRadius
end

return JoystickCtrl
