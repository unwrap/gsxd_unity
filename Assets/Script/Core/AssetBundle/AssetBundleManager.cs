#undef DEBUG_ASSETBUNDLE

using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine.SceneManagement;
using System.IO;

#if UNITY_EDITOR
using UnityEditor;
#endif

//已经加载的AssetBundle
[SLua.CustomLuaClass]
public class LoadedAssetBundle
{
    public AssetBundle m_AssetBundle;
    public string m_AssetBundleName;
    public int m_ReferencedCount;
    public bool needUnload = true;

    public LoadedAssetBundle(AssetBundle assetBundle, string assetBundleName, bool needUnload)
    {
        this.m_AssetBundle = assetBundle;
        this.m_AssetBundleName = assetBundleName;
        this.m_ReferencedCount = 1;
        this.needUnload = needUnload;
    }

    public void Dispose(bool unloadAllLoadedObjects)
    {
        if (this.m_AssetBundle != null)
        {
            try
            {
                this.m_AssetBundle.Unload(unloadAllLoadedObjects);
            }
            catch (Exception e)
            {
                Debug.LogErrorFormat("error:{0}, ab:{1}", e.Message, m_AssetBundleName);
            }
        }
    }
}

[SLua.CustomLuaClass]
public class AssetBundleManager : MonoBehaviour
{
    #region static member

    private static Type Typeof_GameObject = typeof(GameObject);

    private static AssetBundleManifest m_AssetBundleManifest = null;
    private static Dictionary<string, LoadedAssetBundle> m_LoadedAssetBundles = new Dictionary<string, LoadedAssetBundle>();
    private static List<AssetBundleLoadOperation> m_InProgressOperations = new List<AssetBundleLoadOperation>();
    private static List<string> m_DownloadingBundles = new List<string>();
    private static Dictionary<string, string> m_DownloadingErrors = new Dictionary<string, string>();
    private static Dictionary<string, string[]> m_Dependencies = new Dictionary<string, string[]>();

    private static string[] m_ActiveVariants = { };

    private static AssetBundleManager m_instance;

#if UNITY_EDITOR
    static int m_SimulateAssetBundleInEditor = -1;
    const string kSimulateAssetBundles = "SimulateAssetBundles";
#endif

    public static string[] ActiveVariants
    {
        get
        {
            return m_ActiveVariants;
        }
        set
        {
            m_ActiveVariants = value;
        }
    }

    public static AssetBundleManifest AssetBundleManifestObject
    {
        set
        {
            m_AssetBundleManifest = value;
        }
    }

#if UNITY_EDITOR
    [SLua.DoNotToLua]
    public static bool SimulateAssetBundleInEditor
    {
        get
        {
            if (m_SimulateAssetBundleInEditor == -1)
            {
                m_SimulateAssetBundleInEditor = EditorPrefs.GetBool(kSimulateAssetBundles, true) ? 1 : 0;
            }
            return m_SimulateAssetBundleInEditor != 0;
        }
        set
        {
            int newValue = value ? 1 : 0;
            if (newValue != m_SimulateAssetBundleInEditor)
            {
                m_SimulateAssetBundleInEditor = newValue;
                EditorPrefs.SetBool(kSimulateAssetBundles, value);
            }
        }
    }
#endif

    #endregion

    #region static public

    public static AssetBundleLoadManifestOperation Initialize()
    {
        UnloadAllAssetBundle();
        return Initialize(PathUtil.Platform);
    }

    public static AssetBundleLoadManifestOperation Initialize(string manifestAssetBundleName)
    {
#if UNITY_EDITOR
        Debug.LogFormat("<color=green>Simulation Mode: {0}</color>", (SimulateAssetBundleInEditor ? "Enabled" : "Disabled"));
#endif

        GameObject go = GameObject.Find("/AssetBundleManager");
        if (go == null)
        {
            go = new GameObject("AssetBundleManager");
            DontDestroyOnLoad(go);
        }
        m_instance = go.AddMissingComponent<AssetBundleManager>();

#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            return null;
        }
#endif
        LoadManifest(manifestAssetBundleName);
        AssetBundleLoadManifestOperation operation = new AssetBundleLoadManifestOperation(manifestAssetBundleName, "AssetBundleManifest", typeof(AssetBundleManifest));
        m_InProgressOperations.Add(operation);
        return operation;
    }

    public static LoadedAssetBundle GetLoadedAssetBundle(string assetBundleName)
    {
        LoadedAssetBundle bundle = null;
        m_LoadedAssetBundles.TryGetValue(assetBundleName, out bundle);
        if (bundle == null)
        {
            return null;
        }
        // No dependencies are recorded, only the bundle itself is required.
        string[] dependencies = null;
        if (!m_Dependencies.TryGetValue(assetBundleName, out dependencies))
        {
            return bundle;
        }

        // Make sure all dependencies are loaded
        foreach (string dependency in dependencies)
        {
            LoadedAssetBundle dependentBundle;
            m_LoadedAssetBundles.TryGetValue(dependency, out dependentBundle);
            if (dependentBundle == null)
            {
                return null;
            }
        }
        return bundle;
    }

    public static void UnloadAllAssetBundle()
    {
        string strBootstrapName = "bootstrap/bootstrap.u3d";
        LoadedAssetBundle bootstrapBundle = null;
        foreach (KeyValuePair<string, LoadedAssetBundle> kv in m_LoadedAssetBundles)
        {
            if (kv.Key == strBootstrapName)
            {
                bootstrapBundle = kv.Value;
            }
            else
            {
                kv.Value.Dispose(true);
            }
        }
        m_LoadedAssetBundles = new Dictionary<string, LoadedAssetBundle>();
        if (bootstrapBundle != null)
        {
            m_LoadedAssetBundles[strBootstrapName] = bootstrapBundle;
        }
        m_InProgressOperations = new List<AssetBundleLoadOperation>();
        m_DownloadingBundles = new List<string>();
        m_DownloadingErrors = new Dictionary<string, string>();
        m_Dependencies = new Dictionary<string, string[]>();
    }

    public static bool UnloadAssetBundle(string assetBundleName, bool unloadAllLoadedObjects, string origin)
    {
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            return true;
        }
#endif
        return UnloadAssetBundleInternal(assetBundleName, unloadAllLoadedObjects, origin);
    }

    static protected void UnloadDependencies(string assetBundleName, bool unloadAllLoadedObjects, string origin)
    {
        string[] dependencies = null;
        if (!m_Dependencies.TryGetValue(assetBundleName, out dependencies))
            return;

        // Loop dependencies.
        foreach (var dependency in dependencies)
        {
            UnloadAssetBundleInternal(dependency, unloadAllLoadedObjects, origin);
        }

        m_Dependencies.Remove(assetBundleName);
    }

    public static bool UnloadAssetBundle(string assetBundleName, bool unloadAllLoadedObjects)
    {
        return UnloadAssetBundle(assetBundleName, unloadAllLoadedObjects, "");
    }

    public static GameObject InstantiateGameObject(string assetBundleName, string assetName)
    {
        UnityEngine.Object obj = LoadAsset(assetBundleName, assetName, Typeof_GameObject, true);
        if (obj != null)
        {
            GameObject go = GameUtil.Instantiate(obj) as GameObject;
            if (go != null)
            {
                AssetBundleReference bundleRef = go.AddMissingComponent<AssetBundleReference>();
                bundleRef.assetBundleName = assetBundleName;
            }
            return go;
        }
        return null;
    }

    public static UnityEngine.Object[] LoadAllAssets(string assetBundleName, System.Type type)
    {
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            string[] assetPaths = AssetDatabase.GetAssetPathsFromAssetBundle(assetBundleName);
            if (assetPaths.Length == 0)
            {
                Debug.LogError("There is no asset bundle: " + assetBundleName);
                return null;
            }
            UnityEngine.Object[] targets = new UnityEngine.Object[assetPaths.Length];//AssetDatabase.LoadAllAssetsAtPath(assetPaths[0]);
            for (int i = 0; i < assetPaths.Length; i++)
            {
                string assetPath = assetPaths[i];
                targets[i] = AssetDatabase.LoadAssetAtPath(assetPath, type);
            }
            return targets;
        }
        else
#endif
        {
            assetBundleName = RemapVariantName(assetBundleName);
            LoadedAssetBundle bundle = LoadAssetBundle(assetBundleName, true);
            if (bundle == null)
            {
                return null;
            }
            if (bundle.m_AssetBundle != null)
            {
#if DEBUG_PROFILER
                Profiler.BeginSample("---------loadAllAsset:" + assetBundleName);
#endif
                UnityEngine.Object[] obj = bundle.m_AssetBundle.LoadAllAssets(type);
#if DEBUG_PROFILER
                Profiler.EndSample();
#endif
                return obj;
            }
        }
        return null;
    }

    public static void LoadAtlas(string assetBundleName)
    {
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            return;
        }
        else
#endif
        {
            LoadAssetBundle(assetBundleName, true, false);
        }
    }

    public static UnityEngine.Object LoadAsset(string assetBundleName, string assetName, System.Type type)
    {
        return AssetBundleManager.LoadAsset(assetBundleName, assetName, type, true);
    }

    public static UnityEngine.Object LoadAsset(string assetBundleName, string assetName, System.Type type, bool reference)
    {
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            string[] assetPaths = AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName(assetBundleName, assetName);
            if (assetPaths.Length == 0)
            {
                //Debug.LogError("There is no asset with name \"" + assetName + "\" in " + assetBundleName);
                return null;
            }
            UnityEngine.Object target = AssetDatabase.LoadAssetAtPath(assetPaths[0], type);
            return target;
        }
        else
#endif
        {
            assetBundleName = RemapVariantName(assetBundleName);
            LoadedAssetBundle bundle = LoadAssetBundle(assetBundleName, reference);
            if (bundle == null)
            {
                return null;
            }
            if (bundle.m_AssetBundle != null)
            {
#if DEBUG_PROFILER
                Profiler.BeginSample("---------loadAsset:" + assetName);
#endif
                UnityEngine.Object obj = bundle.m_AssetBundle.LoadAsset(assetName, type);
#if DEBUG_PROFILER
                Profiler.EndSample();
#endif
                if (obj == null)
                {
                    UnityEngine.Object[] objs = bundle.m_AssetBundle.LoadAssetWithSubAssets(assetName, type);
                }
                return obj;
            }
        }
        return null;
    }

    public static AssetBundleLoadAssetOperation LoadAssetAsync(string assetBundleName, string assetName, System.Type type)
    {
        AssetBundleLoadAssetOperation operation = null;
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            string[] assetPaths = AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName(assetBundleName, assetName);
            if (assetPaths.Length == 0)
            {
                Debug.LogError("There is no asset with name \"" + assetName + "\" in " + assetBundleName);
                return null;
            }
            UnityEngine.Object target = AssetDatabase.LoadMainAssetAtPath(assetPaths[0]);
            operation = new AssetBundleLoadAssetOperationSimulation(target);
        }
        else
#endif
        {
            assetBundleName = RemapVariantName(assetBundleName);
            LoadAssetBundleAsync(assetBundleName, true, true);
            operation = new AssetBundleLoadAssetOperationFull(assetBundleName, assetName, type);
            m_InProgressOperations.Add(operation);
        }
        return operation;
    }

    public static void LoadLevel(string levelName)
    {
        LoadLevel(levelName + ".u3d", levelName);
    }

    public static void LoadLevel(string assetBundleName, string levelName)
    {
        LoadLevel(assetBundleName, levelName, null);
    }

    public static void LoadLevel(string assetBundleName, string levelName, Action completeHandler)
    {
        if (m_instance != null)
        {
            m_instance.LoadLevelEx(assetBundleName, levelName, completeHandler);
        }
    }

    public static AssetBundleLoadOperation LoadLevelAsync(string assetBundleName, string levelName)
    {
        AssetBundleLoadOperation operation = null;
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            operation = new AssetBundleLoadLevelSimulationOperation(assetBundleName, levelName);
        }
        else
#endif
        {
            assetBundleName = RemapVariantName(assetBundleName);
            LoadAssetBundle(assetBundleName, true);
            operation = new AssetBundleLoadLevelOperation(assetBundleName, levelName);
            m_InProgressOperations.Add(operation);
        }
        return operation;
    }

    #endregion

    #region static protected

    protected static LoadedAssetBundle LoadManifest(string manifestAssetBundleName)
    {
        LoadedAssetBundle bundle = LoadAssetBundleInternal(manifestAssetBundleName, true, true, false);
        if (bundle == null)
        {
            OzDebug.Log("LoadManifest fail.");
        }
        return bundle;
    }

    protected static void LoadAssetBundleAsync(string assetBundleName, bool reference, bool needUnload)
    {
#if UNITY_EDITOR
        // If we're in Editor simulation mode, we don't have to really load the assetBundle and its dependencies.
        if (SimulateAssetBundleInEditor)
        {
            return;
        }
#endif
        bool isAlreadyProcessed = LoadAssetBundleInternalAsync(assetBundleName, false, needUnload);
        if (!isAlreadyProcessed)
        {
            LoadDependencies(assetBundleName, reference);
        }
    }

    protected static LoadedAssetBundle LoadAssetBundle(string assetBundleName, bool reference, bool needUnload = true)
    {
        return LoadAssetBundleInternal(assetBundleName, reference, false, needUnload);
    }

    protected static LoadedAssetBundle LoadAssetBundleInternal(string assetBundleName, bool reference, bool isLoadingAssetBundleManifest = false, bool needUnload = true)
    {
#if UNITY_EDITOR
        if (SimulateAssetBundleInEditor)
        {
            return null;
        }
#endif
        //已经加载
        LoadedAssetBundle bundle = null;
        m_LoadedAssetBundles.TryGetValue(assetBundleName, out bundle);
        if (bundle != null)
        {
            if (reference)
            {
                bundle.m_ReferencedCount++;
            }
            if (!isLoadingAssetBundleManifest)
            {
                //首次加载需要检查依赖
                LoadDependencies(assetBundleName, reference);
            }
#if DEBUG_ASSETBUNDLE
            Debug.LogFormat("[AssetBundleManager] load {0}, ref:{1}", assetBundleName, bundle.m_ReferencedCount);
#endif
            return bundle;
        }
#if DEBUG_PROFILER
        Profiler.BeginSample("---------" + assetBundleName);
#endif
        bool isStreamingAsset;
        string strFilePath = PathUtil.GetAssetBundleFilePathEx(assetBundleName, out isStreamingAsset);
#if zhishangios || fengling || jhdmx || jhfyz || jhqxz || jhxkx || wmdjh || jrqxz|| wlqxz1 || lunplayios2 || zsmj2 || zsmj3 || lunplayiostw || lunplayiosjp || lunplayiosen || xxmkorios || dachenios || fengling2 || flquick
        AssetBundle ab = null;
        if (isStreamingAsset && assetBundleName.EndsWith("u3d"))
        {
            byte[] dataFile = DecryptAssetBundle(strFilePath);
            if (dataFile != null)
            {
                try
                {
                    ab = AssetBundle.LoadFromMemory(dataFile);
                }
                catch (Exception)
                {
                    Debug.LogError(assetBundleName);
                }
            }
        }
        else
        {
            ab = AssetBundle.LoadFromFile(strFilePath);
        }
#else
        AssetBundle ab = AssetBundle.LoadFromFile(strFilePath);
#endif

        if (ab == null)
        {
            return null;
        }

        bundle = new LoadedAssetBundle(ab, assetBundleName, needUnload);
#if DEBUG_PROFILER
        Profiler.EndSample();
#endif
        m_LoadedAssetBundles.Add(assetBundleName, bundle);
#if DEBUG_ASSETBUNDLE
        Debug.LogFormat("[AssetBundleManager] load {0}, ref:{1}", assetBundleName, bundle.m_ReferencedCount);
#endif

        if (!isLoadingAssetBundleManifest)
        {
            //首次加载需要检查依赖
            LoadDependencies(assetBundleName, reference);
        }

        return bundle;
    }

    protected static bool LoadAssetBundleInternalAsync(string assetBundleName, bool isLoadingAssetBundleManifest, bool needUnload = true)
    {
        LoadedAssetBundle bundle = null;
        m_LoadedAssetBundles.TryGetValue(assetBundleName, out bundle);
        if (bundle != null)
        {
            bundle.m_ReferencedCount++;
            return true;
        }

        if (m_DownloadingBundles.Contains(assetBundleName))
        {
            return true;
        }

        bool isStreamingAsset;
        string strFilePath = PathUtil.GetAssetBundleFilePathEx(assetBundleName, out isStreamingAsset);
#if zhishangios || fengling || jhdmx || jhfyz || jhqxz || jhxkx || wmdjh || jrqxz|| wlqxz1 || lunplayios2 || zsmj2 || zsmj3 || lunplayiostw || lunplayiosjp || lunplayiosen || xxmkorios || dachenios || fengling2 || flquick
        AssetBundleCreateRequest request = null;
        if (isStreamingAsset && assetBundleName.EndsWith("u3d"))
        {
            byte[] dataFile = DecryptAssetBundle(strFilePath);
            if(dataFile != null)
            {
                request = AssetBundle.LoadFromMemoryAsync(dataFile);
            }
        }
        else
        {
            request = AssetBundle.LoadFromFileAsync(strFilePath);
        }
#else
        AssetBundleCreateRequest request = AssetBundle.LoadFromFileAsync(PathUtil.GetAssetBundleFilePath(assetBundleName));
#endif
        m_InProgressOperations.Add(new AssetBundleLoadFromFileAsyncOperation(assetBundleName, request, needUnload));
        m_DownloadingBundles.Add(assetBundleName);
        return false;
    }

    private static byte[] DecryptAssetBundle(string strFilePath)
    {
        if(!File.Exists(strFilePath))
        {
            return null;
        }
        FileStream fs = null;
        try
        {
            fs = new FileStream(strFilePath, FileMode.Open, FileAccess.Read);
            byte[] bytes = new byte[fs.Length];
            int numBytesToRead = (int)fs.Length;
            int numBytesRead = 0;
            while (numBytesToRead > 0)
            {
                // Read may return anything from 0 to numBytesToRead.
                int n = fs.Read(bytes, numBytesRead, numBytesToRead);

                // Break when the end of the file is reached.
                if (n == 0)
                    break;

                numBytesRead += n;
                numBytesToRead -= n;
            }
            return Xxtea.XXTEA.Decrypt(bytes, GameUtil.assetbundleKey);
        }
        catch(Exception ex)
        {
            Debug.LogError(ex.Message);
            return null;
        }
        finally
        {
            if (fs != null)
            {
                fs.Dispose();
            }
        }
    }

    protected static void LoadDependencies(string assetBundleName, bool reference)
    {
        if (m_AssetBundleManifest == null)
        {
            //Debug.LogError("Please initialize AssetBundleManifest by calling AssetBundleManager.Initialize()");
            return;
        }
        string[] dependencies = m_AssetBundleManifest.GetAllDependencies(assetBundleName);
        if (dependencies.Length == 0)
        {
            return;
        }
        for (int i = 0; i < dependencies.Length; i++)
        {
            dependencies[i] = RemapVariantName(dependencies[i]);
        }

        string[] existDependencies = null;
        if (m_Dependencies.TryGetValue(assetBundleName, out existDependencies))
        {
            m_Dependencies[assetBundleName] = dependencies;
        }
        else
        {
            m_Dependencies.Add(assetBundleName, dependencies);
        }

        for (int i = 0; i < dependencies.Length; i++)
        {
            LoadAssetBundleInternal(dependencies[i], reference);
        }
    }

    protected static bool UnloadAssetBundleInternal(string assetBundleName, bool unloadAllLoadedObjects, string origin)
    {
        LoadedAssetBundle bundle = GetLoadedAssetBundle(assetBundleName);
        if (bundle == null)
        {
            return false;
        }

        bundle.m_ReferencedCount--;
        if (bundle.needUnload == false)
        {
            bundle.m_ReferencedCount = 1;
        }

        if (bundle.m_ReferencedCount == 0)
        {
            //bundle.m_AssetBundle.Unload(true);
            bundle.Dispose(unloadAllLoadedObjects);
            m_LoadedAssetBundles.Remove(assetBundleName);
#if DEBUG_ASSETBUNDLE
            Debug.LogFormat("[AssetBundleManager] delete {0}, ref:{1}, origin:{2}", assetBundleName, bundle.m_ReferencedCount, origin);
#endif
        }
#if DEBUG_ASSETBUNDLE
        else
        {
            Debug.LogFormat("[AssetBundleManager] delete {0}, ref:{1}, origin:{2}", assetBundleName, bundle.m_ReferencedCount, origin);
        }
#endif

        return true;
    }

    //根据当前的变体决定正确的AssetBundle
    protected static string RemapVariantName(string assetBundleName)
    {
        if (string.IsNullOrEmpty(assetBundleName))
        {
            return null;
        }
        if (m_AssetBundleManifest == null)
        {
            return assetBundleName;
        }
        string[] bundlesWithVariant = m_AssetBundleManifest.GetAllAssetBundlesWithVariant();
        if (bundlesWithVariant == null)
        {
            return assetBundleName;
        }
        string[] split = assetBundleName.Split('.');

        int bestFit = int.MaxValue;
        int bestFitIndex = -1;
        for (int i = 0; i < bundlesWithVariant.Length; i++)
        {
            string[] curSplit = bundlesWithVariant[i].Split('.');
            if (curSplit[0] != split[0])
            {
                continue;
            }
            int found = System.Array.IndexOf(m_ActiveVariants, curSplit[1]);
            if (found == -1)
            {
                found = int.MaxValue - 1;
            }
            if (found < bestFit)
            {
                bestFit = found;
                bestFitIndex = i;
            }
        }

        if (bestFit == int.MaxValue - 1)
        {
            Debug.LogWarning("Ambigious asset bundle variant chosen because there was no matching active variant: " + bundlesWithVariant[bestFitIndex]);
        }

        if (bestFitIndex != -1)
        {
            return bundlesWithVariant[bestFitIndex];
        }
        else
        {
            return assetBundleName;
        }
    }

    #endregion

    #region

    private void Update()
    {
        for (int i = 0; i < m_InProgressOperations.Count;)
        {
            AssetBundleLoadOperation operation = m_InProgressOperations[i];
            if (operation.Update())
            {
                i++;
            }
            else
            {
                m_InProgressOperations.RemoveAt(i);
                ProcessFinishedOperation(operation);
            }
        }
    }

    private void ProcessFinishedOperation(AssetBundleLoadOperation operation)
    {
        AssetBundleDownloadOperation download = operation as AssetBundleDownloadOperation;
        if (download == null)
        {
            return;
        }
        if (download.error == null)
        {
            m_LoadedAssetBundles.Add(download.assetBundleName, download.assetBundle);
        }
        else
        {
            string msg = string.Format("Failed downloading bundle {0} from {1}", download.assetBundleName, download.error);
            m_DownloadingErrors.Add(download.assetBundleName, msg);
        }
        m_DownloadingBundles.Remove(download.assetBundleName);
    }

    private Action mLoadLevelCallback;
    private string m_currentLevel;

    private void LoadLevelEx(string assetBundleName, string levelName, Action callback)
    {
        this.mLoadLevelCallback = callback;
        StartCoroutine(StartLoadLevel(assetBundleName, levelName));
    }

    private IEnumerator StartLoadLevel(string assetBundleName, string levelName)
    {
        if (!string.IsNullOrEmpty(this.m_currentLevel))
        {
            AssetBundleManager.UnloadAssetBundle(this.m_currentLevel, true);
        }
        yield return new WaitForEndOfFrame();
#if DEBUG_ASSETBUNDLE
        Debug.Log("---------");
#endif
        SceneManager.LoadScene("empty");
        yield return new WaitForEndOfFrame();
#if DEBUG_ASSETBUNDLE
        Debug.Log("--- load level asy ---");
#endif
        AssetBundleLoadOperation level = AssetBundleManager.LoadLevelAsync(assetBundleName, levelName);
        yield return level;
        this.m_currentLevel = assetBundleName;
        if (this.mLoadLevelCallback != null)
        {
            this.mLoadLevelCallback();
            this.mLoadLevelCallback = null;
        }
    }

    #endregion
}
