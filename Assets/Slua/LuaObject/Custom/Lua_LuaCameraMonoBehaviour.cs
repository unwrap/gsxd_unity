using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_LuaCameraMonoBehaviour : LuaObject {
	[UnityEngine.Scripting.Preserve]
	static public void reg(IntPtr l) {
		getTypeTable(l,"LuaCameraMonoBehaviour");
		createTypeMetatable(l,null, typeof(LuaCameraMonoBehaviour),typeof(LuaMonoBehaviourBase));
	}
}
