
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal UnityEngine.Vector3 Lua_LTDescr_EaseTypeDelegate(LuaFunction ld ) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			ld.pcall(0, error);
			UnityEngine.Vector3 ret;
			checkType(l,error+1,out ret);
			LuaDLL.lua_settop(l, error-1);
			return ret;
		}
	}
}
