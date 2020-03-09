
---------------------------------------------------------------------------------------------------
--
--filename: game.camera.CameraFollow
--date:2019/9/20 16:36:25
--author:xxx
--desc:
--
---------------------------------------------------------------------------------------------------
require("game.base.OzMonoBehaviour")

local strClassName = 'game.camera.CameraFollow'
local CameraFollow = lua_declare(strClassName, lua_class(strClassName, game.base.OzMonoBehaviour))

function CameraFollow:Start()
	self.target = nil

	local cameraObj = self.transform:GetChild(0).gameObject
	self.camera = cameraObj:GetComponent(Camera)
	self.camera.nearClipPlane  = -100
	self.maxZ = self.camera.orthographicSize
	self.minZ = -self.maxZ
	self.maxX = self.maxZ * self.camera.aspect
	self.minX = -self.maxX

	self.cameraFollowTimer = 0

	self.transform.rotation = Quaternion.Euler(CommonUtil.cameraRotate, 0, 0)
end

function CameraFollow:SetTarget()

end

function CameraFollow:CheckTarget()
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

function CameraFollow:SetCameraSize(width, length)
	width = width + 0.4
	length = length + 3

	self.camera.orthographic = true
	self.camera.orthographicSize =(width * Screen.height) / Screen.width

	self.maxZ = math.max(length - self.camera.orthographicSize, 0)
	self.minZ = -self.maxZ
	self.maxX = math.max(width - self.camera.orthographicSize * self.camera.aspect, 0)
	self.minX = -self.maxX
end

function CameraFollow:LateUpdate()
	if not self.target then
		self:CheckTarget()
		return
	end
	if Slua.IsNull(self.target) then
		return
	end
	local pos = self.target.position
	local to = self:RestrictPosition(pos)
	self.transform.position = Vector3.Lerp(self.transform.position, to, Time.deltaTime * 10)
end

function CameraFollow:RestrictPosition(pos)
	pos.x = Mathf.Clamp(pos.x, self.minX, self.maxX)
	pos.z = Mathf.Clamp(pos.z, self.minZ, self.maxZ)
	return pos
end

return CameraFollow
