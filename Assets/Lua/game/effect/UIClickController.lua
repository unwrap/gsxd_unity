
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.UIClickController
--date:3/17/2017 9:58:54 AM
--author:heguang
--desc:按钮点击效果
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.UIClickController'
local UIClickController = lua_declare(strClassName, lua_class(strClassName))

function UIClickController:Start()
	self.mAnimator = self.gameObject:GetComponent(Animator)
	if self.mAnimator ~= nil then
		self.clickAnimTime = self.mAnimator:GetClipLength("Pressed")
	else
		self.clickAnimTime = 0
	end

	self.isAnim = false
	self.animTimer = 0
	self.animTime = 0.2

	self.isDestroy = false

	self.defaultScale = self.transform.localScale
	self.fromScale = self.defaultScale * 0.9
end

function UIClickController:OnDestroy()
	self.isDestroy = true
end

function UIClickController:OnEnable()
	self.transform.localScale = self.defaultScale
end

function UIClickController:OnClick()
	if self.isDestroy then
		return 0
	end

	if self.mAnimator ~= nil then
		self.mAnimator:SetTrigger("Pressed")
		return 0.1
	else
		SoundManager.PlaySound("button1")
		self.fromScale.x = self.defaultScale.x * 0.9
		self.fromScale.y = self.defaultScale.y * 0.9
		self.fromScale.z = self.defaultScale.z * 0.9
		self.transform.localScale = self.fromScale
		self.isAnim = true
		self.animTimer = 0
		return 0.1
	end
end

function UIClickController:Update()
	if self.isAnim then
		self.animTimer = self.animTimer + Time.deltaTime
		if self.animTimer < self.animTime then
			local t = self.animTimer / self.animTime
			t = Ease.QuadInOut(t)
			self.transform.localScale = Vector3.Lerp( self.fromScale, self.defaultScale, t)
		else
			self.transform.localScale = self.defaultScale
			self.isAnim = false
			self.animTimer = 0
		end
	end
end

return UIClickController
