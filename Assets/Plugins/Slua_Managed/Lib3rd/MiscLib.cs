using System.Collections.Generic;

namespace SLua
{
    public class MiscLib
    {
        public static void Reg(Dictionary<string, LuaCSFunction> reg_functions)
        {
            reg_functions.Add("bit", LuaDLL.luaopen_libbit);
            reg_functions.Add("snapshot", LuaDLL.luaopen_snapshot);
            reg_functions.Add("lkcp", LuaDLL.luaopen_lkcp);
            reg_functions.Add("lutil", LuaDLL.luaopen_lutil);
        }
    }
}