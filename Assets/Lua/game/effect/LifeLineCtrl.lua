
---------------------------------------------------------------------------------------------------
--
--filename: game.effect.LifeLineCtrl
--date:2019/10/16 9:43:56
--author:heguang
--desc:光束效果
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.effect.LifeLineCtrl'
local LifeLineCtrl = lua_declare(strClassName, lua_class(strClassName))

function LifeLineCtrl:Start()
	self.mStartObj = self.transform:Find("LineStart")
	self.mEndObj = self.transform:Find("LineEnd")
	local line = self.transform:Find("Line")
	self.lineRender = GameUtil.GetComponent(line.gameObject, LineRenderer)
	self.lineMaterial = self.lineRender.material
end

function LifeLineCtrl:UpdateEntity(srcEntity, targetEntity)
	self.mSrcEntity = srcEntity
	self.mTargetEntity = targetEntity
	self.isStart = true
end

function LifeLineCtrl:Update()
	if not self.isStart then
		return
	end

	if (self.mSrcEntity ~= nil) and ( not self.mSrcEntity:IsDead() )
		and (self.mTargetEntity ~= nil) and (not self.mTargetEntity:IsDead()) then

		local srcPosition = self.mSrcEntity:GetEffectPoint()
		local targetPosition = self.mTargetEntity:GetEffectPoint()
		self.transform:LookAt(targetPosition)
		self.mStartObj.position = srcPosition
		self.mEndObj.position = targetPosition

		self.lineRender.positionCount = 2
		self.lineRender:SetPosition(0, srcPosition)
		self.lineRender:SetPosition(1, targetPosition)
		self.lineLength = Vector3.Distance(srcPosition, targetPosition)
		self.lineMaterial.mainTextureScale = Vector2(self.lineLength/3, 1)

		local offset = self.lineMaterial.mainTextureOffset
        self.lineMaterial.mainTextureOffset = offset - Vector2(Time.deltaTime * 8, 0)

	else
		self.isStart = false
		self:Finish()
	end
end

function LifeLineCtrl:Finish()
	if self.finishCallback ~= nil then
		self.finishCallback()
	end
	self.finishCallback = nil
	ObjectPool.Recycle(self.gameObject)
end

return LifeLineCtrl
