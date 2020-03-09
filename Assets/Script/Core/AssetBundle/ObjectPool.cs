using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[SLua.CustomLuaClass]
public sealed class ObjectPool:MonoBehaviour
{
    #region instance

    private static ObjectPool m_instance;

    public static ObjectPool Instance
    {
        get
        {
            if ( m_instance != null )
            {
                return m_instance;
            }
            m_instance = Object.FindObjectOfType<ObjectPool>();
            if( m_instance != null )
            {
                return m_instance;
            }
            GameObject obj = new GameObject("ObjectPool");
            obj.transform.position = new Vector3(1000, 1000);
            obj.transform.localRotation = Quaternion.identity;
            obj.transform.localScale = Vector3.one;
            m_instance = obj.AddComponent<ObjectPool>();
            applicationIsQuitting = false;
            obj.layer = GameUtil.HideLayer;
            return m_instance;
        }
    }

    private static bool applicationIsQuitting = false;

    private static int MaxCount = 16;
    // public int RefCount = 0;
    // public int RecyleCount = 0;

    public void OnDestroy()
    {
        // RefCount = 0;
        // RecyleCount = 0;
        // UnityEngine.Debug.Log(string.Format("ObjectPool.OnDestroy, referened count: {0}, pool count {1}", RefCount, RecyleCount));
        applicationIsQuitting = true;
        m_instance = null;
    }

    public static bool IsValid()
    {
        return !applicationIsQuitting;
    }

    #endregion

    private SortedList<int, List<GameObject>> objPool = new SortedList<int, List<GameObject>>();

    private static int emptyGameObjectKey = GameUtil.StringToHash("objectpool_empty");

    public static GameObject Spawn()
    {
        GameObject obj = null;
        Transform trans;
        if (!Instance.objPool.ContainsKey(emptyGameObjectKey))
        {
            Instance.objPool[emptyGameObjectKey] = new List<GameObject>();
        }
        List<GameObject> objs = Instance.objPool[emptyGameObjectKey];
        PoolController poolCtl;
        // ++m_instance.RefCount;
        // UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn, referened count: {0}, pool count {1}", m_instance.RefCount, m_instance.RecyleCount));
        if (objs.Count > 0)
        {
            do
            {
                obj = objs[0];
                objs.RemoveAt(0);

            } while (obj == null && objs.Count > 0);

            if (obj != null)
            {
                poolCtl = obj.AddMissingComponent<PoolController>();
                trans = obj.transform;
                trans.SetParent(null);
                trans.localPosition = Vector3.zero;
                trans.localRotation = Quaternion.identity;
                trans.localScale = Vector3.one;
                //obj.SetActive(true);
                GameUtil.SetLayer(trans, poolCtl.layer);
                return obj;
            }
        }

        obj = new GameObject();
        trans = obj.transform;
        trans.localPosition = Vector3.zero;
        trans.localRotation = Quaternion.identity;
        trans.localScale = Vector3.one;

        poolCtl = obj.AddMissingComponent<PoolController>();
        poolCtl.key = emptyGameObjectKey;

        return obj;
    }

    public static GameObject Spawn(string assetBundleName, string assetName)
    {
        int key = GameUtil.StringToHash(string.Concat(assetBundleName, "_", assetName));

        GameObject obj = null;
        Transform trans;
        if( !Instance.objPool.ContainsKey(key))
        {
            Instance.objPool[key] = new List<GameObject>();
        }

        List <GameObject> objs = Instance.objPool[key];
        PoolController poolCtl;
        // ++m_instance.RefCount;
        // UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn({0},{1}), referened count: {2}, pool count {3}", assetBundleName, assetName, m_instance.RefCount, objs.Count));
        if ( objs.Count > 0 )
        {
            do
            {
                obj = objs[0];
                objs.RemoveAt(0);

            } while (obj == null && objs.Count > 0);

            if ( obj != null )
            {
                // UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn({0},{1}), init obj which from pool", assetBundleName, assetName));

                trans = obj.transform;
                trans.SetParent(null);
                trans.localPosition = Vector3.zero;
                trans.localRotation = Quaternion.identity;
                trans.localScale = Vector3.one;
                //obj.SetActive(true);
                poolCtl = obj.AddMissingComponent<PoolController>();
                GameUtil.SetLayer(trans, poolCtl.layer);

                // UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn({0},{1}), init obj finished", assetBundleName, assetName));

                return obj;
            }
        }

        //UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn({0},{1}), start instantiate game object", assetBundleName, assetName));

        obj = AssetBundleManager.InstantiateGameObject(assetBundleName, assetName);
        if( obj == null )
        {
            return null;
        }
        trans = obj.transform;
        trans.localPosition = Vector3.zero;
        trans.localRotation = Quaternion.identity;
        trans.localScale = Vector3.one;

        poolCtl = obj.AddMissingComponent<PoolController>();
        poolCtl.key = key;
        //poolCtl.assetBundleName = assetBundleName;
        //poolCtl.assetName = assetName;

        //UnityEngine.Debug.Log(string.Format("ObjectPool.Spawn({0},{1}), instantiate game object finishged", assetBundleName, assetName));

        return obj;
    }

    public static void Recycle(GameObject obj)
    {
        if (obj == null)
        {
            return;
        }

        int poolcount = 0;
        //string assetBundleName = string.Empty;
        //string assetName = string.Empty;
        bool dontDestroy = false;
        do
        {
            if (!IsValid())
                break;

            PoolController poolCtl = obj.GetComponent<PoolController>();
            if (poolCtl == null)
                break;

            // ++Instance.RecyleCount;

            //assetBundleName = poolCtl.assetBundleName;
            //assetName = poolCtl.assetName;

            int key = poolCtl.key;
            List<GameObject> objs = null;
            if (!Instance.objPool.TryGetValue(key, out objs))
                break;

            poolcount = objs.Count;
            if (objs.Count >= MaxCount)
                break;

            dontDestroy = true;
            objs.Add(obj);
            obj.transform.SetParent(Instance.transform);
            obj.transform.localPosition = Vector3.zero;
            //obj.SetActive(false);
            poolCtl.layer = obj.layer;
            GameUtil.SetLayer(obj.transform, GameUtil.HideLayer);

            poolcount = objs.Count;

        } while (false);

        if (!dontDestroy)
            GameUtil.Destroy(obj);

        //if (string.IsNullOrEmpty(assetBundleName))
        //    UnityEngine.Debug.Log(string.Format("ObjectPool.Recycle, referened count: {0}, pool count {1}", m_instance ? m_instance.RefCount : 0, poolcount));
        //else
        //    UnityEngine.Debug.Log(string.Format("ObjectPool.Recycle({0}, {1}), referened count: {2}, pool count {3}", assetBundleName, assetName, m_instance ? m_instance.RefCount : 0, poolcount));
    }

    public static void DestroyAll()
    {
        foreach(KeyValuePair<int, List<GameObject>> keyValue in Instance.objPool)
        {
            foreach( GameObject obj in keyValue.Value )
            {
                GameUtil.Destroy(obj);
            }
        }
        Instance.objPool.Clear();
    }

    public static void SetPoolMaxCount(int n)
    {
        if (n > 0)
            MaxCount = n;
    }

}

public class PoolController : MonoBehaviour
{
    public int key;
    public int layer = 0;
    // public string assetBundleName;
    // public string assetName;
}
