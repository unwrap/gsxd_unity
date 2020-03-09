using UnityEngine;
using System.Collections;
using UnityEditor;

public class LocalizationPostProcessor : AssetPostprocessor
{
    static void OnPostprocessAllAssets(string[] importedAssets, string[] deletedAssets, string[] movedAssets, string[] movedFromAssetPaths)
    {
        for (int index = 0; index < importedAssets.Length; index++)
        {
            string str = importedAssets[index];
            //Debug.Log("str: " + str);
            if (str.EndsWith(".lua") && str.Contains("localization"))
            {
                Debug.Log("LocalizationImporter.Refresh");
                LocalizationImporter.Refresh();
            }
        }
    }
}
