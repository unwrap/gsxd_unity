local lua_global = package.loaded["core.lua_global"]
if lua_global ~= nil then
	lua_global.clear()
end

package.loaded["pb"] = nil
package.loaded["core.serpent"] = nil
package.loaded["core.protoc"] = nil
package.loaded["lutil"] = nil

lutil = require("lutil")
pb = require("pb")
serpent = require("core.serpent")
protoc = require("core.protoc")

local requireLua = {
	"config.cfg_localization",
	"config.cfg_gm",
	"config.cfg_map",
	"config.cfg_map_monster_waves",
	"config.cfg_room",
	"config.cfg_char",
	"config.cfg_weapon",
	"config.cfg_skill",
	"config.cfg_buff",
	
	'game.ProtoDesc',
	"game.ProtoDef",

	"core.lua_global",
	"core.lua_base",
	"core.lua_version",
	"core.lua_class",

	"core.OzMessage",
	"core.OzUpdater",
	"core.OzCoroutine",
	
	"game.util.CommonEvent",
	"game.util.LuaMath",
	"game.util.LuaGameUtil",
	"game.util.CommonUtil",
	"game.util.ResManager",
	"game.dialog.Dialog",
	"game.ui.base.AtlasFactory",

	"game.net.GameNetMgr",
	"game.mgr.LuaUIManager",
	"game.mgr.LayerManager",
	"game.mgr.data.GlobalData",
	"game.mgr.GameBattleManager",
}

for _,modulename in ipairs(requireLua) do
	package.loaded[modulename] = nil
	require(modulename)
end

