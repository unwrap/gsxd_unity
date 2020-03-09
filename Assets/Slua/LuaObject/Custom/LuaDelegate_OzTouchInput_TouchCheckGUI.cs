
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal bool Lua_OzTouchInput_TouchCheckGUI(LuaFunction ld ,UnityEngine.Vector2 a1) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			pushValue(l,a1);
			ld.pcall(1, error);
			bool ret;
			checkType(l,error+1,out ret);
			LuaDLL.lua_settop(l, error-1);
			return ret;
		}
	}
}
