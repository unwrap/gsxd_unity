using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_EZCameraShake_CameraShakeState : LuaObject {
	static public void reg(IntPtr l) {
		getEnumTable(l,"EZCameraShake.CameraShakeState");
		addMember(l,0,"FadingIn");
		addMember(l,1,"FadingOut");
		addMember(l,2,"Sustained");
		addMember(l,3,"Inactive");
		LuaDLL.lua_pop(l, 1);
	}
}
