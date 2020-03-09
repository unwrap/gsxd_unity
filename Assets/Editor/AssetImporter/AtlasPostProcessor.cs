using System.IO;
using UnityEditor;
using UnityEngine;

public class AtlasPostProcessor : AssetPostprocessor
{
    private static string[] ui_atlas_path = new string[] {
        "Assets/RawResources/Atlas/AtlasCommon",
        "Assets/RawResources/Atlas/AtlasItem",
    };

    private static string scene_atlas_path = "Assets/RawResources/Scene/Texture";

    private void OnPostprocessTexture(Texture2D texture)
    {
        foreach (string path in ui_atlas_path)
        {
            if (!Directory.Exists(path))
            {
                continue;
            }
            if (assetPath.StartsWith(path))
            {
                string atlasName = new DirectoryInfo(Path.GetFileName(path)).Name.ToLower();
                TextureImporter textureImporter = assetImporter as TextureImporter;
                textureImporter.textureType = TextureImporterType.Sprite;
                if (assetPath.Contains("rgba32"))
                {
                    textureImporter.spritePackingTag = atlasName + "ex";
                }
                else
                {
                    textureImporter.spritePackingTag = atlasName;
                }
                textureImporter.mipmapEnabled = false;
                textureImporter.assetBundleName = atlasName + ".u3d";

                TextureImporterSettings tis = new TextureImporterSettings();
                textureImporter.ReadTextureSettings(tis);
                tis.ApplyTextureType(TextureImporterType.Sprite);
                textureImporter.SetTextureSettings(tis);
                break;
            }
        }

        if(assetPath.StartsWith(scene_atlas_path))
        {
            string fileName = Path.GetFileNameWithoutExtension(assetPath).ToLower();
            TextureImporter textureImporter = assetImporter as TextureImporter;
            textureImporter.assetBundleName = "scene/" + fileName + ".u3d";
        }

    }
}
