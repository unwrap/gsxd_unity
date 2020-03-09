using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;

public class ExportSprites
{
    [MenuItem("Assets/Create/CreateSpriteScriptableObject", false, 1)]
    static void Export()
    {
        foreach (Object sprite in Selection.objects)
        {
            if (sprite is Sprite == false)
            {
                continue;
            }
            string strPath = AssetDatabase.GetAssetPath(sprite);
            strPath = Path.GetDirectoryName(strPath);
            SpriteScriptableObject sp = ScriptableObject.CreateInstance<SpriteScriptableObject>();
            sp.sprite = sprite as Sprite;
            AssetDatabase.CreateAsset(sp, strPath + "/" + sprite.name + ".asset");
        }
        AssetDatabase.SaveAssets();
    }
}