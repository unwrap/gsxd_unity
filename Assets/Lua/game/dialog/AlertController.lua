
---------------------------------------------------------------------------------------------------
--
--filename: game.dialog.AlertController
--date:2020/1/16 11:04:12
--author:heguang
--desc:提示消息
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.dialog.AlertController'
local AlertController = lua_declare(strClassName, lua_class(strClassName))

function AlertController:Start()
	self.canvasGroup = self.gameObject:GetComponentInChildren(CanvasGroup)
	self.moveTransform = self.transform:FindChild("bg")
	self.messageText = LuaGameUtil.GetTextComponent(self.moveTransform, "Text")
	self.itemIcon = LuaGameUtil.GetImageComponent(self.moveTransform, "Icon")

	self.mIsAnim = false
    self.mAnimTimer = 0
    self.mAnimState = 0
    self.mAnimTime = { 0.2, 0.8, 0.1 }
	self.totalTime = 0
    self.mStartMoveY = -300
	self:CalculateTotalTime()

	self.message = nil
end

function AlertController:OnDestroy()
	self.mIsAnim = false
end

function AlertController:Show(message, spriteName)
	self.message = message
	if self.messageText ~= nil then
		self.messageText.text = self.message
	end
	if self.itemIcon ~= nil and spriteName ~= nil then
		if type(spriteName) == "string" then
			self.itemIcon.sprite = AtlasFactory:GetItemSprite(spriteName)
		else
			self.itemIcon.sprite = spriteName
		end		
	end
	if self.canvasGroup ~= nil then
		self.canvasGroup.alpha = 0
	end

	if #self.message > 0 then
		self.mAnimTime[2] = 0.8 + #self.message * 0.02
	else
		self.mAnimTime[2] = 0.8
	end
	self:CalculateTotalTime()

	self.mIsAnim = true
	self.mAnimTimer = 0
	self.mAnimState = 1
	self.moveTransform.localPosition = Vector3(0, self.mStartMoveY, 0)
end

function AlertController:Remove()
	ObjectPool.Recycle(self.gameObject)
end

function AlertController:GetTotalTime()
	return self.totalTime - 0.1
end

function AlertController:CalculateTotalTime()
	self.totalTime = 0
	for _,v in ipairs(self.mAnimTime) do
		self.totalTime = self.totalTime + v
	end
end

function AlertController:Update()
	if not self.mIsAnim then
		return
	end
	self.mAnimTimer = self.mAnimTimer + Time.deltaTime
	local animTime = self.mAnimTime[self.mAnimState]
	if animTime == nil then
		self.mIsAnim = false
		return
	end
	local t = self.mAnimTimer / animTime
	if self.mAnimState == 1 then
		if self.mAnimTimer < animTime then
			if self.canvasGroup ~= nil then
				self.canvasGroup.alpha = t
			end
			local yPos = Mathf.Lerp( self.mStartMoveY, 0, t)
			self.moveTransform.localPosition = Vector3(0, yPos, 0)
		else
			if self.canvasGroup ~= nil then
				self.canvasGroup.alpha = 1
			end
			self.moveTransform.localPosition = Vector3(0, 0, 0)
			self.mAnimState = 2
			self.mAnimTimer = 0
		end
	elseif self.mAnimState == 2 then
		if self.mAnimTimer > animTime then
			self.mAnimTimer = 0
			self.mAnimState = 3
			Dialog.ClearAlert(self.gameObject)
		end
	elseif self.mAnimState == 3 then
		if self.mAnimTimer < animTime then
			if self.canvasGroup ~= nil then
				self.canvasGroup.alpha = 1 - t
			end
			local yPos = Mathf.Lerp(0, 10, t)
			self.moveTransform.localPosition = Vector3(0, yPos, 0)
		else
			self.mIsAnim = false
			self:Remove()
		end
	end
end

return AlertController
