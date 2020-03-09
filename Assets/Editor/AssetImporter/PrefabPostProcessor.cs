using UnityEditor;
using UnityEngine;

public class PrefabPostProcessor : AssetPostprocessor
{
    private static string[] prefab_path = new string[]
    {
        "Assets/RawResources/UI",
        "Assets/RawResources/bootstrap",
        "Assets/RawResources/Scene/Prefab",
        "Assets/RawResources/Scene/Animation"
    };

    static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
    {
        for (int index = 0; index < importedAssets.Length; index++)
        {
            string assetPath = importedAssets[index];
            SetAssetName(assetPath);
        }
    }

    private static void SetAssetName(string strPath)
    {
        foreach (string path in prefab_path)
        {
            if (strPath.StartsWith(path))
            {
                if (strPath.EndsWith(".prefab"))
                {
                    Object obj = PrefabUtility.LoadPrefabContents(strPath);
                    ExportAssetBundle.SetAssetBundleNameByDirectory(strPath, obj);
                }
                else if(strPath.EndsWith(".asset"))
                {
                    Object obj = AssetDatabase.LoadAssetAtPath(strPath, typeof(ScriptableObject));
                    ExportAssetBundle.SetAssetBundleNameByDirectory(strPath, obj);
                }
                break;
            }
        }
    }
}
