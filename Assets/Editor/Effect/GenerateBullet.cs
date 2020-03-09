using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class GenerateBullet
{
    public static void DeleteBullet()
    {
        GameObject selectedObj = Selection.activeObject as GameObject;
        if (selectedObj == null)
        {
            return;
        }
        string assetPath = AssetDatabase.GetAssetPath(selectedObj);
        Object[] roots = new Object[] { selectedObj };
        Object[] objs = EditorUtility.CollectDependencies(roots);
        List<string> assetPaths = new List<string>();
        foreach (Object obj in objs)
        {
            string path = AssetDatabase.GetAssetPath(obj);
            if (!assetPaths.Contains(path) && path != assetPath)
            {
                assetPaths.Add(path);
            }
        }

        List<string> deleteList = new List<string>() { assetPath };

        Dictionary<string, List<string>> referenceCache = new Dictionary<string, List<string>>();
        foreach (string depPath in assetPaths)
        {
            if (depPath.EndsWith(".cs"))
            {
                continue;
            }
            Object obj = AssetDatabase.LoadAssetAtPath(depPath, typeof(Object));
            if (obj == null)
            {
                continue;
            }
            List<string> refs = FindReferencesInProject.FindObjectReference(obj);
            referenceCache[depPath] = refs;
        }

        foreach(string depPath in assetPaths)
        {
            bool needDel = true;
            CheckOnlyOnePath(depPath, assetPath, referenceCache, ref needDel);
            if(needDel)
            {
                deleteList.Add(depPath);
            }
        }

        foreach (string deletePath in deleteList)
        {
            Debug.Log("delete:" + deletePath);
            AssetDatabase.DeleteAsset(deletePath);
        }
    }

    private static void CheckOnlyOnePath(string currentAsset, string targetAsset, Dictionary<string, List<string>> referenceCache, ref bool needDel)
    {
        if (referenceCache.ContainsKey(currentAsset))
        {
            List<string> refs = referenceCache[currentAsset];
            foreach(string r in refs)
            {
                if(r != targetAsset)
                {
                    CheckOnlyOnePath(r, targetAsset, referenceCache, ref needDel);
                }
            }
        }
        else
        {
            needDel = false;
        }
    }

    public static bool CheckDelBullet()
    {
        Object selectedObj = Selection.activeObject;
        if (selectedObj != null && selectedObj.GetType() == typeof(GameObject))
        {
            string path = AssetDatabase.GetAssetPath(selectedObj);
            if (path.StartsWith("Assets/RawResources/Scene/Prefab/Bullet"))
            {
                return true;
            }
        }
        return false;
    }

    public static void GenBullet()
    {
        if (!GenerateBullet.CheckObjectType())
        {
            return;
        }
        GameObject selectedObj = Selection.activeObject as GameObject;
        if (selectedObj == null)
        {
            return;
        }
        GameObject bullet = new GameObject(selectedObj.name);
        bullet.transform.position = Vector3.zero;

        GameObject obj = GameObject.Instantiate<GameObject>(selectedObj);
        obj.name = "mesh";
        obj.transform.SetParent(bullet.transform);
        obj.transform.localPosition = Vector3.zero;

        EffectController effectCtrl = bullet.AddMissingComponent<EffectController>();
        effectCtrl.autoRemove = false;

        PrefabUtility.SaveAsPrefabAssetAndConnect(bullet, "Assets/RawResources/Scene/Prefab/Bullet/" + selectedObj.name + ".prefab", InteractionMode.AutomatedAction);

        GameObject.DestroyImmediate(bullet);
    }

    public static bool CheckObjectType()
    {
        Object selectedObj = Selection.activeObject;
        if (selectedObj != null && selectedObj.GetType() == typeof(GameObject))
        {
            string path = AssetDatabase.GetAssetPath(selectedObj);
            if (path.StartsWith("Assets/RawResources/Effect/Epic Toon FX"))
            {
                return true;
            }
            if(path.StartsWith("Assets/RawResources/Scene/FBX"))
            {
                return true;
            }
        }
        return false;
    }

    private static string[] filterFolders = new string[]
    {
        "Assets/Config",
        "Assets/Editor",
        "Assets/Lua",
        "Assets/Plugins",
        "Assets/RawResources",
        "Assets/Resources",
        "Assets/Scene",
        "Assets/Script",
        "Assets/Shaders"
    };

    public static void GenBulletBatch()
    {
        if (!GenerateBullet.CheckCanGenBulletBatch())
        {
            return;
        }
        string[] strs = Selection.assetGUIDs;
        string topPath = AssetDatabase.GUIDToAssetPath(strs[0]);

        string[] findFolder = new string[] { topPath };

        string[] models = AssetDatabase.FindAssets("t:Model", findFolder);
        foreach (string guid in models)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            string newPath = "Assets/RawResources/Scene/FBX/Bullet/" + Path.GetFileName(assetPath);
            AssetDatabase.MoveAsset(assetPath, newPath);
        }

        string[] materials = AssetDatabase.FindAssets("t:Material", findFolder);
        foreach (string guid in materials)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            string newPath = "Assets/RawResources/Scene/Material/Bullet/" + Path.GetFileName(assetPath);
            AssetDatabase.MoveAsset(assetPath, newPath);
        }

        string[] textures = AssetDatabase.FindAssets("t:Texture", findFolder);
        foreach (string guid in textures)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            string newPath = "Assets/RawResources/Scene/Texture/Bullet/" + Path.GetFileName(assetPath);
            AssetDatabase.MoveAsset(assetPath, newPath);
        }

        string[] shaders = AssetDatabase.FindAssets("t:Shader", findFolder);
        foreach (string guid in shaders)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            string newPath = "Assets/Shaders/" + Path.GetFileName(assetPath);
            AssetDatabase.MoveAsset(assetPath, newPath);
        }

        string[] prefabs = AssetDatabase.FindAssets("t:Prefab", findFolder);
        foreach (string guid in prefabs)
        {
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            GameObject prefabObj = AssetDatabase.LoadAssetAtPath<GameObject>(assetPath);

            GameObject bullet = new GameObject(prefabObj.name);
            bullet.transform.position = Vector3.zero;

            GameObject obj = GameObject.Instantiate<GameObject>(prefabObj);
            obj.name = "mesh";
            obj.transform.SetParent(bullet.transform);
            obj.transform.localPosition = Vector3.zero;

            EffectController effectCtrl = bullet.AddMissingComponent<EffectController>();
            effectCtrl.autoRemove = false;

            PrefabUtility.SaveAsPrefabAssetAndConnect(bullet, "Assets/RawResources/Scene/Prefab/Bullet/" + prefabObj.name + ".prefab", InteractionMode.AutomatedAction);

            GameObject.DestroyImmediate(bullet);

            AssetDatabase.DeleteAsset(assetPath);
        }
    }

    public static bool CheckCanGenBulletBatch()
    {
        string[] strs = Selection.assetGUIDs;
        if(strs.Length <= 0)
        {
            return false;
        }
        string assetPath = AssetDatabase.GUIDToAssetPath(strs[0]);
        if (!Directory.Exists(assetPath))
        {
            return false;
        }
        foreach (string dir in filterFolders)
        {
            if (dir == assetPath)
            {
                return false;
            }
        }
        return true;
    }
}
