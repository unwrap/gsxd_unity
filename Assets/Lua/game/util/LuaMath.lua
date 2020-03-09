
---------------------------------------------------------------------------------------------------
--
--filename: game.util.LuaMath
--date:2019/9/26 11:23:41
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'game.util.LuaMath'
local LuaMath = lua_declare("LuaMath", lua_class(strClassName))
local math_randomseed = math.randomseed
local math_random = math.random

function LuaMath.Sin(angle)
	return Mathf.Sin(angle * Mathf.PI / 180)
end

function LuaMath.Cos(angle)
	return Mathf.Cos(angle * Mathf.PI / 180)
end

function LuaMath.GetAngle(x, y)
	local angle = 90 - (Mathf.Atan2(y,x) * Mathf.Rad2Deg)
	angle = (angle + 360) % 360
	return angle
end

function LuaMath.Random(min, max)
	math_randomseed(tostring(os.time()):reverse():sub(1, 7))
	return math_random(min, max)
end

function LuaMath.GetIntPart(x)
	if x <= 0 then
	   return math.ceil(x)
	end

	if math.ceil(x) == x then
	   x = math.ceil(x)
	else
	   x = math.ceil(x) - 1
	end
	return x
end

return LuaMath
