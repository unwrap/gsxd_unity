using System.Collections.Generic;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

#if UNITY_EDITOR
using UnityEditor;
#endif

[SLua.CustomLuaClass]
public static class GameUtil
{
#if UNITY_EDITOR
    private static Stack<System.Diagnostics.Stopwatch> watches = new Stack<System.Diagnostics.Stopwatch>();
#endif

    public const string localDebugKey = "ozdebug_local";
    private static int m_debug = -1;
    public static bool isDebug
    {
        get
        {
            if (m_debug == -1)
            {
                m_debug = PlayerPrefs.GetInt(localDebugKey, 0);
            }
            return m_debug == 1;
        }
        set
        {
            m_debug = value ? 1 : 0;
            PlayerPrefs.SetInt(localDebugKey, m_debug);
        }
    }

    public static string assetbundleKey
    {
        get
        {
            return "nuomifans_gsxd";
        }
    }

    public static bool isWifi
    {
        get
        {
            if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork)
            {
                return true;
            }
            return false;
        }
    }

    public static bool isX86_X64
    {
        get
        {
            if (System.IntPtr.Size == 4)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }

    public static void BeginMarkTime()
    {
#if UNITY_EDITOR
        System.Diagnostics.Stopwatch stopwatch = new System.Diagnostics.Stopwatch();
        stopwatch.Start();
        watches.Push(stopwatch);
#endif
    }

    public static void EndMarkTime(string printMsg, float minPrintTime)
    {
#if UNITY_EDITOR
        if (watches.Count > 0)
        {
            System.Diagnostics.Stopwatch stopwatch = watches.Pop();
            stopwatch.Stop();
            double ms = stopwatch.Elapsed.TotalMilliseconds;
            if(ms >= minPrintTime)
            {
                UnityEngine.Debug.LogFormat("{0} time:{1}ms", printMsg, ms);
            }
        }
#endif
    }

    public static void RegisterCommand(System.Func<string[], object> commandCallback, string CMD_Discribes)
    {
    }

    public static void RegisterCommand(string commandString, System.Func<string[], object> commandCallback, string CMD_Discribes)
    {
    }

    private static Dictionary<string, Color[]> sp2Colors = new Dictionary<string, Color[]>();

    public static Color[] GetSpriteColors(Sprite sprite)
    {
        if (sp2Colors.ContainsKey(sprite.name))
        {
            return sp2Colors[sprite.name];
        }
        var rect = sprite.rect;
        var colors = sprite.texture.GetPixels((int)rect.x, (int)rect.y, (int)rect.width, (int)rect.height);
        sp2Colors[sprite.name] = colors;
        return colors;
    }

    public static void ClearSpriteColors()
    {
        if (sp2Colors != null)
        {
            sp2Colors.Clear();
        }
    }

    public static void CallOSFunction(string fn)
    {
    }

    public static void CallOSFunction(string fn, string args)
    {
    }

    public static int StringToHash(string str)
    {
        int hash = Animator.StringToHash(str);
        return hash;
    }

    public static string md5(string source)
    {
        MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
        byte[] data = System.Text.Encoding.UTF8.GetBytes(source);
        byte[] md5Data = md5.ComputeHash(data, 0, data.Length);
        md5.Clear();

        string destString = "";
        for (int i = 0; i < md5Data.Length; i++)
        {
            destString += System.Convert.ToString(md5Data[i], 16).PadLeft(2, '0');
        }
        destString = destString.PadLeft(32, '0');
        return destString.ToLower();
    }

    // Base64编码  
    public static string Base64Encode(string message)
    {
        byte[] bytes = Encoding.GetEncoding("utf-8").GetBytes(message);
        return System.Convert.ToBase64String(bytes);
    }

    // Base64解码  
    public static string Base64Decode(string message)
    {
        byte[] bytes = System.Convert.FromBase64String(message);
        return Encoding.GetEncoding("utf-8").GetString(bytes);
    }

    public static bool IsMobileInput
    {
        get
        {
#if ((UNITY_ANDROID || UNITY_IPHONE || UNITY_WP8 || UNITY_BLACKBERRY) && !UNITY_EDITOR)
            return true;
#else
            return false;
#endif
        }
    }

    public static bool IsIPhonePlayer
    {
        get
        {
#if UNITY_IOS || UNITY_IPHONE
            return true;
#else
            return false;
#endif
        }
    }

    public static bool IsEditor
    {
        get
        {
#if UNITY_EDITOR
            return true;
#else
            return false;
#endif
        }
    }

    public static bool Is3rdSDK
    {
        get
        {
            return false;
        }
    }

    public static string CurrentPlatform
    {
        get
        {
#if UNITY_EDITOR
            return EditorUserBuildSettings.activeBuildTarget.ToString();
#else
            return Application.platform.ToString();
#endif
        }
    }

    public static void RefreshShader(GameObject obj)
    {
#if UNITY_EDITOR
        if (obj == null)
        {
            return;
        }
        List<Renderer> meshes = new List<Renderer>(obj.GetComponentsInChildren<Renderer>(false));
        List<Material> mats = new List<Material>();
        for (int i = 0; i < meshes.Count; i++)
        {
            Material[] mat = meshes[i].sharedMaterials;
            if (mat == null)
            {
                mat = meshes[i].materials;
            }
            if (mat != null)
            {
                mats.AddRange(mat);
            }
        }
        for (int i = 0; i < mats.Count; i++)
        {
            Material mat = mats[i];
            if (mat != null)
            {
                string shaderName = mat.shader.name;
                Shader newShader = Shader.Find(shaderName);
                if (newShader != null)
                {
                    mat.shader = newShader;
                }
            }
        }
#endif
    }

    public static System.Type GetType(string className)
    {
        if (string.IsNullOrEmpty(className)) return null;

        System.Type t = null;
        Assembly[] assbs = System.AppDomain.CurrentDomain.GetAssemblies();
        Assembly assb = null;
        for (int i = 0; i < assbs.Length; i++)
        {
            assb = assbs[i];
            t = assb.GetType(className);
            if (t != null)
            {
                return t;
            }
        }
        return null;
    }

    public static Vector3 WorldToScreenPoint(Vector3 pos, Camera camera)
    {
        if (camera == null)
        {
            camera = Camera.main;
        }

        if (camera == null)
        {
            return Vector3.zero;
        }

        if (UIManager.Instance == null)
        {
            return Vector3.zero;
        }

        Camera uiCamera = UIManager.Instance.uiCamera;
        if (uiCamera == null)
        {
            return Vector3.zero;
        }
        Vector3 screenPoint = camera.WorldToScreenPoint(pos);
        return screenPoint;
    }

    public static Vector3 WorldToUIPoint(Vector3 pos, Camera camera)
    {
        if (camera == null)
        {
            camera = Camera.main;
        }

        if (camera == null)
        {
            return Vector3.zero;
        }

        if (UIManager.Instance == null)
        {
            return Vector3.zero;
        }

        Camera uiCamera = UIManager.Instance.uiCamera;
        if (uiCamera == null)
        {
            return Vector3.zero;
        }
        Vector3 screenPoint = camera.WorldToScreenPoint(pos);
        Vector3 worldPoint = uiCamera.ScreenToWorldPoint(screenPoint);
        worldPoint.z = 0.0f;
        return worldPoint;

        /*
        CanvasScaler scaler = UIManager.Instance.GetComponent<CanvasScaler>();
        float resolutionX = scaler.referenceResolution.x;
        float resolutionY = scaler.referenceResolution.y;
        Vector3 viewportPos = camera.WorldToViewportPoint(pos);
        Vector3 uiPos = new Vector3(viewportPos.x * resolutionX - resolutionX * 0.5f, viewportPos.y * resolutionY - resolutionY * 0.5f, 0);

        return uiPos;
        */
    }

    public static Vector3 ScreenToUIPoint(Vector3 pos, Camera camera)
    {
        if (camera == null)
        {
            camera = Camera.main;
        }

        if (camera == null)
        {
            return Vector3.zero;
        }

        if (UIManager.Instance == null)
        {
            return Vector3.zero;
        }

        Canvas canvas = UIManager.Instance.canvas;
        Vector2 uiPos;
        RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, pos, canvas.worldCamera, out uiPos);

        /*
        CanvasScaler scaler = UIManager.Instance.GetComponent<CanvasScaler>();
        float resolutionX = scaler.referenceResolution.x;
        float resolutionY = scaler.referenceResolution.y;
        Vector3 viewportPos = camera.ScreenToViewportPoint(pos);
        Vector3 uiPos = new Vector3(viewportPos.x * resolutionX - resolutionX * 0.5f, viewportPos.y * resolutionY - resolutionY * 0.5f, 0);
        */
        return uiPos;
    }

    private static RaycastHit[] m_hitResults = new RaycastHit[10];
    public static RaycastHit[] Raycast(Vector3 origin, Vector3 direction, float maxDistance)
    {
        return GameUtil.Raycast(origin, direction, maxDistance, 0);
    }

    public static RaycastHit[] Raycast(Vector3 origin, Vector3 direction, float maxDistance, int layerMask)
    {
        System.Array.Clear(m_hitResults, 0, m_hitResults.Length);
        int ret = Physics.RaycastNonAlloc(origin, direction, m_hitResults, maxDistance, layerMask);
        return m_hitResults;
    }

    public static RaycastHit[] BoxCastAll(Vector3 center, Vector3 halfExtents, Vector3 direction, Quaternion orientation, float maxDistance, int layerMask)
    {
        System.Array.Clear(m_hitResults, 0, m_hitResults.Length);
        int ret = Physics.BoxCastNonAlloc(center, halfExtents, direction, m_hitResults, orientation, maxDistance, layerMask);
        return m_hitResults;
    }

    public static RaycastHit[] SphereCastAll(Vector3 origin, float radius, Vector3 direction, float maxDistance, int layerMask)
    {
        System.Array.Clear(m_hitResults, 0, m_hitResults.Length);
        int ret = Physics.SphereCastNonAlloc(origin, radius, direction, m_hitResults, maxDistance, layerMask);
        return m_hitResults;
    }

    public static RaycastHit[] CapsuleCastAll(Vector3 point1, Vector3 point2, float radius, Vector3 direction, float maxDistance, int layerMask)
    {
        System.Array.Clear(m_hitResults, 0, m_hitResults.Length);
        int ret = Physics.CapsuleCastNonAlloc(point1, point2, radius, direction, m_hitResults, maxDistance, layerMask);
        return m_hitResults;
    }

    #region GameObject
    public static void Destroy(Object original)
    {
        GameObject.Destroy(original);
    }

    public static void Destroy(Object original, float t)
    {
        GameObject.Destroy(original, t);
    }

    public static void DestroyImmediate(Object original)
    {
        GameObject.DestroyImmediate(original);
    }

    public static void DestroyImmediate(Object original, bool allowDestroyingAssets)
    {
        GameObject.DestroyImmediate(original, allowDestroyingAssets);
    }

    public static Object Instantiate(Object original)
    {
        if (original == null)
        {
            return null;
        }
        Object clone = GameObject.Instantiate(original);
#if UNITY_EDITOR
        if (clone is GameObject)
        {
            GameUtil.RefreshShader(clone as GameObject);
        }
#endif
        return clone;
    }

    public static int DefaultLayer = 0;
    public static int UILayer = LayerMask.NameToLayer("UI");
    public static int PlayerLayer = LayerMask.NameToLayer("Player");
    public static int MapLayer = LayerMask.NameToLayer("Map");
    public static int GoodsLayer = LayerMask.NameToLayer("Goods");
    public static int BulletLayer = LayerMask.NameToLayer("Bullet");
    public static int HideLayer = LayerMask.NameToLayer("Hide");
    public static int MapOutWallLayer = LayerMask.NameToLayer("MapOutWall");
    public static int ObstructLayer = LayerMask.NameToLayer("Obstruct");

    public static void SetLayer(Transform transform, int layer)
    {
        transform.gameObject.layer = layer;
        int c = transform.childCount;
        for (int i = 0; i < c; i++)
        {
            var child = transform.GetChild(i);
            SetLayer(child, layer);
        }
    }

    public static int InvertLayer(int layer)
    {
        return ~layer;
    }

    public static int CullingLayer(int layer)
    {
        return (1 << layer);
    }

    public static int CullingLayer(int layer1, int layer2)
    {
        return (1 << layer1) | (1 << layer2);
    }

    public static int CullingLayer(int layer1, int layer2, int layer3)
    {
        return (1 << layer1) | (1 << layer2) | (1 << layer3);
    }


    public static int CullingLayer(int layer1, int layer2, int layer3, int layer4)
    {
        return (1 << layer1) | (1 << layer2) | (1 << layer3) | (1 << layer4);
    }

    public static void CullingMask(Camera cam, int layer)
    {
        cam.cullingMask = 1 << layer;
    }

    public static void CullingMask(Camera cam, int layer1, int layer2)
    {
        cam.cullingMask = (1 << layer1) | (1 << layer2);
    }

    #endregion

    #region Component

    public static Transform FindChild(this Transform tf, string name)
    {
        return tf.Find(name);
    }

    public static Component FindInParents(GameObject go, System.Type t)
    {
        if (go == null)
        {
            return null;
        }
        Component comp = go.GetComponent(t);
        if (comp != null)
        {
            return comp;
        }
        Transform tf = go.transform.parent;
        while (tf != null && comp == null)
        {
            comp = tf.gameObject.GetComponent(t);
            tf = tf.parent;
        }
        return comp;
    }

    public static Component GetComponent(GameObject obj, string classname)
    {
        System.Type t = GetType(classname);
        return GetComponent(obj, t);
    }

    public static Component GetComponent(GameObject obj, System.Type t)
    {
        if (obj == null)
        {
            return null;
        }
        Component comp = null;
        if (obj != null && t != null) comp = obj.GetComponent(t);
        return comp;
    }

    public static Component[] GetComponents(GameObject obj, System.Type t)
    {
        if(obj == null || t == null)
        {
            return null;
        }
        return obj.GetComponents(t); 
    }

    public static Component AddComponent(GameObject obj, string className)
    {
        System.Type t = GetType(className);
        return AddComponent(obj, t);
    }

    public static Component AddComponent(GameObject obj, System.Type t)
    {
        if (obj == null)
        {
            return null;
        }
        Component comp = null;
        comp = GetComponent(obj, t);
        if (comp == null) comp = obj.AddComponent(t);

        return comp;
    }

    public static void RemoveComponent(GameObject obj, string className)
    {
        if (obj == null)
        {
            return;
        }
        Component comp = GetComponent(obj, className);
        if (comp != null) RemoveComponent(comp);
    }

    public static void RemoveComponent(Component comp)
    {
        Destroy(comp);
    }

    public static Bounds GetBounds(Transform transform)
    {
        MeshFilter meshFilter = transform.gameObject.GetComponent<MeshFilter>();
        if (meshFilter == null)
        {
            return new Bounds(Vector3.zero, Vector3.zero);
        }

        Mesh mesh = meshFilter.sharedMesh;
        if (mesh == null)
        {
            return new Bounds(Vector3.zero, Vector3.zero);
        }

        Bounds meshBounds = mesh.bounds;
        return meshBounds;
    }

    public static float GetClipLength(this Animator animator, string clip)
    {
        if(null == animator || string.IsNullOrEmpty(clip) || null == animator.runtimeAnimatorController)
        {
            return 0;
        }
        RuntimeAnimatorController ac = animator.runtimeAnimatorController;
        AnimationClip[] clips = ac.animationClips;
        if(null == clips || clips.Length <= 0)
        {
            return 0;
        }
        for(int i = 0; i < clips.Length; i++)
        {
            AnimationClip c = clips[i];
            if(null != c && c.name == clip)
            {
                return c.length;
            }
        }
        return 0;
    }

    #endregion
}
