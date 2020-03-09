
---------------------------------------------------------------------------------------------------
--
--filename: core.OzCoroutine
--date:2019/10/10 17:09:31
--author:heguang
--desc:Coroutine实现
--
--[[
    eg: 

	--local coroutine = OzCoroutine() --create an instance
	--create an instance bind to target gameObject
	local coroutine = OzCoroutine(self.gameObject)

	local co = coroutine:create(function()
		--yield(WaitForSeconds(1))
		yield(WaitForEndOfFrame())
		coroutine:clear()  --supprot clear
		coroutine:destroy()  --only destroy LuaCoroutine MonoBehaviour
		--	coroutine:destroy(true) --destroy gameObject
	end)
	coroutine:resume(co)

--]]
---------------------------------------------------------------------------------------------------
local strClassName = 'OzCoroutine'
local OzCoroutine = lua_declare(strClassName, lua_class(strClassName))
local GameObject = UnityEngine.GameObject

function OzCoroutine:ctor(go, name)
	local objName = name or 'OzCoroutine'
	local gameObject = go or GameObject(objName)
	self.mono = gameObject:AddComponent(OzLuaCoroutine)
	self.gameObject = gameObject
end

function OzCoroutine:create(func)
	local co 
	local baseEnv = getfenv(func)
	local funcEnv = {
		__index = baseEnv,
		yield = function( instruction )
			self:yield(co,instruction)
		end,
	}
	setmetatable(funcEnv,funcEnv)
	setfenv(func,funcEnv)
	co = coroutine.create(func)
	
	return co
end

local function resumeCo(co)
	coroutine.resume(co)
end

function OzCoroutine:yield(co,instruction)
	self.mono:ExecuteWhen(instruction,resumeCo,co)
	coroutine.yield()
end

function OzCoroutine:resume(co,...)
	coroutine.resume(co,...)
end

function OzCoroutine:clear( )
	self.mono:StopAllCoroutines()
end

function OzCoroutine:destroy(isGameObject)
	if isGameObject then
		OzLuaCoroutine.Destroy(self.gameObject)
	else
		OzLuaCoroutine.Destroy(self.mono)
	end
end
