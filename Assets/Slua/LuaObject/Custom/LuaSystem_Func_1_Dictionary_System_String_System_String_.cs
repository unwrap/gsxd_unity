
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal Dictionary<System.String,System.String> Lua_System_Func_1_Dictionary_System_String_System_String_(LuaFunction ld ) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			ld.pcall(0, error);
			Dictionary<System.String,System.String> ret;
			checkType(l,error+1,out ret);
			LuaDLL.lua_settop(l, error-1);
			return ret;
		}
	}
}
