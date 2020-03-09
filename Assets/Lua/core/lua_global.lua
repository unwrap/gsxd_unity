
---------------------------------------------------------------------------------------------------
--
--filename: core.lua_global
--date:2019/9/19 15:11:14
--author:heguang
--desc:禁止直接定义全局变量，必须使用 lua_declare 来显示定义全局变量
--
---------------------------------------------------------------------------------------------------

local lua_declared_names = {}

function lua_declared_names.clear()
	for k,v in pairs(lua_declared_names) do
		rawset(_G, k, nil)
	end
	lua_declared_names = {}
end

local function __inner_declare_index(t, k)
	if not lua_declared_names[k] then
		error("Attempt to access an undeclared global variable : " .. k, 2)
	end
	return nil
end

local function __inner_declare_newindex(t, k, v)
	if not lua_declared_names[k] then
		error("Attempt to write an undeclared global variable : " .. k, 2)
	else
		rawset(t, k, v)
	end
end

local function __inner_declare(name, init_value)
	if not rawget(_G, name) then
		rawset(_G, name, init_value or false)
	else
		error("You have already declared global : " .. name, 2)
	end
	lua_declared_names[name] = true
	return _G[name]
end

local function __declare(name, init_value)
	local ok, res = pcall(__inner_declare, name, init_value)
	if not ok then
		print(debug.traceback(res, 2))
		return nil
	else
		return res
	end
end

local function __is_declare(name)
	if lua_declared_names[name] or rawget(_G, name) then
		return true
	else
		return false
	end
end

if (not __is_declare("lua_declare")) or (not lua_declare) then
	__declare("lua_declare", __declare)
end

if (not __is_declare("lua_is_declared")) or (not lua_is_declared) then
	__declare("lua_is_declared", __is_declare)
end

setmetatable(_G, 
{
	__index = function(t, k)
		local ok, res = pcall(__inner_declare_index, t, k)
		if not ok then
			print(debug.traceback(res, 2))
		end
		return nil
	end,

	__newindex = function(t, k, v)
		local ok, res = pcall(__inner_declare_newindex, t, k, v)
        if not ok then
            print(debug.traceback(res, 2))
        end
	end
})

return lua_declared_names