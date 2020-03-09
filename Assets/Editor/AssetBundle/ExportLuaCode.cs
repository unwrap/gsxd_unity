using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class ExportLuaCode
{
    private static byte[] key = new byte[] { 35, 253, 201, 27, 47, 201, 73, 200, 184, 238, 134, 232, 150, 246, 225, 163, 92, 88, 173, 164, 53, 156, 66, 211, 123, 252, 215, 45, 70, 175, 182, 171 };
    private static byte[] iv = new byte[] { 167, 135, 128, 185, 148, 77, 217, 28, 216, 113, 41, 64, 3, 133, 117, 191 };

    //[MenuItem("Custom/lua/解析lua", false, 1)]
    public static void LoadLua()
    {
        string saveFolderPath = EditorUtility.SaveFolderPanel("导出", null, "Assets");
        if (string.IsNullOrEmpty(saveFolderPath))
        {
            return;
        }
        Debug.Log(saveFolderPath);

        string strOutputPath = Path.Combine(Application.streamingAssetsPath, PathUtil.Platform);
        string luaExportPath = Path.GetFullPath(Path.Combine(strOutputPath, "lua_core.u3d"));
        byte[] bytes = File.ReadAllBytes(luaExportPath);
        
        byte[] byts = CryptographHelper.Decrypt(bytes, key, iv);

#if UNITY_5_3
        AssetBundle item = AssetBundle.LoadFromMemory(byts);
#else
        AssetBundle item = AssetBundle.LoadFromMemory(byts);
#endif

        string keyName = "";
        TextAsset[] all = item.LoadAllAssets<TextAsset>();
        foreach (TextAsset ass in all)
        {
            keyName = ass.name;
            string absFilePath = keyName.Replace("%", "/");
            int last = absFilePath.LastIndexOf("/");
            string cut0 = absFilePath.Substring(0, last);
            string cut1 = absFilePath.Substring(last, absFilePath.Length - last).Replace("/", ".");
            string newFilePath = cut0 + cut1;
            string fullPath = Path.Combine(saveFolderPath, newFilePath);
            FileInfo fi = new FileInfo(fullPath);
            if (!fi.Directory.Exists)
            {
                fi.Directory.Create();
            }
            using (StreamWriter kWriter = new StreamWriter(fullPath, false, new System.Text.UTF8Encoding(false)))
            {
                kWriter.Write(ass.text);
                kWriter.Close();
            }
        }

        item.Unload(true);
    }

    //[MenuItem("Custom/AssetBundle/导出lua", false, 1)]
    public static void ExportLua()
    {
        ExportLuaEx(Application.dataPath);
    }

    //[MenuItem("Custom/lua/导出指定目录lua", false, 1)]
    public static void ExportSelectedLua()
    {
        string saveFolderPath = EditorUtility.OpenFolderPanel("导出", null, "Assets");
        if (string.IsNullOrEmpty(saveFolderPath))
        {
            return;
        }
        Debug.Log(saveFolderPath);
        ExportLuaEx(Path.GetFullPath(saveFolderPath));
    }

    public static void ExportLuaEx(string dirPath)
    {
        string tmpPath = Path.GetFullPath(Path.Combine(Application.dataPath, "tmp"));
        DirectoryDelete(tmpPath);
        CheckDirectory(tmpPath);

        string[] include = new string[] { ".lua", ".cs", ".txt", ".shader", ".py" };
        List<string> exportNames = new List<string>();
        string[] fileList = Directory.GetFiles(dirPath, "*.*", SearchOption.AllDirectories);
        for (int i = 0; i < fileList.Length; i++)
        {
            string fileName = fileList[i];
            string ext = Path.GetExtension(fileName);
            if (Array.IndexOf<string>(include, ext) != -1)
            {
                string byteFileName = fileName.Replace(dirPath, "");
                if (byteFileName.StartsWith("\\"))
                {
                    byteFileName = byteFileName.Substring(1);
                }
                byteFileName = byteFileName.Replace("\\", "%").Replace("/", "%").Replace(".", "%");
                byteFileName += ".bytes";
                exportNames.Add("Assets/tmp/" + byteFileName);
                File.Copy(Path.GetFullPath(fileName), Path.Combine(tmpPath, byteFileName), true);
            }
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

        ExportAssetBundle.BuildAssetBundles(exportNames.ToArray(), "Assets/tmp", "luaout.bytes", BuildAssetBundleOptions.DeterministicAssetBundle);

        string strOutputPath = Path.Combine(Application.streamingAssetsPath, PathUtil.Platform);
        CheckDirectory(strOutputPath);

        string luaoutPath = Path.Combine(Application.dataPath, "tmp/luaout.bytes");

        string luaExportPath = Path.GetFullPath(Path.Combine(strOutputPath, "lua_core.u3d"));
        byte[] by = File.ReadAllBytes(luaoutPath);
        byte[] encrypt = CryptographHelper.Encrypt(by, key, iv);
        File.WriteAllBytes(luaExportPath, encrypt);

        DirectoryDelete(tmpPath);

        Debug.Log(luaExportPath + " export.");

        System.Threading.Thread.Sleep(100);
        AssetDatabase.Refresh();
    }

    private static void CheckDirectory(string path)
    {
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }
    }

    private static void DirectoryDelete(string path)
    {
        DirectoryInfo dir = new DirectoryInfo(path);
        if (dir.Exists)
        {
            dir.Delete(true);
        }
    }
}
