
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal void Lua_OzNetClient_OnGetServerMessageCallback(LuaFunction ld ,ETModel.Session a1,SLua.ByteStringArray a2,System.UInt16 a3) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			pushValue(l,a1);
			pushValue(l,a2);
			pushValue(l,a3);
			ld.pcall(3, error);
			LuaDLL.lua_settop(l, error-1);
		}
	}
}
