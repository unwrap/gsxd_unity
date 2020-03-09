using System.IO;
using UnityEditor;
using UnityEngine;

public class ShaderPostProcessor : AssetPostprocessor
{
    static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
    {
        for (int index = 0; index < importedAssets.Length; index++)
        {
            string str = importedAssets[index];
            SetAssetName(str);
        }
    }

    private static void SetAssetName(string strPath)
    {
        if (strPath.Contains("Bootstrap-Skeleton"))
        {
            return;
        }
        if (strPath.Contains("Bootstrap-UI"))
        {
            return;
        }
        string ext = Path.GetExtension(strPath).ToLower();
        if (ext.EndsWith("shader") || ext.EndsWith("cginc"))
        {
            AssetImporter assetImporter = AssetImporter.GetAtPath(strPath);
            assetImporter.assetBundleName = "shader.u3d";
        }
    }
}
