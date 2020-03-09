using System.IO;
using UnityEditor;
using UnityEngine;

public class EditorFolder
{
    public static void CreateLuaFile()
    {
        Object obj = Selection.activeObject;
        if (obj == null)
        {
            return;
        }
        string path = AssetDatabase.GetAssetPath(obj);
        if (!Directory.Exists(path))
        {
            return;
        }

        string rootPath = Directory.GetCurrentDirectory();
        string fullPath = Path.GetFullPath( Path.Combine(rootPath, path) );

        string filePath = EditorUtility.SaveFilePanelInProject("title", "moban", "lua", "message", fullPath);
        if(string.IsNullOrEmpty(filePath))
        {
            return;
        }
        fullPath = Path.GetFullPath(Path.Combine(rootPath, filePath));
        if(File.Exists(fullPath))
        {
            EditorUtility.DisplayDialog("提示", filePath + "已经存在", "确定");
            return;
        }

        string fileName = Path.GetFileNameWithoutExtension(filePath);
        string luaFileName = Path.Combine(path, fileName).Replace("Assets/Lua/", "");
        luaFileName = luaFileName.Replace("/", ".").Replace(@"\", ".");

        string strText = @"
---------------------------------------------------------------------------------------------------
--
--filename: %luaFileName%
--date:%date%
--author:
--desc:
--
---------------------------------------------------------------------------------------------------
local strClassName = '%luaFileName%'
local %$(Class)% = lua_declare(strClassName, lua_class(strClassName))

function %$(Class)%:ctor()

end

function %$(Class)%:Start()

end

return %$(Class)%
";
        strText = strText.Replace("%luaFileName%", luaFileName);
        strText = strText.Replace("%$(Class)%", fileName);
        strText = strText.Replace("%date%", System.DateTime.Now.ToString());
        StreamWriter kWriter = new StreamWriter(fullPath, false, new System.Text.UTF8Encoding(false));
        kWriter.Write(strText);
        kWriter.Close();

        AssetDatabase.Refresh();
    }

    public static void CreateFolder()
    {
        Object obj = Selection.activeObject;
        if (obj == null)
        {
            return;
        }
        string path = AssetDatabase.GetAssetPath(obj);
        if (!Directory.Exists(path))
        {
            return;
        }
        string[] folders = new string[] { "Materials", "Models", "Prefabs", "Shaders", "Textures" };
        foreach (string f in folders)
        {
            if (!Directory.Exists(Path.Combine(path, f)))
            {
                AssetDatabase.CreateFolder(path, f);
            }
        }
    }
}
