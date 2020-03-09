using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_LuaMonoBehaviour : LuaObject {
	[UnityEngine.Scripting.Preserve]
	static public void reg(IntPtr l) {
		getTypeTable(l,"LuaMonoBehaviour");
		createTypeMetatable(l,null, typeof(LuaMonoBehaviour),typeof(LuaMonoBehaviourBase));
	}
}
