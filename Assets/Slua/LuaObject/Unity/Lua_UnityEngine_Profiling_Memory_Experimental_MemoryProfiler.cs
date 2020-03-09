using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_UnityEngine_Profiling_Memory_Experimental_MemoryProfiler : LuaObject {
	[SLua.MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	[UnityEngine.Scripting.Preserve]
	static public int constructor(IntPtr l) {
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
			UnityEngine.Profiling.Memory.Experimental.MemoryProfiler o;
			o=new UnityEngine.Profiling.Memory.Experimental.MemoryProfiler();
			pushValue(l,true);
			pushValue(l,o);
			return 2;
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
	[SLua.MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	[UnityEngine.Scripting.Preserve]
	static public int TakeSnapshot_s(IntPtr l) {
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
			System.String a1;
			checkType(l,1,out a1);
			System.Action<System.String,System.Boolean> a2;
			checkDelegate(l,2,out a2);
			UnityEngine.Profiling.Memory.Experimental.CaptureFlags a3;
			a3 = (UnityEngine.Profiling.Memory.Experimental.CaptureFlags)LuaDLL.luaL_checkinteger(l, 3);
			UnityEngine.Profiling.Memory.Experimental.MemoryProfiler.TakeSnapshot(a1,a2,a3);
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
	[SLua.MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	[UnityEngine.Scripting.Preserve]
	static public int TakeTempSnapshot_s(IntPtr l) {
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
			System.Action<System.String,System.Boolean> a1;
			checkDelegate(l,1,out a1);
			UnityEngine.Profiling.Memory.Experimental.CaptureFlags a2;
			a2 = (UnityEngine.Profiling.Memory.Experimental.CaptureFlags)LuaDLL.luaL_checkinteger(l, 2);
			UnityEngine.Profiling.Memory.Experimental.MemoryProfiler.TakeTempSnapshot(a1,a2);
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
		getTypeTable(l,"UnityEngine.Profiling.Memory.Experimental.MemoryProfiler");
		addMember(l,TakeSnapshot_s);
		addMember(l,TakeTempSnapshot_s);
		createTypeMetatable(l,constructor, typeof(UnityEngine.Profiling.Memory.Experimental.MemoryProfiler));
	}
}
