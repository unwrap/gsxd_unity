using System.Collections.Generic;

namespace SLua
{
    public class CjsonLib
    {
        public static void Reg(Dictionary<string, LuaCSFunction> reg_functions)
        {
            reg_functions.Add("cjson", LuaDLL.luaopen_cjson);
        }
    }
}