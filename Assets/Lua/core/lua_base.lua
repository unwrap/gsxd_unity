
---------------------------------------------------------------------------------------------------
--
--filename: core.lua_base
--date:2019/9/21 14:18:49
--author:heguang
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = 'lua_base'
local lua_base = lua_declare(strClassName, {})

local string = string
local math = math

function string.ToTable ( str )
	local tbl = {}

	for i = 1, string.len( str ) do
		tbl[i] = string.sub( str, i, i )
	end

	return tbl
end

local totable = string.ToTable
local string_sub = string.sub
local string_find = string.find
local string_len = string.len

function table.print( t )
    local print_r_cache={}
	local str = ""
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            str = str .. (indent.."*"..tostring(t)) .. "\n"
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        str = str .. (indent.."["..pos.."] => "..tostring(t).." {") .. "\n"
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        str = str .. (indent..string.rep(" ",string.len(pos)+6).."}") .. "\n"
                    elseif (type(val)=="string") then
                        str = str .. (indent.."["..pos..'] => "'..val..'"') .. "\n"
                    else
                        str = str .. (indent.."["..pos.."] => "..tostring(val)) .. "\n"
                    end
                end
            else
                str = str .. (indent..tostring(t)) .. "\n"
            end
        end
    end
    if (type(t)=="table") then
        str = str .. (tostring(t).." {") .. "\n"
        sub_print_r(t,"  ")
        str = str .. ("}") .. "\n"
    else
        sub_print_r(t,"  ")
    end
	print(str)
end

function string.trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function string.split(str, chr)
	if str==nil or str=='' or chr==nil then
		return nil
	end
	local r, i, s, e = {}, 0, str:find(chr, nil, true)
    while s do
        r[#r + 1] = str:sub(i, s - 1)
        i = e + 1
        s, e  = str:find(chr, i, true)
    end
    r[#r + 1] = str:sub(i)
    return r
end

function string.Explode(separator, str, withpattern)
	if ( separator == "" ) then return totable( str ) end
	if ( withpattern == nil ) then withpattern = false end

	local ret = {}
	local current_pos = 1

	for i = 1, string_len( str ) do
		local start_pos, end_pos = string_find( str, separator, current_pos, not withpattern )
		if ( not start_pos ) then break end
		ret[ i ] = string_sub( str, current_pos, start_pos - 1 )
		current_pos = end_pos + 1
	end

	ret[ #ret + 1 ] = string_sub( str, current_pos )

	return ret
end

function string.Replace( str, tofind, toreplace )
	local tbl = string.Explode( tofind, str )
	if ( tbl[ 1 ] ) then return table.concat( tbl, toreplace ) end
	return str
end

--[[---------------------------------------------------------
	Name: Trim( s )
	Desc: Removes leading and trailing spaces from a string.
			Optionally pass char to trim that character from the ends instead of space
-----------------------------------------------------------]]
function string.Trim( s, char )
	if ( char ) then char = char:PatternSafe() else char = "%s" end
	return string.match( s, "^" .. char .. "*(.-)" .. char .. "*$" ) or s
end

function string.StartWith( String, Start )
   return string.sub( String, 1, string.len (Start ) ) == Start
end

function string.EndsWith( String, End )
   return End == "" or string.sub( String, -string.len( End ) ) == End
end

return lua_base
