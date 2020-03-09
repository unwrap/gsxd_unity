using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_OzLuaCoroutine : LuaObject {
	[SLua.MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	[UnityEngine.Scripting.Preserve]
	static public int ExecuteWhen(IntPtr l) {
		try {
			#if DEBUG
			var method = System.Reflection.MethodBase.GetCurrentMethod();
			string methodName = GetMethodName(method);
			#if UNITY_5_5_OR_NEWER
			UnityEngine.Profiling.Profiler.BeginSample(methodName);
			#else
			Profiler.BeginSample(methodName);
			#endif
			#endif
			OzLuaCoroutine self=(OzLuaCoroutine)checkSelf(l);
			System.Object a1;
			checkType(l,2,out a1);
			SLua.LuaFunction a2;
			checkType(l,3,out a2);
			System.Object a3;
			checkType(l,4,out a3);
			self.ExecuteWhen(a1,a2,a3);
			pushValue(l,true);
			return 1;
		}
		catch(Exception e) {
			return error(l,e);
		}
		#if DEBUG
		finally {
			#if UNITY_5_5_OR_NEWER
			UnityEngine.Profiling.Profiler.EndSample();
			#else
			Profiler.EndSample();
			#endif
		}
		#endif
	}
	[UnityEngine.Scripting.Preserve]
	static public void reg(IntPtr l) {
		getTypeTable(l,"OzLuaCoroutine");
		addMember(l,ExecuteWhen);
		createTypeMetatable(l,null, typeof(OzLuaCoroutine),typeof(UnityEngine.MonoBehaviour));
	}
}
