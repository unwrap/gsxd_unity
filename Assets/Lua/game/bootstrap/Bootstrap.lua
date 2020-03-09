
---------------------------------------------------------------------------------------------------
--
--filename: game.bootstrap.Bootstrap
--date:2019/12/3 11:28:13
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.bootstrap.Bootstrap'
local Bootstrap = lua_declare(strClassName, lua_class(strClassName))

function Bootstrap:Start()
	self.bottom = self.transform:Find("bottom")

	self.bootstrapCoroutine = OzCoroutine(self.gameObject)
	local co = self.bootstrapCoroutine:create(function()
		AssetBundleManager.LoadAtlas("shader.u3d")
		yield(WaitForEndOfFrame())

		--[[
		--连接的服务器应从配置文件读取，TODO~
		GameConfig.server = "47.107.176.241:10001"

		local loginObj = GameObject("login")
		local loginObjTransform = loginObj.transform
		loginObjTransform:SetParent(self.transform)
		loginObjTransform.localPosition = Vector3.zero
		loginObjTransform.localScale = Vector3.one
		local luaLogic = LuaGameUtil.DoFile(loginObj, "game.login.LoginController")
		--]]

		LuaGameUtil.LoadHomeScene()
	end)

	self.bootstrapCoroutine:resume(co)
end

function Bootstrap:OnDestroy()
	self.this:StopAllCoroutines()
	if self.bootstrapCoroutine ~= nil then
		self.bootstrapCoroutine:clear()
		self.bootstrapCoroutine:destroy()
		self.bootstrapCoroutine = nil
	end
end

return Bootstrap
