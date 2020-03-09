using UnityEngine;
using System.Collections;
#if UNITY_IPHONE
using UWAPlatform = UWA.IOS;
#elif UNITY_ANDROID
using UWAPlatform = UWA.Android;
#elif UNITY_STANDALONE_WIN
using UWAPlatform = UWA.Windows;
#else
using UWAPlatform = UWA;
#endif
using System.Diagnostics;

[ExecuteInEditMode]
public class UWA_Launcher : MonoBehaviour {

	void Awake () {
        UWAPlatform.GUIWrapper wrapper = gameObject.GetComponent<UWAPlatform.GUIWrapper>();
        if (wrapper == null) wrapper = gameObject.AddComponent<UWAPlatform.GUIWrapper>();

#if UNITY_EDITOR
        Component[] coms = gameObject.GetComponents<Component>();
        for (int i = 0; i < coms.Length; i++)
        {
            if (coms[i] != null &&
                coms[i] != this &&
                coms[i] != wrapper &&
                coms[i].GetType() != typeof(Transform))
                DestroyImmediate(coms[i]);
        }
#endif
    }
}

public class UWAEngine
{
    /// <summary>
    /// This api can be used to initialize the UWA SDK, instead of draging the UWA_Launcher.prefab into your scene.
    /// </summary>
    [Conditional("ENABLE_PROFILER")]
    public static void StaticInit()
    {
        UWAPlatform.UWAEngine.StaticInit();
    }

    /// <summary>
    /// The recorded frame count
    /// </summary>
    public static int FrameId { get { return UWAPlatform.UWAEngine.FrameId; } }

    /// <summary>
    /// The profiling mode 
    /// </summary>
    public enum Mode
    {
        Overview = 0,
        Mono = 1,
        Assets = 2,
        Lua = 3,
        Unset = 4,
    }

    /// <summary>
    /// This api can be used to start the test with the given mode, instead of pressing the button in GUI panel.
    /// Test can be started only once.
    /// </summary>
    /// <param name="mode"> the profiling mode to be started</param>
    [Conditional("ENABLE_PROFILER")]
    public static void Start(Mode mode)
    {
        UWAPlatform.UWAEngine.Start((UWAPlatform.UWAEngine.Mode)mode);
    }

    /// <summary>
    /// This api can be used to stop the test, instead of pressing the button in GUI panel.
    /// Test can be stopped only once.
    /// </summary>
    [Conditional("ENABLE_PROFILER")]
    public static void Stop()
    {
        UWAPlatform.UWAEngine.Stop();
    }

    /// <summary>
    /// Add a sample into the function lists in the UWAEngine, so the performance 
    /// between a Push and a Pop will be recorded with the given name.
    /// It is supported to call the PushSample and PopSample recursively, and they must be called in pairs.
    /// </summary>
    /// <param name="sampleName"></param>
    [Conditional("ENABLE_PROFILER")]
    public static void PushSample(string sampleName)
    {
        UWAPlatform.UWAEngine.PushSample(sampleName);
    }
    /// <summary>
    /// Add a sample into the function lists in the UWAEngine, so the performance
    /// between a Push and a Pop will be recorded with the given name.
    /// It is supported to call the PushSample and PopSample recursively, and they must be called in pairs.
    /// </summary>
    [Conditional("ENABLE_PROFILER")]
    public static void PopSample()
    {
        UWAPlatform.UWAEngine.PopSample();
    }
    [Conditional("ENABLE_PROFILER")]
    public static void LogValue(string valueName, float value)
    {
        UWAPlatform.UWAEngine.LogValue(valueName, value);
    }
    [Conditional("ENABLE_PROFILER")]
    public static void LogValue(string valueName, int value)
    {
        UWAPlatform.UWAEngine.LogValue(valueName, value);
    }
    [Conditional("ENABLE_PROFILER")]
    public static void LogValue(string valueName, Vector3 value)
    {
        UWAPlatform.UWAEngine.LogValue(valueName, value);
    }
    [Conditional("ENABLE_PROFILER")]
    public static void LogValue(string valueName, bool value)
    {
        UWAPlatform.UWAEngine.LogValue(valueName, value);
    }
    [Conditional("ENABLE_PROFILER")]
    public static void AddMarker(string valueName)
    {
        UWAPlatform.UWAEngine.AddMarker(valueName);
    }

    /// <summary>
    /// Change the lua lib to a custom name, e.g. 'libgamex.so'.
    /// There is no need to call it when you use the default ulua/tolua/slua/xlua lib.
    /// </summary>
    [Conditional("ENABLE_PROFILER")]
    public static void SetOverrideLuaLib(string luaLib)
    {
#if !UNITY_IPHONE
        UWAPlatform.UWAEngine.SetOverrideLuaLib(luaLib);
#endif
    }
}