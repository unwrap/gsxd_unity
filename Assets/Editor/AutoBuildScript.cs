using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;
using System;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using System.Text.RegularExpressions;
using UnityEditor.Build.Reporting;

public class AutoBuildScript : MonoBehaviour
{
    static string[] SCENES = FindEnabledEditorScenes();
    private static string[] Defines3rd = { "test", "taptap" };
        
    #region 热更新

    public static void ExportAndroidPublic(string subBucket = null)
    {
        string[] args = System.Environment.GetCommandLineArgs();
        if (args == null || args.Length == 0)
        {
            return;
        }
        Debug.Log("ExportiPhonePublic: " + string.Join(", ", args));

        List<string> fileList = new List<string>();
        List<string> versionList = new List<string>();
        Regex regExp = new Regex(@"^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$");
        foreach (string fileName in args)
        {
            if (fileName.EndsWith(".u3d"))
            {
                fileList.Add(fileName);
            }
            else
            {
                if (regExp.IsMatch(fileName))
                {
                    string bundleVersionCode = BundleVersionChecker.BundleVersion2Code(fileName);
                    if (!versionList.Contains(bundleVersionCode))
                    {
                        versionList.Add(bundleVersionCode);
                    }
                }
            }
        }

        EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTargetGroup.Android, BuildTarget.Android);
        //PlayerSettings.bundleIdentifier = "xin.unwrap.xiami";
        string bundleVersion = args[args.Length - 2];
        PlayerSettings.bundleVersion = bundleVersion;
        //PlayerSettings.SetPropertyInt("ScriptingBackend", (int)ScriptingImplementation.IL2CPP, BuildTarget.Android);
        BundleVersionChecker.UpdateBundleVersion();
        AssetDatabase.Refresh();

        ExportAssetBundle.BuildAssetBundles();
        AssetDatabase.Refresh();
        ExportAssetBundle.ExportLua();
        AssetDatabase.Refresh();

        string folder = args[args.Length - 1];
        foreach (string bundleVersionCode in versionList)
        {
            string outFolderName = PathUtil.Platform + bundleVersionCode;
            if (!string.IsNullOrEmpty(subBucket))
            {
                outFolderName = subBucket + "/" + outFolderName;
            }
            string strOut = Path.GetFullPath(Path.Combine(folder, outFolderName));
            if (Directory.Exists(strOut) == false)
            {
                Directory.CreateDirectory(strOut);
            }
            Debug.Log("资源导出目录：" + strOut);
            ExportAssetBundle.GenerateResPublic(bundleVersionCode, strOut, fileList.ToArray());
        }
    }

    public static void ExportiPhonePublic(string subBucket = null)
    {
        string[] args = System.Environment.GetCommandLineArgs();
        if (args == null || args.Length == 0)
        {
            return;
        }
        Debug.Log("ExportiPhonePublic: " + string.Join(", ", args));

        List<string> fileList = new List<string>();
        List<string> versionList = new List<string>();
        Regex regExp = new Regex(@"^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$");
        foreach (string fileName in args)
        {
            if (fileName.EndsWith(".u3d"))
            {
                fileList.Add(fileName);
            }
            else
            {
                if (regExp.IsMatch(fileName))
                {
                    string bundleVersionCode = BundleVersionChecker.BundleVersion2Code(fileName);
                    if (!versionList.Contains(bundleVersionCode))
                    {
                        versionList.Add(bundleVersionCode);
                    }
                }
            }
        }

        EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTargetGroup.iOS, BuildTarget.iOS);
        string bundleVersion = args[args.Length - 3];
        PlayerSettings.bundleVersion = bundleVersion;
        PlayerSettings.iOS.buildNumber = args[args.Length - 2];
        BundleVersionChecker.UpdateBundleVersion();
        AssetDatabase.Refresh();

        ExportAssetBundle.BuildAssetBundles();
        AssetDatabase.Refresh();
        ExportAssetBundle.ExportLua();
        AssetDatabase.Refresh();

        string folder = args[args.Length - 1];
        foreach (string bundleVersionCode in versionList)
        {
            string outFolderName = PathUtil.Platform + bundleVersionCode;
            if (!string.IsNullOrEmpty(subBucket))
            {
                outFolderName = subBucket + "/" + outFolderName;
            }
            string strOut = Path.GetFullPath(Path.Combine(folder, outFolderName));
           
            if (Directory.Exists(strOut) == false)
            {
                Directory.CreateDirectory(strOut);
            }
            Debug.Log("资源导出目录：" + strOut);
            ExportAssetBundle.GenerateResPublic(bundleVersionCode, strOut, fileList.ToArray());
        }
    }

    public static void ExportAndroidLuaPublic(string subBucket = null)
    {
        string[] args = System.Environment.GetCommandLineArgs();
        if (args == null || args.Length == 0)
        {
            return;
        }
        Debug.Log(string.Join(",", args));

        List<string> fileList = new List<string>();
        List<string> versionList = new List<string>();
        Regex regExp = new Regex(@"^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$");
        foreach (string fileName in args)
        {
            if (fileName.EndsWith(".u3d"))
            {
                fileList.Add(fileName);
            }
            else
            {
                if (regExp.IsMatch(fileName))
                {
                    string bundleVersionCode = BundleVersionChecker.BundleVersion2Code(fileName);
                    if (!versionList.Contains(bundleVersionCode))
                    {
                        versionList.Add(bundleVersionCode);
                    }
                }
            }
        }

        EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTargetGroup.Android, BuildTarget.Android);
        //PlayerSettings.bundleIdentifier = "xin.unwrap.xiami";
        string bundleVersion = args[args.Length - 2];
        PlayerSettings.bundleVersion = bundleVersion;
        //PlayerSettings.SetPropertyInt("ScriptingBackend", (int)ScriptingImplementation.IL2CPP, BuildTarget.Android);
        BundleVersionChecker.UpdateBundleVersion();
        AssetDatabase.Refresh();

        ExportAssetBundle.BuildAssetBundles();
        AssetDatabase.Refresh();
        ExportAssetBundle.ExportLua();
        AssetDatabase.Refresh();

        string folder = args[args.Length - 1];
        foreach (string bundleVersionCode in versionList)
        {
            string outFolderName = PathUtil.Platform + bundleVersionCode;
            if (!string.IsNullOrEmpty(subBucket))
            {
                outFolderName = subBucket + "/" + outFolderName;
            }
            string strOut = Path.GetFullPath(Path.Combine(folder, outFolderName));
            if (Directory.Exists(strOut) == false)
            {
                Directory.CreateDirectory(strOut);
            }
            Debug.Log("导出目录：" + strOut);
            ExportAssetBundle.GenerateDataPublic(strOut, fileList.ToArray());
        }
    }

    public static void InvokeEmptyFunc()
    {

    }

    #endregion

    #region private
    private static string[] FindEnabledEditorScenes()
    {
        List<string> EditorScenes = new List<string>();
        foreach (EditorBuildSettingsScene scene in EditorBuildSettings.scenes)
        {
            if (!scene.enabled) continue;
            EditorScenes.Add(scene.path);
        }
        return EditorScenes.ToArray();
    }

    private static void GenericBuild(string[] scenes, string target_dir, BuildTarget build_target, BuildOptions build_options)
    {
        AssetDatabase.Refresh();

        bool needEncrypt = false;

        if (needEncrypt)
        {
            string strOutputPath = Path.GetFullPath(Path.Combine(Application.streamingAssetsPath, PathUtil.Platform));
            DirectoryInfo dir = new DirectoryInfo(strOutputPath);
            if (dir.Exists)
            {
                dir.Delete(true);
            }
            AssetDatabase.Refresh();

            GenerateObfuscatedCode.GenerateCodes();
            AssetDatabase.Refresh();
        }

        ExportAssetBundle.BuildAssetBundles();
        ExportAssetBundle.ExportLua();

        if (needEncrypt)
        {
            ExportAssetBundle.EncryptAssetBundle();
        }

        ExportAssetBundle.GenerateVersion();

        BuildReport res = BuildPipeline.BuildPlayer(scenes, target_dir, build_target, build_options);
        BuildSummary summary = res.summary;
        if (summary.result == BuildResult.Failed)
        {
            throw new Exception("BuildPlayer failure: " + res.ToString());
        }
    }

    private static void DeleteDir(string dirName)
    {
        string fullDirName = Path.GetFullPath(Path.Combine(Application.dataPath, dirName));
        DirectoryInfo dir = new DirectoryInfo(fullDirName);
        if (dir.Exists)
        {
            dir.Delete(true);
        }
        if (File.Exists(fullDirName))
        {
            File.Delete(fullDirName);
        }
    }

    private static void CopyFiles(string dirName)
    {
        string fullDirName = Path.GetFullPath("Assets/3rdSDK/" + dirName);
        Debug.Log(fullDirName);
        List<string> files = new List<string>();
        GetAllChildFiles(fullDirName, files);
        string removeDir = Path.GetFileName("3rdSDK/" + dirName);
        float progress = 0.0f;
        float totalProgress = files.Count;
        foreach (string strFile in files)
        {
            string targetFile = strFile.Replace(fullDirName, "");
            targetFile = Path.GetFullPath("Assets/" + targetFile);
            FileInfo fi = new FileInfo(targetFile);
            if (!fi.Directory.Exists)
            {
                fi.Directory.Create();
            }
            try
            {
                File.Copy(strFile, targetFile, true);
            }
            catch (Exception ex)
            {
                Debug.Log(ex.Message);
            }

            progress++;
            EditorUtility.DisplayProgressBar("替换文件", targetFile, progress / totalProgress);
        }
        EditorUtility.ClearProgressBar();
    }

    private static List<string> GetAllChildFiles(string path, List<string> files = null)
    {
        if (files == null)
        {
            files = new List<string>();
        }
        if (Directory.Exists(path))
        {
            DirectoryInfo d = new DirectoryInfo(path);
            FileSystemInfo[] fsinfos = d.GetFileSystemInfos();
            foreach (FileSystemInfo fsinfo in fsinfos)
            {
                if (fsinfo is DirectoryInfo)
                {
                    GetAllChildFiles(fsinfo.FullName, files);
                }
                else
                {
                    files.Add(fsinfo.FullName);
                }
            }
        }
        return files;
    }

    private static bool UnpackFiles(string file, string dir)
    {
        try
        {
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            ZipInputStream s = new ZipInputStream(File.OpenRead(file));

            ZipEntry theEntry;
            while ((theEntry = s.GetNextEntry()) != null)
            {

                string directoryName = Path.GetDirectoryName(theEntry.Name);
                string fileName = Path.GetFileName(theEntry.Name);
                if (fileName.EndsWith(".meta"))
                {
                    continue;
                }

                if (directoryName != String.Empty)
                    Directory.CreateDirectory(dir + directoryName);

                if (fileName != String.Empty)
                {
                    FileStream streamWriter = File.Create(dir + theEntry.Name);

                    int size = 2048;
                    byte[] data = new byte[2048];
                    while (true)
                    {
                        size = s.Read(data, 0, data.Length);
                        if (size > 0)
                        {
                            streamWriter.Write(data, 0, size);
                        }
                        else
                        {
                            break;
                        }
                    }

                    streamWriter.Close();
                }
            }
            s.Close();
            return true;
        }
        catch (Exception ex)
        {
            Debug.LogError(ex.Message);
            return false;
        }
    }
    #endregion
}
