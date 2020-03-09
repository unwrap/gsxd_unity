using UnityEngine;
using System.Collections;

using SLua;
using Lua = SLua.LuaSvr;
using System.IO;
using System.Collections.Generic;
using System;

#if UNITY_EDITOR
using UnityEditor;
#endif

[CustomLuaClass]
public class OzLuaManager : MonoBehaviour
{
#if UNITY_EDITOR
    const string KeyDebugString = "_Ozlua_Debug_string";
    [SLua.DoNotToLua]
    public static bool isDebug
    {
        get
        {
            bool _debug = EditorPrefs.GetBool(KeyDebugString, true);
            return _debug;
        }
        set
        {
            EditorPrefs.SetBool(KeyDebugString, value);
        }
    }
#endif

    private static Dictionary<string, byte[]> luacache;

    private Lua lua;
    private bool m_isReady = false;
    private Action<int> m_tick;

    public int liteUpdateFps = 10;
    private LuaFunction func_update;
    private LuaFunction func_lateUpdate;
    private LuaFunction func_fixedUpdate;
    private LuaFunction func_liteUpdate;
    private LuaFunction func_destroy;
    private bool m_bLiteUpdate = true;
    private WaitForSeconds m_liteUpdateTimer = null;

    private LuaFunction lua_is_declared;

    #region static

    public static OzLuaManager Instance
    {
        get
        {
            return OzSingleton.GetSingleTon<OzLuaManager>();
        }
    }

    public static byte[] Loader(string fn, ref string absoluteFn)
    {
        byte[] bytes = null;
#if UNITY_EDITOR
        if (isDebug)
        {
            fn = fn.Replace('.', '/');
            string path = Application.dataPath + "/Lua/" + fn + ".lua";
            if (!File.Exists(path))
            {
                int i = fn.LastIndexOf("/");
                fn = fn.Substring(i, fn.Length - i);
                path = Application.dataPath + "/Config/config/" + fn + ".lua";
            }

            try
            {
                bytes = File.ReadAllBytes(path);
            }
            catch (System.Exception ex)
            {
                Debug.LogError(ex.Message);
            }
        }
        else
        {
            fn = fn.Replace('.', '_').Replace('/', '_');
            if (luacache.ContainsKey(fn))
            {
                bytes = luacache[fn];
            }
        }
#else
        fn = fn.Replace('.', '_').Replace('/', '_');
        if (luacache.ContainsKey(fn))
        {
            bytes = luacache[fn];
        }
#endif
            return bytes;
    }

    #endregion

    #region public

    public bool isReady
    {
        get
        {
            return this.m_isReady;
        }
    }

    public LuaFunction GetLuaFunction(string fn)
    {
        return LuaSvr.mainState.getFunction(fn);
    }

    public void Init(Action<int> tick)
    {
        this.m_tick = tick;
        if (m_isReady)
        {
            //DoMain();
            luacache = new Dictionary<string, byte[]>();
            LoadBundle();
        }
        else
        {
            this.doInit();
        }
    }

    public object DoFile(string fn)
    {
        if (lua != null)
        {
            object obj = null;
            LuaTable classTable = null;
            bool is_declared = (bool)this.lua_is_declared.call(fn);
            if(is_declared)
            {
                classTable = (LuaTable)Lua.mainState.getTable(fn, true);
            }
            else
            {
                classTable = (LuaTable)Lua.mainState.doFile(fn);
            }
            if(classTable != null)
            {
                LuaFunction classNew = (LuaFunction)classTable["new"];
                if(classNew != null)
                {
                    obj = classNew.call();
                }
                else
                {
                    obj = classTable;
                }
            }
            return obj;
        }
        return null;
    }

    public object DoString(string str)
    {
        if(string.IsNullOrEmpty(str))
        {
            return null;
        }
        if(lua != null)
        {
            return LuaSvr.mainState.doString(str);
        }
        return null;
    }

    #endregion

    #region  mono

    private void doInit()
    {
        luacache = new Dictionary<string, byte[]>();
        lua = new Lua();
        Lua.mainState.loaderDelegate = Loader;

        lua.init(this.progress, () =>
        {
            LoadBundle();
            this.m_tick = null;
        }, LuaSvrFlag.LSF_BASIC | LuaSvrFlag.LSF_EXTLIB | LuaSvrFlag.LSF_3RDDLL);
    }

    private void progress(int tick)
    {
        if (this.m_tick != null)
        {
            this.m_tick(tick);
        }
    }

    private void Start()
    {
        this.m_liteUpdateTimer = new WaitForSeconds(1.0f / (float)this.liteUpdateFps);
        StartCoroutine(LiteUpdateControler());
    }

    private IEnumerator LiteUpdateControler()
    {
        while (true)
        {
            m_bLiteUpdate = true;
            yield return m_liteUpdateTimer;
        }
    }

    private void Update()
    {
        if (this.func_update != null)
        {
            this.func_update.call();
        }

        if (m_bLiteUpdate)
        {
            m_bLiteUpdate = false;
            if(this.func_liteUpdate != null)
            {
                this.func_liteUpdate.call();
            }
        }
    }

    private void LateUpdate()
    {
        if(this.func_lateUpdate != null)
        {
            this.func_lateUpdate.call();
        }
    }

    private void FixedUpdate()
    {
        if(this.func_fixedUpdate != null)
        {
            this.func_fixedUpdate.call();
        }
    }

    protected void OnDestroy()
    {
        m_isReady = false;
        if(this.func_destroy != null)
        {
            this.func_destroy.call();
        }
        this.func_update = null;
        this.func_lateUpdate = null;
        this.func_fixedUpdate = null;
        this.func_liteUpdate = null;
    }

    #endregion

    private void LoadBundle()
    {
#if UNITY_EDITOR
        if (!isDebug)
        {
            StopCoroutine(loadLuaBundle());
            StartCoroutine(loadLuaBundle());
        }
        else
        {
            DoMain();
        }
#else
		StopCoroutine(loadLuaBundle());
		StartCoroutine(loadLuaBundle());
#endif
    }

    private IEnumerator loadLuaBundle()
    {
        string keyName = "";
        string luaPath = PathUtil.GetAssetFullPath("lua.u3d");
        WWW luaLoader = new WWW(luaPath);
        yield return luaLoader;
        if (luaLoader.error == null)
        {
            byte[] byts = CryptographHelper.Decrypt(luaLoader.bytes, KeyVData.Instance.KEY, KeyVData.Instance.IV);
            AssetBundle item = AssetBundle.LoadFromMemory(byts);
            TextAsset[] all = item.LoadAllAssets<TextAsset>();
            foreach (TextAsset ass in all)
            {
                keyName = ass.name;
                luacache[keyName] = ass.bytes;
            }

            item.Unload(true);
            luaLoader.Dispose();
        }

        DoMain();
    }

    private void DoMain()
    {
        Lua.mainState.doFile("main");

        LuaFunction main = (LuaFunction)Lua.mainState["main"];
        this.func_update = (LuaFunction)Lua.mainState["Update"];
        this.func_lateUpdate = (LuaFunction)Lua.mainState["LateUpdate"];
        this.func_fixedUpdate = (LuaFunction)Lua.mainState["FixedUpdate"];
        this.func_liteUpdate = (LuaFunction)Lua.mainState["LiteUpdate"];
        this.func_destroy = (LuaFunction)Lua.mainState["Destroy"];
        this.lua_is_declared = (LuaFunction)Lua.mainState["lua_is_declared"];

        this.m_isReady = true;

        if (main != null)
        {
            main.call();
        }
    }
}
