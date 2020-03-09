using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_UnityEngine_ParticlePhysicsExtensions : LuaObject {
	[SLua.MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	[UnityEngine.Scripting.Preserve]
	static public int GetSafeCollisionEventSize_s(IntPtr l) {
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
			UnityEngine.ParticleSystem a1;
			checkType(l,1,out a1);
			var ret=UnityEngine.ParticlePhysicsExtensions.GetSafeCollisionEventSize(a1);
			pushValue(l,true);
			pushValue(l,ret);
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
	static public int GetCollisionEvents_s(IntPtr l) {
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
			UnityEngine.ParticleSystem a1;
			checkType(l,1,out a1);
			UnityEngine.GameObject a2;
			checkType(l,2,out a2);
			System.Collections.Generic.List<UnityEngine.ParticleCollisionEvent> a3;
			checkType(l,3,out a3);
			var ret=UnityEngine.ParticlePhysicsExtensions.GetCollisionEvents(a1,a2,a3);
			pushValue(l,true);
			pushValue(l,ret);
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
	static public int GetSafeTriggerParticlesSize_s(IntPtr l) {
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
			UnityEngine.ParticleSystem a1;
			checkType(l,1,out a1);
			UnityEngine.ParticleSystemTriggerEventType a2;
			a2 = (UnityEngine.ParticleSystemTriggerEventType)LuaDLL.luaL_checkinteger(l, 2);
			var ret=UnityEngine.ParticlePhysicsExtensions.GetSafeTriggerParticlesSize(a1,a2);
			pushValue(l,true);
			pushValue(l,ret);
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
	static public int GetTriggerParticles_s(IntPtr l) {
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
			UnityEngine.ParticleSystem a1;
			checkType(l,1,out a1);
			UnityEngine.ParticleSystemTriggerEventType a2;
			a2 = (UnityEngine.ParticleSystemTriggerEventType)LuaDLL.luaL_checkinteger(l, 2);
			System.Collections.Generic.List<UnityEngine.ParticleSystem.Particle> a3;
			checkType(l,3,out a3);
			var ret=UnityEngine.ParticlePhysicsExtensions.GetTriggerParticles(a1,a2,a3);
			pushValue(l,true);
			pushValue(l,ret);
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
	static public int SetTriggerParticles_s(IntPtr l) {
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
			int argc = LuaDLL.lua_gettop(l);
			if(argc==3){
				UnityEngine.ParticleSystem a1;
				checkType(l,1,out a1);
				UnityEngine.ParticleSystemTriggerEventType a2;
				a2 = (UnityEngine.ParticleSystemTriggerEventType)LuaDLL.luaL_checkinteger(l, 2);
				System.Collections.Generic.List<UnityEngine.ParticleSystem.Particle> a3;
				checkType(l,3,out a3);
				UnityEngine.ParticlePhysicsExtensions.SetTriggerParticles(a1,a2,a3);
				pushValue(l,true);
				return 1;
			}
			else if(argc==5){
				UnityEngine.ParticleSystem a1;
				checkType(l,1,out a1);
				UnityEngine.ParticleSystemTriggerEventType a2;
				a2 = (UnityEngine.ParticleSystemTriggerEventType)LuaDLL.luaL_checkinteger(l, 2);
				System.Collections.Generic.List<UnityEngine.ParticleSystem.Particle> a3;
				checkType(l,3,out a3);
				System.Int32 a4;
				checkType(l,4,out a4);
				System.Int32 a5;
				checkType(l,5,out a5);
				UnityEngine.ParticlePhysicsExtensions.SetTriggerParticles(a1,a2,a3,a4,a5);
				pushValue(l,true);
				return 1;
			}
			pushValue(l,false);
			LuaDLL.lua_pushstring(l,"No matched override function SetTriggerParticles to call");
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
	[UnityEngine.Scripting.Preserve]
	static public void reg(IntPtr l) {
		getTypeTable(l,"UnityEngine.ParticlePhysicsExtensions");
		addMember(l,GetSafeCollisionEventSize_s);
		addMember(l,GetCollisionEvents_s);
		addMember(l,GetSafeTriggerParticlesSize_s);
		addMember(l,GetTriggerParticles_s);
		addMember(l,SetTriggerParticles_s);
		createTypeMetatable(l,null, typeof(UnityEngine.ParticlePhysicsExtensions));
	}
}
