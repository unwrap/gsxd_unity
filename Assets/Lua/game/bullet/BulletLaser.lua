
---------------------------------------------------------------------------------------------------
--
--filename: game.bullet.BulletLaser
--date:2019/10/9 0:13:54
--author:heguang
--desc:激光
--
---------------------------------------------------------------------------------------------------
local BulletBase = require("game.bullet.BulletBase")

local strClassName = 'game.bullet.BulletLaser'
local BulletLaser = lua_declare(strClassName, lua_class(strClassName, BulletBase))

function BulletLaser:Start()
	BulletLaser.super.Start(self)
	self.lineRender = GameUtil.GetComponent(self.childMesh.gameObject, LineRenderer)
	self.lineMaterial = self.lineRender.material
end

function BulletLaser:OnFire(entity)
	self.targetPosition = entity:GetEffectPoint()

	if self.lineRender then
		self.lineRender.positionCount = 2
		self.lineRender:SetPosition(0, self.startPosition)
		self.lineRender:SetPosition(1, self.targetPosition)
		self.lineLength = Vector3.Distance(self.startPosition, self.targetPosition)

		self.lineMaterial.mainTextureScale = Vector2(self.lineLength/3, 1)
	end
end

function BulletLaser:OnUpdate(deltaTime)
	if self.isMove then
		self.moveTimer = self.moveTimer + deltaTime
		if self.moveTimer >= self.moveTime then
			self.isMove = false
			self:OnMoveEnd()
		end
	end

	if self.lineRender then
		local offset = self.lineMaterial.mainTextureOffset
        self.lineMaterial.mainTextureOffset = offset - Vector2(deltaTime * 8, 0)
	end
end

return BulletLaser
