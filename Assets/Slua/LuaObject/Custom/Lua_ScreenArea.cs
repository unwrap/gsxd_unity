using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_ScreenArea : LuaObject {
	static public void reg(IntPtr l) {
		getEnumTable(l,"ScreenArea");
		addMember(l,0,"FullScreen");
		addMember(l,1,"Left");
		addMember(l,2,"Right");
		addMember(l,3,"Top");
		addMember(l,4,"Bottom");
		addMember(l,5,"TopLeft");
		addMember(l,6,"TopRight");
		addMember(l,7,"BottomLeft");
		addMember(l,8,"BottomRight");
		LuaDLL.lua_pop(l, 1);
	}
}
