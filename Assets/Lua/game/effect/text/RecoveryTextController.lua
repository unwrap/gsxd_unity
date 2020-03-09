
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.text.RecoveryTextController
--date:2019/10/14 15:06:08
--author:heguang
--desc:回复文字动画
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.text.RecoveryTextController'
local RecoveryTextController = lua_declare(strClassName, lua_class(strClassName))
local waitTime = 0.2
local animationTime = 0.6
local animationLength = 40

function RecoveryTextController:Start()
	self.canvasGroup = self.gameObject:GetComponent(CanvasGroup)
	self.textLable = self.gameObject:GetComponentInChildren(Text)

	self.moveObj = self.transform:GetChild(0)
	self.moveX = self.moveObj.localPosition.x

	self.isAnimation = false
	self.isWaiting = false
	self.animationTimer = 0
end

function RecoveryTextController:OnDestroy()
	self.owner = nil
end

function RecoveryTextController:SetEntity(owner)
	self.owner = owner
end

function RecoveryTextController:Show(val)
	self.textLable.text = string.format("+%d", val)

	self.isAnimation = true
	self.isWaiting = true
	self.animationTimer = 0

	self.moveObj.localPosition = Vector3(self.moveX, 0, 0)
	self.canvasGroup.alpha = 1.0
end

function RecoveryTextController:Update()
	local deltaTime = Time.deltaTime
	
	if self.owner ~= nil then
		local uiPos = GameUtil.WorldToUIPoint(self.owner:GetPosition())
		self.transform.position = uiPos
	end

	self:Anim(deltaTime)
end

function RecoveryTextController:Anim( deltaTime )
	if not self.isAnimation then return end

	self.animationTimer = self.animationTimer + deltaTime
	if self.isWaiting then
		if self.animationTimer > waitTime then
			self.animationTimer = 0
			self.isWaiting = false
		else
			return
		end
	end

	if self.animationTimer < animationTime then
		local t = Mathf.Sin(90 * self.animationTimer / animationTime * Mathf.Deg2Rad)
		self.moveObj.localPosition = Vector3(self.moveX, animationLength * t, 0)
		self.canvasGroup.alpha = 1 - t
	else
		self.animationTimer = 0
		self.isAnimation = false
		self:OnAnimEnd()
	end
end

function RecoveryTextController:OnAnimEnd()
	self.owner = nil
	ObjectPool.Recycle(self.gameObject)
end

return RecoveryTextController
