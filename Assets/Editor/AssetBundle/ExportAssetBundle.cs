using SLua;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

public class ExportAssetBundle
{
    public const BuildAssetBundleOptions optionsDefault = BuildAssetBundleOptions.DeterministicAssetBundle | BuildAssetBundleOptions.DisableWriteTypeTree | BuildAssetBundleOptions.ChunkBasedCompression;

    #region 加密
    public static void GenerateKey()
    {
        CheckDirectory(Path.Combine(Application.dataPath, "Config"));
        using (System.Security.Cryptography.RijndaelManaged myRijndael = new System.Security.Cryptography.RijndaelManaged())
        {
            myRijndael.GenerateKey();
            byte[] key = myRijndael.Key;
            byte[] IV = myRijndael.IV;

            KeyVData keyScri = ScriptableObject.CreateInstance<KeyVData>();
            keyScri.KEY = key;
            keyScri.IV = IV;
            AssetDatabase.CreateAsset(keyScri, "Assets/Resources/des.asset");

            Debug.Log("key Generate " + key.Length);
        }
    }

    public static void DecryptAssetBundle()
    {
        string path = Path.GetFullPath(Path.Combine(Application.dataPath, "StreamingAssets"));
        List<string> files = getAllChildFiles(path, "u3d");

        for (int i = 0; i < files.Count; i++)
        {
            string filePath = files[i];
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".u3d"))
            {
                continue;
            }
            if (file.EndsWith("lua.u3d"))
            {
                continue;
            }

            EditorUtility.DisplayProgressBar("解密", filePath, (float)i / (float)files.Count);

            byte[] fileData = File.ReadAllBytes(file);
            byte[] encryptedData = Xxtea.XXTEA.Decrypt(fileData, GameUtil.assetbundleKey);
            using (FileStream fs = new FileStream(file, FileMode.Create))
            {
                fs.Write(encryptedData, 0, encryptedData.Length);
                fs.Close();
            }
        }

        EditorUtility.ClearProgressBar();
    }

    public static void EncryptAssetBundle()
    {
        string path = Path.GetFullPath(Path.Combine(Application.dataPath, "StreamingAssets"));
        List<string> files = getAllChildFiles(path, "u3d");

        for (int i = 0; i < files.Count; i++)
        {
            string filePath = files[i];
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".u3d"))
            {
                continue;
            }
            if (file.EndsWith("lua.u3d"))
            {
                continue;
            }

            EditorUtility.DisplayProgressBar("加密", filePath, (float)i / (float)files.Count);

            byte[] fileData = File.ReadAllBytes(file);
            byte[] encryptedData = Xxtea.XXTEA.Encrypt(fileData, GameUtil.assetbundleKey);
            using (FileStream fs = new FileStream(file, FileMode.Create))
            {
                fs.Write(encryptedData, 0, encryptedData.Length);
                fs.Close();
            }
        }

        EditorUtility.ClearProgressBar();
    }

    #endregion

    #region 发版

    private static string VersionTxtName(string ver)
    {
        return "version_" + ver + ".txt";
    }

    public static void GenerateVersion()
    {
        string strFilePath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
        string outFolderPath = Path.GetFullPath(string.Concat(Application.dataPath, "/Update/", PathUtil.Platform));
        if (Directory.Exists(outFolderPath) == false)
        {
            Directory.CreateDirectory(outFolderPath);
        }
        Debug.Log("版本号文件名称：" + ExportAssetBundle.VersionTxtName(CurrentBundleVersion.versionCode.ToString()));
        string strVersionFilePath = Path.Combine(outFolderPath, ExportAssetBundle.VersionTxtName(CurrentBundleVersion.versionCode.ToString()));

        Dictionary<string, string> fileVersion = new Dictionary<string, string>();
        string[] fileList = Directory.GetFiles(strFilePath, "*.*", SearchOption.AllDirectories);
        for (int i = 0; i < fileList.Length; i++)
        {
            string fileName = fileList[i];
            if (fileName.Contains(".manifest") || fileName.Contains(".meta") || fileName.Contains(".DS_Store"))
            {
                continue;
            }
            string filePath = Path.GetFullPath(fileName);
            EditorUtility.DisplayProgressBar("生成版本号", filePath, (float)i / (float)fileList.Length);
            byte[] bytes = File.ReadAllBytes(filePath);
            string strFileVersion = System.Convert.ToString(CRC32.GetCRC32(bytes), 16).ToUpper();
            while (8 - strFileVersion.Length > 0)
            {
                strFileVersion = "0" + strFileVersion;
            }
            filePath = filePath.Replace("\\", "/");
            strFilePath = strFilePath.Replace("\\", "/");
            string strFileKey = filePath.Replace(strFilePath + "/", "");
            //strFileKey = strFileKey.Replace("\\", "/");
            fileVersion[strFileKey] = strFileVersion;
        }

        StringBuilder content = new StringBuilder();
        foreach (KeyValuePair<string, string> kv in fileVersion)
        {
            content.AppendLine(kv.Key + "=" + kv.Value);
        }
        using (StreamWriter writer = new StreamWriter(strVersionFilePath, false))
        {
            try
            {
                writer.WriteLine("{0}", content.ToString());
            }
            catch (System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
            }
        }

        EditorUtility.ClearProgressBar();
        Debug.Log("生成:" + strVersionFilePath);
        //EditorUtility.DisplayDialog("提示", "当前文件版本号生成成功", "确定");
        AssetDatabase.Refresh();
    }

    public static void GenerateDataPublic(string dataOutFolderPath = null, string[] otherFileList = null)
    {
        string strFilePath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
        string outFolderPath = Path.GetFullPath(string.Concat(Application.dataPath, "/Update/", PathUtil.Platform));
        string outDataFolderPath = Path.Combine(outFolderPath, "data");
        if (Directory.Exists(outDataFolderPath))
        {
            try
            {
                Directory.Delete(outDataFolderPath, true);
            }
            catch { }
        }
        else
        {
            Directory.CreateDirectory(outDataFolderPath);
        }

        string fileName = "lua.u3d";
        string filePath = Path.GetFullPath(Path.Combine(strFilePath, fileName));
        if (!File.Exists(filePath))
        {
            return;
        }
        FileInfo fi = new FileInfo(Path.Combine(outDataFolderPath, fileName));
        if (!fi.Directory.Exists)
        {
            fi.Directory.Create();
        }
        File.Copy(filePath, fi.FullName);

        if (otherFileList != null)
        {
            for (int i = 0; i < otherFileList.Length; i++)
            {
                fileName = otherFileList[i];
                filePath = Path.GetFullPath(Path.Combine(strFilePath, fileName));
                if (!File.Exists(filePath))
                {
                    return;
                }
                fi = new FileInfo(Path.Combine(outDataFolderPath, fileName));
                if (!fi.Directory.Exists)
                {
                    fi.Directory.Create();
                }
                File.Copy(filePath, fi.FullName);
            }
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

        if (string.IsNullOrEmpty(dataOutFolderPath))
        {
            dataOutFolderPath = GetOutFolderPath();
        }
        if (string.IsNullOrEmpty(dataOutFolderPath))
        {
            return;
        }
        CheckDirectory(dataOutFolderPath);
        cleanMeta(outDataFolderPath);

        string dataOutPath = Path.Combine(dataOutFolderPath, "data.zip");
        FileUtil.PackFiles(dataOutPath, outDataFolderPath);
        AssetDatabase.Refresh();

        System.Threading.Thread.Sleep(1000);

        string dataFileVersion = GetFileVersion(dataOutPath);
        string newDataOutPath = PathUtil.AddVersion2FileName(dataOutPath, dataFileVersion);
        fi = new FileInfo(dataOutPath);
        fi.MoveTo(newDataOutPath);

        string configPath = Path.Combine(dataOutFolderPath, "config.txt");
        UpdateConfig(configPath, "subVersion", dataFileVersion);

        DirectoryDelete(outDataFolderPath);
        //EditorUtility.DisplayDialog("提示", "生成lua代码增量包成功", "确定");
        Debug.Log("生成lua代码增量包成功");
    }

    public static void GenerateResPublic(string versionCode, string dataOutFolderPath = null, string[] otherFileList = null)
    {
        string strFilePath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
        string outFolderPath = Path.GetFullPath(string.Concat(Application.dataPath, "/Update/", PathUtil.Platform));
        string outDataFolderPath = Path.Combine(outFolderPath, "data");
        if (Directory.Exists(outDataFolderPath))
        {
            try
            {
                Directory.Delete(outDataFolderPath, true);
            }
            catch { }
        }
        else
        {
            Directory.CreateDirectory(outDataFolderPath);
        }
        //当前版本文件的版本号
        SortedList<string, string> currentFileVersion = new SortedList<string, string>();
        string strVersionFilePath = Path.Combine(outFolderPath, ExportAssetBundle.VersionTxtName(versionCode));
        if (!File.Exists(strVersionFilePath))
        {
            string versionCodeBase = string.Empty;
            versionCodeBase = versionCode[0].ToString() + versionCode[1].ToString() + "00";
            Debug.Log("versionCodeBase:" + versionCodeBase);
            strVersionFilePath = Path.Combine(outFolderPath, ExportAssetBundle.VersionTxtName(versionCodeBase));
        }
        Debug.Log("当前处理的版本号：" + versionCode + ", 当前版本文件:" + strVersionFilePath);

        if (File.Exists(strVersionFilePath))
        {
            byte[] cfgBytes = File.ReadAllBytes(strVersionFilePath);
            if (cfgBytes != null)
            {
                string configText = System.Text.Encoding.Default.GetString(cfgBytes);
                StringReader sr = new StringReader(configText);
                string line = string.Empty;
                string[] results;
                while ((line = sr.ReadLine()) != null)
                {
                    if (!string.IsNullOrEmpty(line))
                    {
                        results = line.Split('=');
                        if (results.Length >= 2)
                        {
                            currentFileVersion[results[0]] = results[1];
                        }
                    }
                }
            }
        }

        SortedList<string, string> fileVersion = new SortedList<string, string>();
        string[] fileList = Directory.GetFiles(strFilePath, "*.*", SearchOption.AllDirectories);
        bool newUpdate = false;
        for (int i = 0; i < fileList.Length; i++)
        {
            string fileName = fileList[i];
            if (fileName.Contains(".manifest") || fileName.Contains(".meta") || fileName.Contains(".DS_Store"))
            {
                continue;
            }
            string filePath = Path.GetFullPath(fileName);
            filePath = filePath.Replace("\\", "/");
            EditorUtility.DisplayProgressBar("生成版本号", filePath, (float)i / (float)fileList.Length);
            byte[] bytes = File.ReadAllBytes(filePath);
            string strFileVersion = System.Convert.ToString(CRC32.GetCRC32(bytes), 16).ToUpper();
            while (8 - strFileVersion.Length > 0)
            {
                strFileVersion = "0" + strFileVersion;
            }
            strFilePath = strFilePath.Replace("\\", "/");
            string strFileKey = filePath.Replace(strFilePath + "/", "");
            fileVersion[strFileKey] = strFileVersion;

            if (currentFileVersion.ContainsKey(strFileKey) == false || (currentFileVersion[strFileKey] != fileVersion[strFileKey]))
            {
                //需要更新的文件，拷贝到Update目录下
                FileInfo fi = new FileInfo(Path.Combine(outDataFolderPath, strFileKey));
                if (!fi.Directory.Exists)
                {
                    fi.Directory.Create();
                }
                if (filePath.Contains("bootstrap/bootstrap.u3d"))
                {
                    continue;
                }
                //Debug.Log("更新的文件：" + filePath);
                newUpdate = true;
                File.Copy(filePath, fi.FullName, true);
            }
        }

        EditorUtility.ClearProgressBar();

        if (otherFileList != null)
        {
            for (int i = 0; i < otherFileList.Length; i++)
            {
                string fileName = otherFileList[i];
                string filePath = Path.GetFullPath(Path.Combine(strFilePath, fileName));
                if (!File.Exists(filePath))
                {
                    return;
                }
                FileInfo fi = new FileInfo(Path.Combine(outDataFolderPath, fileName));
                if (!fi.Directory.Exists)
                {
                    fi.Directory.Create();
                }
                File.Copy(filePath, fi.FullName, true);
                newUpdate = true;
            }
        }

        if (newUpdate)
        {
            System.Threading.Thread.Sleep(1000);
            AssetDatabase.Refresh();

            if (string.IsNullOrEmpty(dataOutFolderPath))
            {
                dataOutFolderPath = GetOutFolderPath();
            }
            if (string.IsNullOrEmpty(dataOutFolderPath))
            {
                return;
            }
            CheckDirectory(dataOutFolderPath);
            cleanMeta(outDataFolderPath);

            string dataOutPath = Path.Combine(dataOutFolderPath, "res.zip");
            FileUtil.PackFiles(dataOutPath, outDataFolderPath);
            AssetDatabase.Refresh();

            System.Threading.Thread.Sleep(1000);

            string dataFileVersion = GetFileVersion(dataOutPath);
            string newDataOutPath = PathUtil.AddVersion2FileName(dataOutPath, dataFileVersion);
            FileInfo fi = new FileInfo(dataOutPath);
            fi.MoveTo(newDataOutPath);

            string configPath = Path.Combine(dataOutFolderPath, "config.txt");
            UpdateConfig(configPath, "resVersion", dataFileVersion);

            DirectoryDelete(outDataFolderPath);
            //EditorUtility.DisplayDialog("提示", "生成资源增量包成功", "确定");
            Debug.Log("生成资源增量包成功");
        }
        else
        {
            //EditorUtility.DisplayDialog("提示", "没有可更新的文件", "确定");
            Debug.Log("没有可更新的文件");
        }

        AssetDatabase.Refresh();
    }

    private static void UpdateExportConfig(string cfgPath, int version, string key, string value)
    {
        List<string> contentText = new List<string>();

        if (File.Exists(cfgPath))
        {
            byte[] cfgBytes = File.ReadAllBytes(cfgPath);
            if (cfgBytes != null)
            {
                string configText = System.Text.Encoding.Default.GetString(cfgBytes);
                string[] config = configText.Split(',');
                if (config.Length >= 5)
                {
                    bool isOpenUpdate = (config[0] == "1");
                    int minVersion = int.Parse(config[1]);
                    int targetVersion = int.Parse(config[2]);
                    string apkName = config[3];
                    float apkSize = int.Parse(config[4]) / 1024;

                    contentText.Add(config[0]);
                    contentText.Add(config[1]);
                    contentText.Add(config[2]);
                    contentText.Add(config[3]);
                    contentText.Add(config[4]);

                    for (int i = 5; i < config.Length; i++)
                    {
                        string[] subVersionList = config[i].Split('=');
                        if (subVersionList.Length > 1)
                        {
                            int v = int.Parse(subVersionList[0]);
                            string val = subVersionList[1];
                            if (v == version)
                            {
                                string[] strVersion = val.Split('|');

                                if (key == "subVersion")
                                {
                                    if (strVersion.Length > 1)
                                    {
                                        contentText.Add(v + "=" + value + "|" + strVersion[1]);
                                    }
                                    else
                                    {
                                        contentText.Add(v + "=" + value + "|0");
                                    }
                                }
                                else if (key == "resVersion")
                                {
                                    contentText.Add(v + "=" + "0|" + value);
                                }
                            }
                            else
                            {
                                contentText.Add(config[i]);
                            }
                        }
                    }

                    if (config.Length == 5)
                    {
                        if (key == "subVersion")
                        {
                            contentText.Add(version + "=" + value + "|0");
                        }
                        else if (key == "resVersion")
                        {
                            contentText.Add(version + "=" + "0|" + value);
                        }
                    }
                }
            }
            else
            {
                contentText.Add("1");
                contentText.Add("1200");
                contentText.Add("1200");
                contentText.Add("game");
                contentText.Add("1000");

                if (key == "subVersion")
                {
                    contentText.Add(version + "=" + value + "|0");
                }
                else if (key == "resVersion")
                {
                    contentText.Add(version + "=" + "0|" + value);
                }
            }
        }
        else
        {
            contentText.Add("1");
            contentText.Add("1200");
            contentText.Add("1200");
            contentText.Add("game");
            contentText.Add("1000");

            if (key == "subVersion")
            {
                contentText.Add(version + "=" + value + "|0");
            }
            else if (key == "resVersion")
            {
                contentText.Add(version + "=" + "0|" + value);
            }
        }
        string[] content = contentText.ToArray();
        string cfg = string.Join(",", content);
        using (StreamWriter writer = new StreamWriter(cfgPath, false))
        {
            try
            {
                writer.Write("{0}", cfg);
                writer.Close();
            }
            catch (System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
            }
        }
    }

    private static void UpdateConfig(string cfgPath, string key, string value)
    {
        string subVersion = "0";
        string resVersion = "0";
        if (File.Exists(cfgPath))
        {
            byte[] cfgBytes = File.ReadAllBytes(cfgPath);
            if (cfgBytes != null)
            {
                string configText = System.Text.Encoding.Default.GetString(cfgBytes);
                string[] configList = configText.Split('|');
                if (configList.Length > 1)
                {
                    subVersion = configList[0];
                    resVersion = configList[1];
                }
            }
        }

        if (key == "subVersion")
        {
            subVersion = value;
        }
        else if (key == "resVersion")
        {
            resVersion = value;
        }

        StringBuilder content = new StringBuilder();
        content.Append(subVersion + "|" + resVersion);

        using (StreamWriter writer = new StreamWriter(cfgPath, false))
        {
            try
            {
                writer.WriteLine("{0}", content.ToString());
                writer.Close();
            }
            catch (System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
            }
        }
    }

    private static string GetFileVersion(string filePath)
    {
        byte[] bytes = File.ReadAllBytes(filePath);
        string strFileVersion = System.Convert.ToString(CRC32.GetCRC32(bytes), 16).ToUpper();
        while (8 - strFileVersion.Length > 0)
        {
            strFileVersion = "0" + strFileVersion;
        }
        int size = (bytes.Length / 1024);
        return strFileVersion + "_" + size;
    }

    private static string GetOutFolderPath()
    {
        string outFolderName = PathUtil.Platform + CurrentBundleVersion.versionCode.ToString();

        string folder = PlayerPrefs.GetString("res_out_path");
        if (folder.Contains(outFolderName))
        {
            folder = Path.GetDirectoryName(folder);
        }
        if (!string.IsNullOrEmpty(folder))
        {
            string strOut = Path.GetFullPath(Path.Combine(folder, outFolderName));
            if (Directory.Exists(strOut) == false)
            {
                Directory.CreateDirectory(strOut);
            }
        }
        string saveFolderPath = EditorUtility.SaveFolderPanel("导出", folder, outFolderName);
        if (string.IsNullOrEmpty(saveFolderPath))
        {
            return null;
        }
        if (saveFolderPath.Contains(outFolderName))
        {
            saveFolderPath = Path.GetDirectoryName(saveFolderPath);
        }
        saveFolderPath = Path.GetFullPath(saveFolderPath);
        PlayerPrefs.SetString("res_out_path", saveFolderPath);

        string outFolderPath = Path.Combine(saveFolderPath, outFolderName);
        if (!Directory.Exists(outFolderPath))
        {
            Directory.CreateDirectory(outFolderPath);
        }

        return outFolderPath;
    }

    private static void cleanMeta(string path)
    {
        string[] names = Directory.GetFiles(path);
        string[] dirs = Directory.GetDirectories(path);
        foreach (string filename in names)
        {
            string ext = Path.GetExtension(filename);
            if (ext.Equals(".meta"))
            {
                File.Delete(@filename);
            }

            foreach (string dir in dirs)
            {
                cleanMeta(dir);
            }
        }
    }

    #endregion

    #region lua

    public static void EncodeCSharpFile()
    {
        string path = Path.GetFullPath(Path.Combine(Application.dataPath, "Script"));
        List<string> files = getAllChildFiles(path, "cs");

        foreach (string filePath in files)
        {
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".cs"))
            {
                continue;
            }
            string strText = File.ReadAllText(file);
            using (
                StreamWriter kWriter = new StreamWriter(file, false, new System.Text.UTF8Encoding(false)))
            {

                kWriter.Write(strText);
                kWriter.Close();
            }
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

    }

    public static void EncodeLuaFile()
    {
        string path = Path.GetFullPath(Path.Combine(Application.dataPath, "Lua"));
        string cfgPath = Path.GetFullPath(Path.Combine(Application.dataPath, "Config"));
        List<string> files = getAllChildFiles(path, "lua");
        getAllChildFiles(cfgPath, "lua", files);

        foreach (string filePath in files)
        {
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".lua"))
            {
                continue;
            }
            string strText = File.ReadAllText(file);
            using (
                StreamWriter kWriter = new StreamWriter(file, false, new System.Text.UTF8Encoding(false)))
            {

                kWriter.Write(strText);
                kWriter.Close();
            }
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

    }

    private static JITBUILDTYPE GetLuaJitBuildType(BuildTarget bt)
    {
        switch (bt)
        {
            case BuildTarget.Android:
                return JITBUILDTYPE.X86;
            case BuildTarget.iOS:
                return JITBUILDTYPE.GC64;
            case BuildTarget.StandaloneWindows:
                return JITBUILDTYPE.X86;
            case BuildTarget.StandaloneWindows64:
                return JITBUILDTYPE.X64;
            case BuildTarget.StandaloneOSX:
                return JITBUILDTYPE.GC64;
            default:
                return JITBUILDTYPE.GC64;
        }
    }

    public static void ExportLua()
    {
        string path = Path.GetFullPath(Path.Combine(Application.dataPath, "Lua"));

        string tmpPath = Path.GetFullPath(Path.Combine(Application.dataPath, "tmp"));

        DirectoryDelete(tmpPath);
        CheckDirectory(tmpPath);

        List<string> sourceFiles = new List<string>();
        List<string> exportNames = new List<string>();

        List<string> files = getAllChildFiles(path, "lua");
        foreach (string filePath in files)
        {
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".lua"))
            {
                continue;
            }
            string byteFileName = file.Replace(path, "");
            if (byteFileName.StartsWith("\\") || byteFileName.StartsWith("/"))
            {
                byteFileName = byteFileName.Substring(1);
            }

            byteFileName = byteFileName.Replace(".lua", ".bytes").Replace("\\", "_").Replace("/", "_");
            exportNames.Add("Assets/tmp/" + byteFileName);
            //File.Copy(file, Path.Combine(tmpPath, byteFileName), true);
            string srcFile = file.Replace(Path.GetFullPath(Application.dataPath), "");
            srcFile = "Assets" + srcFile;
            Debug.Log(srcFile);
            sourceFiles.Add(srcFile);
        }
        //打包config
        string cfgPath = Path.GetFullPath(Path.Combine(Application.dataPath, "Config/config"));
        Debug.Log("Export Lua Path:" + cfgPath);
        List<string> cfgFiles = getAllChildFiles(cfgPath, "lua");
        foreach (string filePath in cfgFiles)
        {
            string file = Path.GetFullPath(filePath);
            if (!file.EndsWith(".lua"))
            {
                continue;
            }
            string byteFileName = file.Replace(cfgPath, "");
            if (byteFileName.StartsWith("\\") || byteFileName.StartsWith("/"))
            {
                byteFileName = byteFileName.Substring(1);
            }
            byteFileName = byteFileName.Replace(".lua", ".bytes").Replace("\\", "_").Replace("/", "_");
            byteFileName = "config_" + byteFileName;
            exportNames.Add("Assets/tmp/" + byteFileName);
            //File.Copy(file, Path.Combine(tmpPath, byteFileName), true);
            string srcFile = file.Replace(Path.GetFullPath(Application.dataPath), "");
            srcFile = "Assets" + srcFile;
            sourceFiles.Add(srcFile);
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

        JITBUILDTYPE jbt = GetLuaJitBuildType(EditorUserBuildSettings.activeBuildTarget);
        SLua.LuajitGen.compileLuaJit(sourceFiles.ToArray(), exportNames.ToArray(), jbt);

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();

        ExportAssetBundle.BuildAssetBundles(exportNames.ToArray(), "Assets/tmp", "luaout.bytes", optionsDefault);

        string strOutputPath = Path.Combine(Application.streamingAssetsPath, PathUtil.Platform);
        CheckDirectory(strOutputPath);

        string luaoutPath = Path.Combine(Application.dataPath, "tmp/luaout.bytes");
        string luaExportPath = Path.GetFullPath(Path.Combine(strOutputPath, "lua.u3d"));
        byte[] by = File.ReadAllBytes(luaoutPath);
        byte[] encrypt = CryptographHelper.Encrypt(by, KeyVData.Instance.KEY, KeyVData.Instance.IV);
        File.WriteAllBytes(luaExportPath, encrypt);

        DirectoryDelete(tmpPath);

        Debug.Log(luaExportPath + " export.");

        System.Threading.Thread.Sleep(100);
        AssetDatabase.Refresh();
    }
    #endregion

    #region assetbundle
    public static void SetAssetBundlesName()
    {
        Object[] objList = Selection.objects;
        AssetImporter assetImport = null;
        foreach (Object obj in objList)
        {
            assetImport = AssetImporter.GetAtPath(AssetDatabase.GetAssetPath(obj));
            string strName = obj.name.Replace(" ", "");
            assetImport.assetBundleName = strName + ".u3d";
            if (obj is GameObject)
            {
                GameObject go = obj as GameObject;
                AssetBundleReference bundleRef = go.AddMissingComponent<AssetBundleReference>();
                bundleRef.assetBundleName = strName + ".u3d";
            }
        }
    }

    public static void SetAssetBundlesNameByDirectory()
    {
        Object[] objList = Selection.objects;

        foreach (Object obj in objList)
        {
            string strPath = AssetDatabase.GetAssetPath(obj);
            SetAssetBundleNameByDirectory(strPath, obj);
        }
    }

    public static void SetAssetBundleNameByDirectory(string strPath, Object obj)
    {
        if (obj == null)
        {
            return;
        }
        AssetImporter assetImport = null;

        string strDirectory = Path.GetDirectoryName(strPath);
        strPath = strPath.Replace(" ", "");
        assetImport = AssetImporter.GetAtPath(strPath);
        strDirectory = strDirectory.Replace("\\", "/");
        string strName = "";
        if (strDirectory.StartsWith("Assets/RawResources/bootstrap"))
        {
            strName = "bootstrap/bootstrap";
        }
        else
        {
            string[] dirList = strDirectory.Split('/');
            if (strDirectory == "Assets/RawResources/Scene/Prefab")
            {
                strDirectory = "scene";
            }
            else
            {
                strDirectory = dirList[dirList.Length - 1];
            }

            strName = obj.name.Replace(" ", "");
            strName = strDirectory + "/" + strName;
            strName = strName.ToLower();
        }
        if (assetImport != null)
        {
            assetImport.assetBundleName = strName + ".u3d";
        }

        if (PrefabUtility.IsPartOfPrefabAsset(obj))
        {
            GameObject prefabRoot = PrefabUtility.LoadPrefabContents(strPath);
            try
            {
                AssetBundleReference bundleRef = prefabRoot.AddMissingComponent<AssetBundleReference>();
                bundleRef.assetBundleName = strName + ".u3d";
                PrefabUtility.SaveAsPrefabAsset(prefabRoot, strPath);
            }
            finally
            {
                PrefabUtility.UnloadPrefabContents(prefabRoot);
            }
        }
    }

    public static void BuildAssetBundle(Object main, Object[] assets, string pathName, BuildAssetBundleOptions op)
    {
        //BuildPipeline.BuildAssetBundle(main, assets, pathName, op, EditorUserBuildSettings.activeBuildTarget);
    }

    public static void BuildAssetBundles()
    {
        string strOutputPath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
        CheckDirectory(strOutputPath);

        Debug.LogFormat("Export Path:{0}", strOutputPath);
        BuildPipeline.BuildAssetBundles(strOutputPath, optionsDefault, EditorUserBuildSettings.activeBuildTarget);

        AssetDatabase.Refresh();
    }

    public static void BuildAssetBundles(string[] assets, string outPath, string abName, BuildAssetBundleOptions op)
    {
        AssetBundleBuild[] build = new AssetBundleBuild[1];
        build[0].assetBundleName = abName;
        build[0].assetNames = assets;
        BuildPipeline.BuildAssetBundles(outPath, build, op, EditorUserBuildSettings.activeBuildTarget);
    }
    #endregion

    #region util

    public static void CleanLocalFile()
    {
        DirectoryDelete(Application.persistentDataPath);
    }

    private static void CheckDirectory(string path)
    {
        if (!Directory.Exists(path))
        {
            DirectoryInfo dir = Directory.CreateDirectory(path);
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

    private static List<string> getAllChildFiles(string path, string suffix = "lua", List<string> files = null)
    {
        if (files == null)
        {
            files = new List<string>();
        }
        if (Directory.Exists(path))
        {
            AddFiles(path, suffix, files);
            string[] dires = Directory.GetDirectories(path);
            foreach (string dir in dires)
            {
                getAllChildFiles(dir, suffix, files);
            }
        }
        return files;
    }

    private static void AddFiles(string dirPath, string suffix, List<string> files)
    {
        if (!Directory.Exists(dirPath))
        {
            return;
        }
        string[] getFiles = Directory.GetFiles(dirPath);
        foreach (string f in getFiles)
        {
            if (f.ToLower().EndsWith(suffix.ToLower()))
            {
                files.Add(f);
            }
        }
    }
    #endregion
}
