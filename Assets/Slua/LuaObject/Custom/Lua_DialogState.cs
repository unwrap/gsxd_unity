using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_DialogState : LuaObject {
	static public void reg(IntPtr l) {
		getEnumTable(l,"DialogState");
		addMember(l,0,"OK");
		addMember(l,1,"CANCEL");
		addMember(l,2,"CLOSE");
		LuaDLL.lua_pop(l, 1);
	}
}
