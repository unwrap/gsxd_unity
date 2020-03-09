using UnityEngine;
using System.Collections;
using System.IO;

[SLua.CustomLuaClass]
public class PathUtil
{
#if UNITY_IOS
	public const string Platform="iOS";
#elif UNITY_ANDROID
    public const string Platform = "android";
#elif UNITY_WEBPLAYER
    public const string Platform ="WebPlayer";
#elif UNITY_WP8
    public const string Platform="WP8Player";
#elif UNITY_METRO
    public const string Platform = "MetroPlayer";
#elif UNITY_OSX 
    public const string Platform = "OSX";
#elif UNITY_STANDALONE_OSX
    public const string Platform = "StandaloneOSXIntel";
#else
    public const string Platform = "StandaloneWindows";
#endif

    public static string GetPlatformFolderForAssetBundles()
    {
        if (GameUtil.isDebug)
        {
            return "debug/" + Platform;
        }
        return Platform;
    }

    public static string GetAssetPath(string name)
    {
        string path = Platform + "/" + name;
        return path;
    }

    public static string GetRemoteAssetPath(string name)
    {
        string path = string.Concat(Platform, CurrentBundleVersion.versionCode, "/", name);
        return path;
    }

    private static string AssetLocalPath
    {
        get
        {
            if (GameUtil.isDebug)
            {
                return Application.persistentDataPath + "/" + CurrentBundleVersion.versionCode + "/debug";
            }
            return Application.persistentDataPath + "/" + CurrentBundleVersion.versionCode;
        }
    }

    public static string GetFileFullPath(string absolutePath)
    {
        string path = PathUtil.AssetLocalPath + "/" + absolutePath;
        if (!File.Exists(path))
        {
            path = Application.streamingAssetsPath + "/" + absolutePath;
        }
#if UNITY_EDITOR
        path = path.Replace("/", "\\");
#endif
        if (path.IndexOf("://") == -1)
        {
            path = "file://" + path;
        }
        return path;
    }

    public static string GetAssetBundleFilePath(string absolutePath)
    {
        absolutePath = GetAssetPath(absolutePath);
        string path = PathUtil.AssetLocalPath + "/" + absolutePath;
        if (!File.Exists(path))
        {
#if UNITY_ANDROID && !UNITY_EDITOR
            path = Application.dataPath + "!assets/" + absolutePath;
#else
            path = Application.streamingAssetsPath + "/" + absolutePath;
#endif
        }
        return path;
    }

    public static string GetAssetBundleFilePathEx(string absolutePath, out bool isStreamingAsset)
    {
        absolutePath = GetAssetPath(absolutePath);
        string path = PathUtil.AssetLocalPath + "/" + absolutePath;
        if (!File.Exists(path))
        {
#if UNITY_ANDROID && !UNITY_EDITOR
            path = Application.dataPath + "!assets/" + absolutePath;
#else
            path = Application.streamingAssetsPath + "/" + absolutePath;
#endif
            isStreamingAsset = true;
        }
        else
        {
            isStreamingAsset = false;
        }
        return path;
    }

    public static string GetStreamingAssetsPath()
    {
        if (Application.isEditor)
        {
            return "file://" + System.Environment.CurrentDirectory.Replace("\\", "/");
        }
        if (Application.isMobilePlatform || Application.isConsolePlatform)
        {
            return Application.streamingAssetsPath;
        }
        return "file://" + Application.streamingAssetsPath;
    }

    public static string AddVersion2FileName(string fn, string version)
    {
        string ext = Path.GetExtension(fn);
        if (string.IsNullOrEmpty(ext))
        {
            return string.Concat(fn, "_", version);
        }
        int last = fn.LastIndexOf(".");
        if (last == -1)
        {
            last = fn.Length;
        }
        string cut = fn.Substring(0, last);
        return string.Concat(cut, "_", version, ext);
    }

    public static string GetAssetFullPath(string assetPath)
    {
        string path = GetFileFullPath(GetAssetPath(assetPath));
        return path;
    }

    // 从url里取文件名
    public static string GetKeyURLFileName(string url)
    {
        if (string.IsNullOrEmpty(url))
        {
            return string.Empty;
        }
        string re = "";
        int len = url.Length - 1;
        char[] arr = url.ToCharArray();
        while (len >= 0 && arr[len] != '/' && arr[len] != '\\')
        {
            len = len - 1;
        }
        re = url.Substring(len + 1);
        int last = re.LastIndexOf(".");
        if (last == -1)
        {
            last = re.Length;
        }
        string cut = re.Substring(0, last);
        cut = cut.Replace('.', '_');
        return cut;
    }

    //从url里取文件后缀
    public static string GetURLFileSuffix(string url)
    {
        if (string.IsNullOrEmpty(url))
        {
            return string.Empty;
        }
        int last = url.LastIndexOf(".");
        int end = url.IndexOf("?");
        if (end == -1)
        {
            end = url.Length;
        }
        else
        {
            last = url.IndexOf(".", 0, end);
        }
        string cut = url.Substring(last, end - last).Replace(".", "");
        return cut;
    }
}
