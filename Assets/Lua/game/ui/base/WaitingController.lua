
---------------------------------------------------------------------------------------------------
--
--filename: game.ui.base.WaitingController
--date:2019/12/25 10:27:03
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.ui.base.WaitingController'
local WaitingController = lua_declare(strClassName, lua_class(strClassName))

function WaitingController:Start()
	self.rotationsPerSecond = Vector3(0,0,6)
	self.waiting = self.transform:FindChild("waiting/overlay")

	self.animationDelay = 0.1
	self.nextFrameTime = Time.realtimeSinceStartup + self.animationDelay
	self.rotationAngles = Vector3(0, 0, 360)

	self.showTimer = 0
end

function WaitingController:OnEnable()
	self.showTimer = 0

	self.nextFrameTime = Time.realtimeSinceStartup + self.animationDelay
	self.rotationAngles.z = 360
	self.waiting.localEulerAngles = self.rotationAngles
end

function WaitingController:Update()
	local deltaTime = Time.deltaTime

	--[[
	local offset = Quaternion.Euler( self.rotationsPerSecond * deltaTime * 100 )
	self.waiting.rotation = self.waiting.rotation * offset
	--]]
	local time = Time.realtimeSinceStartup
	while time >= self.nextFrameTime do
		self.nextFrameTime = self.nextFrameTime + self.animationDelay
		local z = self.rotationAngles.z
		z = z - 30
		if z <= 0 then
			z = 360
		end
		self.rotationAngles.z = z
		self.waiting.localEulerAngles = self.rotationAngles
	end

	self.showTimer = self.showTimer + deltaTime
	if self.showTimer > 20 then
		Dialog.CloseWaiting()
	end
end

return WaitingController
