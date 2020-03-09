local _, _, majorv, minorv, rev = string.find(_VERSION, "(%d).(%d)[.]?([%d]?)")
local VersionNumber = tonumber(majorv) * 100 + tonumber(minorv) * 10 + (((string.len(rev) == 0) and 0) or tonumber(rev))

lua_declare("lua_version", VersionNumber)
lua_declare("lua_version_510", 510)
lua_declare("lua_version_520", 520)
lua_declare("lua_version_530", 530)
