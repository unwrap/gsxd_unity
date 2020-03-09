using System.Collections.Generic;

namespace SLua
{
    public class PbLib
    {
        public static void Reg(Dictionary<string, LuaCSFunction> reg_functions)
        {
            reg_functions.Add("pb.io", LuaDLL.luaopen_pb_io);
            reg_functions.Add("pb.conv", LuaDLL.luaopen_pb_conv);
            reg_functions.Add("pb.buffer", LuaDLL.luaopen_pb_buffer);
            reg_functions.Add("pb.slice", LuaDLL.luaopen_pb_slice);
            reg_functions.Add("pb", LuaDLL.luaopen_pb);
        }
    }
}
