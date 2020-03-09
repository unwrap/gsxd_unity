
---------------------------------------------------------------------------------------------------
--
--filename: game.camera.PerspectiveCameraFollow
--date:2019/9/20 16:36:25
--author:xxx
--desc:
--
---------------------------------------------------------------------------------------------------
require("game.base.OzMonoBehaviour")

local strClassName = 'game.camera.PerspectiveCameraFollow'
local PerspectiveCameraFollow = lua_declare(strClassName, lua_class(strClassName, game.base.OzMonoBehaviour))

function PerspectiveCameraFollow:Start()
	self.target = nil

	local cameraObj = self.transform:GetChild(0).gameObject
	self.camera = cameraObj:GetComponent(Camera)
	self.cameraTransform = cameraObj.transform
	self.camera.orthographic = false
    self.camera.fieldOfView = 60

	self.offsetVector3 = Vector3(0, 5.3, -7.3)
end

function PerspectiveCameraFollow:SetTarget(t)

end

function PerspectiveCameraFollow:SetCameraSize(w, h)
	--self.camera.orthographic = true
end

function PerspectiveCameraFollow:CheckTarget()
	if self.target then
		return
	end
	if GameBattleManager.Instance() == nil then
		return
	end
	if GameBattleManager.Instance().myself ~= nil then
		self.target = GameBattleManager.Instance().myself.effectPoint
		self.transform.parent = nil
		return
	end
	--[[
	local player = GameObject.FindGameObjectWithTag("MainPlayer")
	if player then
		self.target = player.transform
		self.transform.parent = nil
	end
	--]]
end

function PerspectiveCameraFollow:Update()
	if not self.target then
		self:CheckTarget()
		return
	end
	local pos = self.target.position
	local to = pos + self.offsetVector3
	--self.transform.position = to
	self.transform.position = to --Vector3.Lerp(self.transform.position, to, Time.deltaTime * 10)
	self.transform:LookAt(pos)

	local d = Vector3.Distance(pos, to)
	self:FindCorners(d)
end

function PerspectiveCameraFollow:FindCorners(distance)
	local halfFOV = self.camera.fieldOfView * 0.5 * Mathf.Deg2Rad
	local aspect = self.camera.aspect

	local height = distance * Mathf.Tan(halfFOV)
	local width = height * aspect

	local upperLeft = self.cameraTransform.position - self.cameraTransform.right * width
	upperLeft = upperLeft + self.cameraTransform.up * height
	upperLeft = upperLeft + self.cameraTransform.forward * distance

	local upperRight = self.cameraTransform.position + self.cameraTransform.right * width 
	upperRight = upperRight + self.cameraTransform.up * height
	upperRight = upperRight + self.cameraTransform.forward * distance

	local lowerLeft = self.cameraTransform.position - self.cameraTransform.right * width
	lowerLeft = lowerLeft - self.cameraTransform.up * height
	lowerLeft = lowerLeft + self.cameraTransform.forward * distance

	local lowerRight = self.cameraTransform.position + self.cameraTransform.right * width
	lowerRight = lowerRight - self.cameraTransform.up * height
	lowerRight = lowerRight + self.cameraTransform.forward * distance

	Debug.DrawLine(upperLeft, upperRight, Color.red)
	Debug.DrawLine(upperRight, lowerRight, Color.red)
	Debug.DrawLine(lowerRight, lowerLeft, Color.red)
	Debug.DrawLine(lowerLeft, upperLeft, Color.red)
end

return PerspectiveCameraFollow
