using UnityEngine;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif

[SLua.CustomLuaClass]
public class GameConfig : ScriptableObject
{
#if UNITY_EDITOR
    const string KeyDebugString = "OzGameConfig_connect_server";
    [SLua.DoNotToLua]
    public static string connectServer
    {
        get
        {
            string _debug = EditorPrefs.GetString(KeyDebugString, "");
            return _debug;
        }
        set
        {
            EditorPrefs.SetString(KeyDebugString, value);
        }
    }
#endif

    private static string m_server;
    public static string server
    {
        get
        {
#if UNITY_EDITOR
            if(!string.IsNullOrEmpty(connectServer))
            {
                return connectServer;
            }
            else
            {
                return m_server;
            }
#else
            return m_server;
#endif
        }
        set
        {
            m_server = value;
        }
    }

    private static GameConfig m_localConfig;
    public static GameConfig localConfig
    {
        get
        {
            if (m_localConfig == null)
            {
                m_localConfig = Resources.Load<GameConfig>("config");
#if UNITY_EDITOR
                if (m_localConfig == null)
                {
                    m_localConfig = GameConfig.CreateInstance<GameConfig>();
                    AssetDatabase.CreateAsset(m_localConfig, "Assets/Resources/config.asset");
                }
#endif
            }
            return m_localConfig;
        }
    }

    public static RemoteGameConfig remoteConfig = new RemoteGameConfig();

    public static string LocalSubVersionKey
    {
        get
        {
            return string.Concat(PathUtil.GetPlatformFolderForAssetBundles(), CurrentBundleVersion.versionCode, "_subVersion");
        }
    }

    public static string LocalResVersionKey
    {
        get
        {
            return string.Concat(PathUtil.GetPlatformFolderForAssetBundles(), CurrentBundleVersion.versionCode, "_resVersion");
        }
    }

    public static void ResetConfig()
    {
        remoteConfig.subVersion = "0";
        remoteConfig.resVersion = "0";
    }

    public static void SetRemoteConfig(string subVersion, string resVersion)
    {
        if (string.IsNullOrEmpty(subVersion))
        {
            subVersion = "0";
        }
        if (string.IsNullOrEmpty(resVersion))
        {
            resVersion = "0";
        }
        remoteConfig.subVersion = subVersion;
        remoteConfig.resVersion = resVersion;
    }

    private SortedList<string, string> configs = new SortedList<string, string>();

    [SerializeField]
    private string m_subVersion;
    [SerializeField]
    private string m_resVersion;
    [SerializeField]
    private string m_assetDomain;
    [SerializeField]
    private string m_platform = "orig";

    public string platform
    {
        get
        {
            return m_platform;
        }
        set
        {
            m_platform = value;
        }
    }

    //小版本号,热更用
    public string subVersion
    {
        get
        {
            if (string.IsNullOrEmpty(m_subVersion))
            {
                m_subVersion = GetConfig("subVersion");
            }
            return m_subVersion;
        }
        set
        {
            m_subVersion = value;
        }
    }

    public string resVersion
    {
        get
        {
            if (string.IsNullOrEmpty(m_resVersion))
            {
                m_resVersion = GetConfig("resVersion");
            }
            return m_resVersion;
        }
        set
        {
            m_resVersion = value;
        }
    }

    public string assetDomain
    {
        get
        {
            if (string.IsNullOrEmpty(m_assetDomain))
            {
                m_assetDomain = GetConfig("assetDomain");
            }
#if BANSHU && !UNITY_EDITOR
            return m_assetDomain + "/banshu";
#else
            return m_assetDomain;
#endif
        }
        set
        {
            m_assetDomain = value;
        }
    }

    public string GetConfig(string key)
    {
        string value = string.Empty;
        configs.TryGetValue(key, out value);
        return value;
    }
}

public class RemoteGameConfig
{
    //lua代码版本号
    public string subVersion = "0";
    //资源版本号
    public string resVersion = "0";
}
