using UnityEngine;
using System.Collections;
using SLua;
using System.Threading;

[SLua.CustomLuaClass]
public class OzSingleton : MonoBehaviour
{
    private static bool hasDestroy = false;

    private static GameObject mSingletonObj;

    public static bool IsDestroy
    {
        get
        {
            return hasDestroy;
        }
        set
        {
            hasDestroy = false;
        }
    }
    public static GameObject SingletonGameObject
    {
        get
        {
            if (mSingletonObj == null && !hasDestroy)
            {
                mSingletonObj = GameObject.Find("/_Singleton_");
                if (mSingletonObj == null)
                {
                    mSingletonObj = new GameObject("_Singleton_");
                    mSingletonObj.AddComponent<OzSingleton>();
                    UnityEngine.Object.DontDestroyOnLoad(mSingletonObj);
                }
            }
            return mSingletonObj;
        }
    }

    public static T GetSingleTon<T>() where T : Component, new()
    {
        if (hasDestroy)
        {
            return null;
        }
        T instance = null;

        if (SingletonGameObject != null)
        {
            instance = SingletonGameObject.AddMissingComponent<T>();
        }
        return instance;
    }

    public static LuaTable GetLuaSingleton(string luaClassName)
    {
        if(hasDestroy)
        {
            return null;
        }

        if(SingletonGameObject != null)
        {
            LuaMonoBehaviour luaMono;
            LuaMonoBehaviour[] luaMonoList = SingletonGameObject.GetComponents<LuaMonoBehaviour>();
            if(luaMonoList != null)
            {
                for(int i = 0; i < luaMonoList.Length; i++)
                {
                    luaMono = luaMonoList[i];
                    if(luaMono.LuaClassName == luaClassName)
                    {
                        return luaMono.GetLuaTable();
                    }
                }
            }

            luaMono = SingletonGameObject.AddComponent<LuaMonoBehaviour>();
            return luaMono.DoFile(luaClassName);
        }
        return null;
    }

    private void OnStart()
    {
        hasDestroy = false;
        SynchronizationContext.SetSynchronizationContext(OneThreadSynchronizationContext.Instance);
    }

    private void Update()
    {
        OneThreadSynchronizationContext.Instance.Update();
    }

    private void OnDestroy()
    {
        if (mSingletonObj == this.gameObject)
        {
            hasDestroy = true;
            mSingletonObj = null;
            OneThreadSynchronizationContext asy = OneThreadSynchronizationContext.Instance;
            asy.OnDestroy();
            asy = null;
        }
    }
}
