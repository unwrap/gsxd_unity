
---------------------------------------------------------------------------------------------------
--
--filename: game.entities.ctrl.MoveControlHero
--date:2019/10/6 0:19:12
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local MoveControl = require("game.entities.ctrl.MoveControl")

local strClassName = 'game.entities.ctrl.MoveControlHero'
local MoveControlHero = lua_declare(strClassName, lua_class(strClassName, MoveControl))

function MoveControlHero:ctor(owner)
	MoveControl.ctor(self, owner)

	self.dustDistance = 0

	local function onMoveStart()
		self.moveDirection.x = OzJoystick.joystickAxis.x
		self.moveDirection.z = OzJoystick.joystickAxis.y * CommonUtil.mapScaleZ
		self.isMoving = true
	end

	local function onMoving()
		self.moveDirection.x = OzJoystick.joystickAxis.x
		self.moveDirection.z = OzJoystick.joystickAxis.y * CommonUtil.mapScaleZ
		self.isMoving = true
	end

	local function onMoveEnd()
		self.moveDirection.x = 0
		self.moveDirection.z = 0
		self.owner:SetSpeed(0)
		self.isMoving = false
	end
	OzJoystick.On_JoystickMoveStart = onMoveStart
	OzJoystick.On_JoystickMove = onMoving
	OzJoystick.On_JoystickMoveEnd = onMoveEnd
end

function MoveControlHero:DoMoving(deltaTime)
	if self.moveDirection ~= self.vector3zero and not self.owner:IsDead() then
		self.isMoving = true
		self.owner:SetSpeed(self.moveSpeedRatio)
		self.transform.rotation = Quaternion.LookRotation(self.moveDirection)
		local dis = self.moveDirection * self.moveSpeed *  self.moveSpeedRatio * deltaTime
		dis = self:RestrictPosition(dis, self.moveDirection)
		self.transform.position = self.transform.position + dis
		self:PlayDustEffect(dis.magnitude)
	else
		self.isMoving = false
	end
end

function MoveControlHero:Update(deltaTime)
	if LuaGameUtil.IsPaused() then
		return
	end
	self.moveSpeedRatio = 1 --OzJoystick.joystickAxis.magnitude
	MoveControlHero.super.Update(self, deltaTime)
end

function MoveControlHero:PlayDustEffect(dis)
	self.dustDistance = self.dustDistance + dis
	if self.dustDistance >= 1 then
		self.dustDistance = self.dustDistance - 1
		self:PlayEffect("FootDust", self.owner:GetPosition())
	end
end

function MoveControlHero:PlayEffect(effectName, position, rotation)
	local effectObj = ObjectPool.Spawn(LuaGameUtil.GetEffectAbName(effectName))
	if effectObj ~= nil then
		local effectTransform = effectObj.transform
		effectTransform.position = position
		if rotation then
			effectTransform.rotation = rotation
		end
		local effect = effectObj:GetComponent(EffectController)
		if effect ~= nil then
			effect:Play()
		end
		return effect
	end
end

return MoveControlHero
