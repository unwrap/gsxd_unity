
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.text.DamageTextController
--date:2019/10/14 0:12:59
--author:hegung
--desc:伤害文字动画
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.text.DamageTextController'
local DamageTextController = lua_declare(strClassName, lua_class(strClassName))

local animation01Time = 0.4
local animation02Time = 0.2
local animation03Time = 0.2

local moveW = {40,14,50}
local moveH = {70, 0, 30}
local scale = {1.1, 1, 0.7}

--伤害类型依次是 Normal, Crit, HeadShot, Rebound, Add, Block, Miss, HPMaxChange
local animTimes = {0.6, 0.83, 1.33, 0.6, 0.6, 0.6, 0.33}
local curves = {{12, 13, 14}, {15, 13, 14}, {16, 13, 14}, {12, 13, 14}, {12, 13, 14}}

function DamageTextController:Start()
	self.canvasGroup = self.gameObject:GetComponent(CanvasGroup)
	self.textObj = self.transform:GetChild(0)
	self.textLable = self.textObj:GetComponent(Text)
	self.textLable.text = ""
	self.titleText = ""
	self.showScale = 1
end

function DamageTextController:OnDestroy()
	self.owner = nil
end

function DamageTextController:SetEntity(owner)
	self.owner = owner
end

function DamageTextController:Show(dmg, hitType)
	if hitType == CommonUtil.hitType_headShot then
		self.titleText = LuaGameUtil.GetText(300001)
		self:Show01(dmg, 1)
	elseif hitType == CommonUtil.hitType_body then
		self.titleText = ""
		self.showScale = 1.5
		self:Show01(dmg, 3)
	elseif hitType == CommonUtil.hitType_crit then
		self.titleText = LuaGameUtil.GetText(300000)
		self:Show01(dmg, 1)
	else
		self.titleText = ""
		self:Show02(dmg, hitType)
	end
end

function DamageTextController:Show01( dmg, hitType )
	self.dmg = dmg
	self.hitType = hitType

	if Random.value > 0.5 then
		self.x_dir = 1
	else
		self.x_dir = -1
	end

	self.canvasGroup.alpha = 1
	self.textObj.localPosition = Vector3.zero
	self.textObj.localScale = Vector3.one * self.showScale
	self.textLable.text = self.titleText .. tostring(dmg)

	local y = Random.Range( -0.1, 5 )
	local dir = Vector3(self.x_dir, y, 0)
	self.toVector = dir.normalized * Random.Range( 50, 70 )

	---[[
	self.animationState = 1
	self.animationTimer = 0
	self.isAnimation = true
	--]]
end

function DamageTextController:Show02(dmg, hitType)
	self.dmg = dmg

	self.textLable.text = self.titleText .. tostring(self.dmg)
	self.textObj.localPosition = Vector3.zero
	self.textObj.localScale = Vector3.one

	self.hitType = hitType
	self.curve_pos = GameCurve.Instance:GetCurve( curves[self.hitType][1] )
	self.curve_scale = GameCurve.Instance:GetCurve( curves[self.hitType][2] )
	self.curve_alpha = GameCurve.Instance:GetCurve( curves[self.hitType][3] )

	self.currentMoveCount = 10
	local offsetX = LuaMath.Random(-5, 5)
	local offsetY = LuaMath.Random(0, 5)
	self.movePer = Vector2(offsetX, offsetY)
	self.moveAll = Vector2.zero

	self.animationTimer = 0
	self.animationTime = animTimes[self.hitType]
	self.isAnimationCurve = true

	self:Update()
end

function DamageTextController:Update()
	local deltaTime = Time.deltaTime
	if self.owner ~= nil then
		local uiPos = GameUtil.WorldToUIPoint(self.owner:GetPosition())
		self.transform.position = uiPos
	end
	self:Anim(deltaTime)
	self:AnimCurve(deltaTime)
end

function DamageTextController:AnimCurve(deltaTime)
	if not self.isAnimationCurve then return end
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < self.animationTime then
		local t = self.animationTimer / self.animationTime
		if self.currentMoveCount > 0 then
			self.currentMoveCount = self.currentMoveCount - 1
			self.moveAll = self.moveAll + self.movePer
		end
		local moveY = self.curve_pos:Evaluate(t)
		self.textObj.localPosition = self.moveAll + Vector3(0, moveY, 0)
		self.textObj.localScale = Vector3.one * self.curve_scale:Evaluate(t)
		self.canvasGroup.alpha = self.curve_alpha:Evaluate(t)
	else
		self.isAnimationCurve = false
		self:OnAnimEnd()
	end
end

function DamageTextController:Anim( deltaTime )
	if not self.isAnimation then return end

	if self.hitType == 1 then
		if self.animationState == 1 then
			self:Anim01Weak(deltaTime)
		elseif self.animationState == 2 then
			self:Anim02Weak(deltaTime)
		elseif self.animationState == 3 then
			self:Anim03Weak(deltaTime)
		end
	elseif self.hitType == 2 then
		self:AnimNormal(deltaTime)
	elseif self.hitType == 3 then
		if self.animationState == 1 then
			self:Anim01Strong(deltaTime)
		elseif self.animationState == 2 then
			self:Anim02Strong(deltaTime)
		elseif self.animationState == 3 then
			self:Anim03Strong(deltaTime)
		end
	end
	
end

function DamageTextController:Anim01Weak( deltaTime )
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation01Time then
		local t = self.animationTimer / animation01Time
		local x = moveW[self.hitType] * t * self.x_dir
		local y = moveH[self.hitType] * Mathf.Sin( 180 * t * Mathf.Deg2Rad )
		local d = Mathf.SmoothStep( 1.0, scale[self.hitType], t )
		local num = math.ceil( Mathf.SmoothStep( 0, self.dmg, t ) )

		self.canvasGroup.alpha = t
		self.textObj.localPosition = Vector3( x, y, 0 )
		self.textObj.localScale = Vector3.one * d * self.showScale
		self.textLable.text = self.titleText .. tostring(num)
	else
		self.textLable.text = self.titleText .. tostring(self.dmg)
		self.animationTimer = 0
		self.animationState = 2
	end
end

function DamageTextController:Anim02Weak( deltaTime )
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation02Time then
		local t = self.animationTimer / animation02Time
		local x = ( moveW[self.hitType] + moveW[self.hitType] * t * 0.6 ) * self.x_dir

		local y = moveH[self.hitType] * 0.6 * Mathf.Sin( 180 * t * Mathf.Deg2Rad )
		self.textObj.localPosition = Vector3( x, y, 0 )
	else
		self.animationTimer = 0
		self.animationState = 3

		self.isAnimation = false
		self:OnAnimEnd()
	end
end

function DamageTextController:Anim03Weak( deltaTime )
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation03Time then
		local t = self.animationTimer / animation03Time
		local x = ( moveW[self.hitType] + moveW[self.hitType] * 0.6 + moveW[self.hitType] * t * 0.3 ) * self.x_dir
		local y = moveH[self.hitType] * 0.3 * Mathf.Sin( 180 * t * Mathf.Deg2Rad )
		self.textObj.localPosition = Vector3( x, y, 0 )
		self.canvasGroup.alpha = (1 - t)
	else
		self.textObj.localPosition = Vector3( ( moveW[self.hitType] + moveW[self.hitType] * 0.6 + moveW[self.hitType] * 0.3 ) * self.x_dir, moveH[self.hitType] * 0.3, 0 )
		self.animationTimer = 0
		self.animationState = 1
		self.isAnimation = false;
		self:OnAnimEnd()
	end
end

function DamageTextController:AnimNormal( deltaTime )
	if not self.isAnimation then return end

	self.animationTimer = self.animationTimer + deltaTime
	local time = animation01Time + animation02Time + animation03Time

	if self.animationTimer < time then
		local t = Mathf.Sin( 90 * self.animationTimer / time * Mathf.Deg2Rad )
		local localPosition = Vector3.Lerp( Vector3.zero, self.toVector, t )
		self.textObj.localPosition = localPosition
	else
		self.animationTimer = 0
		self.isAnimation = false
		self:OnAnimEnd()
	end
end

function DamageTextController:Anim01Strong(deltaTime)
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation01Time then
		local t = self.animationTimer / animation01Time
		local x = moveW[self.hitType] * t * self.x_dir
		local y = ( 1.0 - Mathf.Sin( 90 * t * Mathf.Deg2Rad ) ) * moveH[self.hitType] * -1
		local d = Mathf.SmoothStep( 1.0, scale[self.hitType], t )
		local num = math.ceil( Mathf.SmoothStep( 0, self.dmg, t ) )
		self.textObj.localPosition = Vector3(x, y, 0)
		self.textObj.localScale = Vector3.one * d * self.showScale
		self.textLable.text = self.titleText .. tostring(num)
	else
		self.textLable.text = self.titleText .. tostring(self.dmg)
		self.textObj.localPosition = Vector3( moveW[self.hitType] * self.x_dir, moveH[self.hitType] * -1, 0 )
		self.textObj.localScale = Vector3.one * scale[self.hitType] * self.showScale
		self.animationTimer = 0
		self.animationState = 2
	end
end

function DamageTextController:Anim02Strong( deltaTime )
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation02Time then
		local t = self.animationTimer / animation02Time
		local x = ( moveW[self.hitType] * ( 1 + t * 0.6 ) )* self.x_dir
		local y = moveH[self.hitType] * ( Mathf.Sin( 180 * t * Mathf.Deg2Rad ) * 0.5 - 1 )
		self.textObj.localPosition = Vector3(x, y, 0)
	else
		self.textObj.localPosition = Vector3( ( moveW[self.hitType] * 1.6 ) * self.x_dir, moveH[self.hitType] * -1, 0 )
		self.animationTimer = 0
		self.animationState = 3
	end
end

function DamageTextController:Anim03Strong( deltaTime )
	self.animationTimer = self.animationTimer + deltaTime
	if self.animationTimer < animation03Time then
		local t = self.animationTimer / animation03Time
		local x = ( moveW[self.hitType] * ( 1 + 0.6 + t * 0.3 ) )* self.x_dir
		local y = moveH[self.hitType] * ( Mathf.Sin( 180 * t * Mathf.Deg2Rad ) * 0.2 - 1 )
		self.textObj.localPosition = Vector3(x, y, 0)
	else
		self.textObj.localPosition = Vector3( ( moveW[self.hitType] * ( 1 + 0.6 + 0.3 ) ) * self.x_dir, moveH[self.hitType] * -1, 0 )
		self.animationTimer = 0
		self.isAnimation = false
		self:OnAnimEnd()
	end
end

function DamageTextController:OnAnimEnd()
	self.owner = nil
	ObjectPool.Recycle(self.gameObject)
end

return DamageTextController
