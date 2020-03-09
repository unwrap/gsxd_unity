using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_TileType : LuaObject {
	static public void reg(IntPtr l) {
		getEnumTable(l,"TileType");
		addMember(l,0,"None");
		addMember(l,1,"Block");
		addMember(l,2,"Sea");
		addMember(l,3,"Forbidden");
		LuaDLL.lua_pop(l, 1);
	}
}
