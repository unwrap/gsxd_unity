using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

public class CustomMenuItems
{
    #region debug
    const string kDebugLuaAssetBundlesMenu = "Custom/Debug Lua";

    [MenuItem(kDebugLuaAssetBundlesMenu, false, 1)]
    public static void ToggleSimulateAssetBundle()
    {
        OzLuaManager.isDebug = !OzLuaManager.isDebug;
    }

    [MenuItem(kDebugLuaAssetBundlesMenu, true, 1)]
    public static bool ToggleSimulateAssetBundleValidate()
    {
        Menu.SetChecked(kDebugLuaAssetBundlesMenu, OzLuaManager.isDebug);
        return true;
    }

    #endregion

    #region AssetBundle

    const string kSimulationMode = "Custom/AssetBundle/Simulation Mode";

    [MenuItem(kSimulationMode, false, 2)]
    public static void ToggleSimulationMode()
    {
        AssetBundleManager.SimulateAssetBundleInEditor = !AssetBundleManager.SimulateAssetBundleInEditor;
    }

    [MenuItem(kSimulationMode, true)]
    public static bool ToggleSimulationModeValidate()
    {
        Menu.SetChecked(kSimulationMode, AssetBundleManager.SimulateAssetBundleInEditor);
        return true;
    }

    [MenuItem("Custom/AssetBundle/导出AssetBundle", false, 2)]
    public static void BuildAssetBundles()
    {
        ExportAssetBundle.BuildAssetBundles();
    }

    [MenuItem("Custom/AssetBundle/设置AssetBundle Name", false, 3)]
    public static void SetAssetBundlesName()
    {
        ExportAssetBundle.SetAssetBundlesNameByDirectory();
    }

    [MenuItem("Assets/AssetBundle/设置AssetBundle Name", false, 201)]
    public static void SetAssetBundlesNameByDirectory()
    {
        ExportAssetBundle.SetAssetBundlesNameByDirectory();
    }

    [MenuItem("Custom/AssetBundle/更新bundleVersion", false, 4)]
    public static void UpdateBundleVersion()
    {
        BundleVersionChecker.UpdateBundleVersion();
    }
    #endregion

    #region 加密

    [MenuItem("Custom/加密/GenerateKey", false, 11)]
    static void GenerateDES()
    {
        ExportAssetBundle.GenerateKey();
    }

    #endregion

    #region lua
    [MenuItem("Custom/导出Lua", false, 21)]
    public static void ExportLua()
    {
        ExportAssetBundle.ExportLua();
    }
    #endregion

    #region 发版

    [MenuItem("Custom/发版/生成首包版本号", false, 102)]
    public static void GenerateVersion()
    {
        ExportAssetBundle.GenerateVersion();
    }

    [MenuItem("Custom/发版/生成增量包", false, 101)]
    public static void ExportPublic()
    {
        ExportAssetBundle.BuildAssetBundles();
        AssetDatabase.Refresh();
        ExportAssetBundle.ExportLua();
        AssetDatabase.Refresh();
        ExportAssetBundle.GenerateResPublic(CurrentBundleVersion.versionCode.ToString());
    }

    [MenuItem("Custom/发版/仅生成lua代码增量包", false, 101)]
    public static void ExportLuaPublic()
    {
        ExportAssetBundle.ExportLua();
        AssetDatabase.Refresh();
        ExportAssetBundle.GenerateDataPublic();
    }

    [MenuItem("Custom/发版/一键导出所有资源", false, 103)]
    public static void ExportAllAssetBundle()
    {
        string strOutputPath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
        DirectoryInfo dir = new DirectoryInfo(strOutputPath);
        if (dir.Exists)
        {
            dir.Delete(true);
        }
        ExportAssetBundle.BuildAssetBundles();
        ExportAssetBundle.ExportLua();
    }

    #endregion

    #region 服务器

    const string kDebugServerDemo = "Custom/服务器/Demo服(47.107.176.241:18001)";
    const string kDebugServerLocal = "Custom/服务器/本地环境(127.0.0.1:18001)";

    static string[] serverList =
    {
        "47.107.176.241:18001",
        "127.0.0.1:18001"
    };

    [MenuItem(kDebugServerDemo, false, 50)]
    public static void ToggleDemoConnect()
    {
        if (GameConfig.connectServer == serverList[0])
        {
            GameConfig.connectServer = "";
        }
        else
        {
            GameConfig.connectServer = serverList[0];
        }
    }

    [MenuItem(kDebugServerDemo, true, 50)]
    public static bool ToggleDemoConnectValidate()
    {
        Menu.SetChecked(kDebugServerLocal, GameConfig.connectServer == serverList[0]);
        return true;
    }

    [MenuItem(kDebugServerLocal, false, 50)]
    public static void ToggleLocalConnect()
    {
        if (GameConfig.connectServer == serverList[1])
        {
            GameConfig.connectServer = "";
        }
        else
        {
            GameConfig.connectServer = serverList[1];
        }
    }

    [MenuItem(kDebugServerLocal, true, 50)]
    public static bool ToggleLocalConnectValidate()
    {
        Menu.SetChecked(kDebugServerLocal, GameConfig.connectServer == serverList[1]);
        return true;
    }

    #endregion

    #region 其它

    [MenuItem("Custom/其它/清除PlayerPrefs", false, 200)]
    public static void CleanPlayerPrefs()
    {
        PlayerPrefs.DeleteAll();
    }

    [MenuItem("Custom/其它/编辑PlayerPrefs", false, 201)]
    public static void EditPlayerPrefs()
    {
        CustomPrefsEditor.ShowWindow();
    }

    [MenuItem("Custom/其它/清除本地缓存的文件", false, 202)]
    public static void CleanLocalFile()
    {
        PlayerPrefs.DeleteKey(GameConfig.LocalResVersionKey);
        PlayerPrefs.DeleteKey(GameConfig.LocalSubVersionKey);
        ExportAssetBundle.CleanLocalFile();
    }

    [MenuItem("Custom/其它/对lua文件进行UTF8编码", false, 203)]
    public static void EncodeLuaFile()
    {
        ExportAssetBundle.EncodeLuaFile();
    }

    [MenuItem("Custom/其它/对C#文件进行UTF8编码", false, 203)]
    public static void EncodeCSharpFile()
    {
        ExportAssetBundle.EncodeCSharpFile();
    }

    [MenuItem("Custom/其它/clear progress bar", false, 204)]
    public static void ClearProgressBar()
    {
        EditorUtility.ClearProgressBar();
    }

    [MenuItem("Custom/其它/info", false, 205)]
    public static void showInfo()
    {
        Debug.LogFormat("Application.persistentDataPath:{0}", Application.persistentDataPath);
    }

    [MenuItem("Custom/其它/生成混淆代码", false, 206)]
    public static void GenerateCode()
    {
        GenerateObfuscatedCode.GenerateCodes();
    }

    [MenuItem("Custom/其它/加密assetbundle", false, 207)]
    public static void EncryptAssetBundle()
    {
        ExportAssetBundle.EncryptAssetBundle();
    }

    [MenuItem("Custom/其它/解密assetbundle", false, 208)]
    public static void DecryptAssetBundle()
    {
        ExportAssetBundle.EncryptAssetBundle();
    }

    [MenuItem("Custom/其它/Define/添加DEBUG_PROFILER", false, 209)]
    public static void AddProfilerDefine()
    {
        BetterDefinesUtils.AddProfiler();
    }

    [MenuItem("Custom/其它/Define/移除DEBUG_PROFILER", false, 210)]
    public static void RemoveProfilerDefine()
    {
        BetterDefinesUtils.RemoveProfiler();
    }

    //[MenuItem("Custom/其它/修改prefab朝向", false, 212)]
    public static void ModifyPrefabForward()
    {
        EditorUtility.DisplayProgressBar("Modify Prefab", "Please wait...", 0);
        string[] ids = AssetDatabase.FindAssets("t:Prefab", new string[] { "Assets/RawResources/Scene/CartoonStyle_Fantasy_Pack/Prefabs" });
        for (int i = 0; i < ids.Length; i++)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(ids[i]);
            GameObject prefab = AssetDatabase.LoadAssetAtPath(assetPath, typeof(GameObject)) as GameObject;

            if (prefab.GetComponent<MeshFilter>() != null)
            {
                GameObject parentObj = new GameObject(prefab.name);
                GameObject adjustObj = GameObject.Instantiate<GameObject>(prefab);
                adjustObj.name = prefab.name;
                adjustObj.transform.SetParent(parentObj.transform);
                adjustObj.transform.localPosition = Vector3.zero;
                adjustObj.transform.localScale = Vector3.one;
                adjustObj.transform.forward = Vector3.up;

                PrefabUtility.SaveAsPrefabAssetAndConnect(parentObj, assetPath, InteractionMode.AutomatedAction);
                GameObject.DestroyImmediate(parentObj);
            }
            EditorUtility.DisplayProgressBar("Modify Prefab", assetPath, i / (float)ids.Length);
        }
        EditorUtility.ClearProgressBar();
        /*
        if (assetPath.StartsWith("Assets/RawResources/Scene/CartoonStyle_Fantasy_Pack"))
        {
            if (assetPath.EndsWith(".prefab"))
            {
                GameObject obj = PrefabUtility.LoadPrefabContents(assetPath);
                GameObject newPrefab = PrefabUtility.InstantiatePrefab(obj) as GameObject;
                newPrefab.transform.forward = Vector3.up;
                PrefabUtility.SaveAsPrefabAssetAndConnect(newPrefab, assetPath, InteractionMode.AutomatedAction);
            }
        }
        */
    }

    [MenuItem("Assets/生成子弹", false, 220)]
    public static void GenBullet()
    {
        GenerateBullet.GenBullet();
    }

    [MenuItem("Assets/生成子弹", true, 220)]
    public static bool CheckBullet()
    {
        return GenerateBullet.CheckObjectType();
    }

    [MenuItem("Assets/批量生成子弹", false, 221)]
    public static void GenBulletBatch()
    {
        GenerateBullet.GenBulletBatch();
    }

    [MenuItem("Assets/批量生成子弹", true, 221)]
    public static bool CheckGenBulletBatch()
    {
        return GenerateBullet.CheckCanGenBulletBatch();
    }

    [MenuItem("Assets/删除子弹", false, 222)]
    public static void DeleteBullet()
    {
        GenerateBullet.DeleteBullet();
    }

    [MenuItem("Assets/删除子弹", true, 222)]
    public static bool CheckDeleteBullet()
    {
        return GenerateBullet.CheckDelBullet();
    }

    [MenuItem("Assets/Find References In Project", false, 100)]
    public static void FindReference()
    {
        FindReferencesInProject.Find();
    }

    [MenuItem("Assets/Find References In Project", true, 100)]
    public static bool FindReferenceValidate()
    {
        return FindReferencesInProject.FindValidate();
    }

    #endregion

    #region 文件及文件夹
    [MenuItem("Assets/当前目录下创建Materials等分类目录", false, 101)]
    public static void CreateFolder()
    {
        EditorFolder.CreateFolder();
    }

    [MenuItem("Assets/当前目录下创建Lua文件", false, 101)]
    public static void CreateLuaFile()
    {
        EditorFolder.CreateLuaFile();
    }

    [MenuItem("Assets/打开场景/开始场景", false, 102)]
    public static void OpenStartScene()
    {
        EditorSceneManager.OpenScene("Assets/Scene/start.unity");
    }

    [MenuItem("Assets/打开场景/临时场景", false, 103)]
    public static void OpenTempScene()
    {
        try
        {
            EditorSceneManager.OpenScene("Assets/Scene/temp.unity");
        }
        catch (Exception)
        {
            EditorSceneManager.NewScene(NewSceneSetup.EmptyScene);
            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>("Assets/Resources/Scene/Prefab/Canvas.prefab");
            GameObject obj = GameObject.Instantiate(prefab);
            obj.name = "Canvas";
        }
    }

    #endregion

    #region CompileCoreScriptToDLL

    //[MenuItem("Custom/CompileCoreScriptToDLL", false, 400)]
    public static void CompileCoreScriptToDLL()
    {
        CompileCoreScript.CompileCoreScriptToDLL();
    }
    #endregion

}
