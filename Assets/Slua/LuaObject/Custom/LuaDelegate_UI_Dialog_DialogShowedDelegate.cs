
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal void Lua_UI_Dialog_DialogShowedDelegate(LuaFunction ld ,UIDialogView a1) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			pushValue(l,a1);
			ld.pcall(1, error);
			LuaDLL.lua_settop(l, error-1);
		}
	}
}
