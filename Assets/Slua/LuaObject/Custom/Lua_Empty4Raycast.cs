using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_Empty4Raycast : LuaObject {
	[UnityEngine.Scripting.Preserve]
	static public void reg(IntPtr l) {
		getTypeTable(l,"Empty4Raycast");
		createTypeMetatable(l,null, typeof(Empty4Raycast),typeof(UnityEngine.UI.MaskableGraphic));
	}
}
