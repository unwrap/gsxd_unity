
---------------------------------------------------------------------------------------------------
--
--filename: core.lua_class
--date:2019/9/19 15:46:16
--author:heguang
--desc:lua_class
--
---------------------------------------------------------------------------------------------------

local __lua_class_type_list = {}
local class_type_split_chr = '.'

local function __lua_class(type_name, super_type)
	local class_type = {}
	
	local subt = string.split(type_name, class_type_split_chr)
	if #subt > 1 then
		local glo = subt[1]
		type_name = subt[#subt]
		if not lua_is_declared(glo) then
			lua_declare(glo, {})
		end
		local parent_obj = _G[glo]
		for i=2,#subt-1 do
			local tn = subt[i]
			local tempObj = parent_obj[tn] or {}
			parent_obj[tn] = tempObj
			parent_obj = tempObj
		end
		parent_obj[type_name] = class_type
	end
	
	class_type.type_name = type_name
	class_type.super_type = super_type
	class_type.ctor = false
	class_type.dtor = false

	class_type.new = function (...)
		local obj = {}
		obj.tostring = function(self)
			if not self.__instance_name then
				local str = tostring(self)
				local _,_,addr = string.find(str, "table%s*:%s*(0?[xX]?%x+)")
				self.__instance_name = class_type.type_name .. ":" .. addr
			end
			return self.__instance_name
		end

		obj.gettype = function(self)
			return class_type.type_name
		end

		local create_obj = function (class, object, ...)
			local create
			create = function(c, ...)
				if c.super_type and not c.ctor then
					create(c.super_type, ...)
				end
				if c.ctor then
					c.ctor(object, ...)
				end
			end
			create(class, ...)
		end

		local release_obj = function (class, object)
			local release
			release = function (c)
				if c.dtor then
					c.dtor(object)
				end
				if c.super_type then
					release(c.super_type)
				end
			end
			release(class)
		end

		if lua_version < lua_version_520 then
			local proxy = newproxy(true)
			getmetatable(proxy).__gc = function (o)
				release_obj(class_type, obj)
			end
			obj.__gc = proxy
			setmetatable(obj, {__index = __lua_class_type_list[class_type]})
		else
			setmetatable(obj,
			{
				__index = __lua_class_type_list[class_type],
				__gc = function (o)
					release_obj(class_type, o)
				end
			})
		end

		create_obj(class_type, obj, ...)
		return obj
	end

	class_type.tostring = function(self)
		return self.type_name
	end

	if super_type then
		class_type.super = setmetatable({},
		{
			__index = function(t, k)
				local func = __lua_class_type_list[super_type][k]
				if "function" == type(func) then
					t[k] = func
					return func
				else
					error("Accessing super class field are not allowed!")
				end
			end
		})
	end

	local vtbl = {}
	__lua_class_type_list[class_type] = vtbl
	setmetatable(class_type, 
	{
		__index = function(t, k)
			return vtbl[k]
		end,

		__newindex = function(t, k, v)
			vtbl[k] = v
		end,

		__call = function (self, ...)
			return class_type.new(...)
		end
	})

	if super_type then
		setmetatable(vtbl,
		{
			__index = function(t, k)
				local ret = __lua_class_type_list[super_type][k]
				vtbl[k] = ret
				return ret
			end
		})
	end

	return class_type

end

if (not lua_is_declared("lua_class")) or (not lua_class) then
	lua_declare("lua_class", __lua_class)
end

return __lua_class_type_list
