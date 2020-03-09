
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.text.CriticalTextController
--date:2019/10/14 10:57:12
--author:heguang
--desc:暴击文字动画
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.text.CriticalTextController'
local CriticalTextController = lua_declare(strClassName, lua_class(strClassName))

local animationTime = 0.4
local animationMoveTime = 0.6
local animationLength = 40

function CriticalTextController:Start()
	self.moveTransform = self.transform:Find("MoveObj")
	self.transformA = self.moveTransform:FindChild("TextA")
	self.transformB = self.moveTransform:FindChild("TextB")

	self.textA = self.transformA:GetComponent(CanvasGroup)
	self.textB = self.transformB:GetComponent(CanvasGroup)
	self.moveX = self.moveTransform.localPosition.x

	self.dmgText = LuaGameUtil.GetTextComponent(self.transformA, "Text")
end

function CriticalTextController:OnDestroy()
	self.owner = nil
end

function CriticalTextController:SetEntity(owner)
	self.owner = owner
end

function CriticalTextController:Show(dmg)
	self.dmgText.text = tostring(dmg)

	self.textA.alpha = 1
	self.transformA.localScale = Vector3.one
	self.textB.alpha = 1
	self.transformB.localScale = Vector3.one
	self.moveTransform.localPosition = Vector3(self.moveX, 0, 0)

	self.isShowedAnimation = true
	self.animationTimer = 0
	self.isFadeAnimation = false

	self.isMoveAnimation = true
	self.moveTimer = 0
end

function CriticalTextController:Update()
	local deltaTime = Time.deltaTime

	if self.owner ~= nil then
		local uiPos = GameUtil.WorldToUIPoint(self.owner:GetPosition())
		self.transform.position = uiPos
	end
	
	--self:MoveAnimation(deltaTime)
	self:ShowedAnimation(deltaTime)
	self:FadeAnimation(deltaTime)
end

function CriticalTextController:MoveAnimation(deltaTime)
	if not self.isMoveAnimation then return end

	self.moveTimer = self.moveTimer + deltaTime
	if self.moveTimer < animationMoveTime then
		local t = Mathf.Sin(90 * self.animationTimer / animationTime * Mathf.Deg2Rad)
		self.moveTransform.localPosition = Vector3(self.moveX, animationLength * t, 0)
	end
end

function CriticalTextController:ShowedAnimation( deltaTime )
	if not self.isShowedAnimation then return end

	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animationTime then
		local t = Mathf.Sin( 90 * self.animationTimer / animationTime * Mathf.Deg2Rad )
		local a = Mathf.Lerp( 1.0, 0.0, t )
		local num = Mathf.Lerp( 1.0, 1.6, t )
		self.textB.alpha = a
		self.transformB.localScale = Vector3( num, num, 1.0 )
	else
		self.textB.alpha = 0
		self.transformB.localScale = Vector3( 1.6, 1.6, 1.0 )
		self.isShowedAnimation = false
		self.animationTimer = 0
		self.isFadeAnimation = true
	end
end

function CriticalTextController:FadeAnimation( deltaTime )
	if not self.isFadeAnimation then return end

	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animationTime then
		local t = Mathf.Sin( 90 * self.animationTimer / animationTime * Mathf.Deg2Rad )
		local a = Mathf.Lerp( 1.0, 0.0, t )
		local num = Mathf.Lerp( 1.0, 1.6, t )
		self.textA.alpha = a
		self.transformA.localScale = Vector3( num, num, 1.0 )
	else
		self.textA.alpha = 0
		self.transformA.localScale = Vector3( 1.6, 1.6, 1.0 )
		self.animationTimer = 0
		self.isFadeAnimation = false
		self:OnAnimEnd()
	end
end

function CriticalTextController:OnAnimEnd()
	self.owner = nil
	ObjectPool.Recycle(self.gameObject)
end

return CriticalTextController
