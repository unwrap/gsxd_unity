using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading;
using UnityEditor;
using UnityEngine;

public static class FindReferencesInProject
{
    private const string MetaExtension = ".meta";

    public static List<string> FindReference(UnityEngine.Object selectedObject)
    {
        List<string> references = new List<string>();

        var sw = new System.Diagnostics.Stopwatch();
        sw.Start();

        var referenceCache = new Dictionary<string, List<string>>();
        string[] guids = AssetDatabase.FindAssets("");
        EditorUtility.DisplayProgressBar("find reference", "Please wait ...", 0);
        for ( int i = 0; i < guids.Length; i++)
        {
            string guid = guids[i];
            string assetPath = AssetDatabase.GUIDToAssetPath(guid);
            EditorUtility.DisplayProgressBar("find reference", assetPath, i / (float)guids.Length);

            string[] dependencies = AssetDatabase.GetDependencies(assetPath, false);

            foreach (var dependency in dependencies)
            {
                if (referenceCache.ContainsKey(dependency))
                {
                    if (!referenceCache[dependency].Contains(assetPath))
                    {
                        referenceCache[dependency].Add(assetPath);
                    }
                }
                else
                {
                    referenceCache[dependency] = new List<string>() { assetPath };
                }
            }
        }

        EditorUtility.ClearProgressBar();

        UnityEngine.Debug.Log("Build index takes " + sw.ElapsedMilliseconds + " milliseconds");

        sw.Stop();

        string path = AssetDatabase.GetAssetPath(selectedObject);
        if (referenceCache.ContainsKey(path))
        {
            foreach (var reference in referenceCache[path])
            {
                //UnityEngine.Debug.Log(reference, AssetDatabase.LoadMainAssetAtPath(reference));
                references.Add(reference);
            }
        }

        referenceCache.Clear();

        return references;
    }

    public static List<string> FindObjectReference(UnityEngine.Object selectedObject)
    {
        bool isMacOS = Application.platform == RuntimePlatform.OSXEditor;
        int totalWaitMilliseconds = isMacOS ? 2 * 1000 : 300 * 1000;
        int cpuCount = Environment.ProcessorCount;
        string appDataPath = Application.dataPath;

        string selectedAssetPath = AssetDatabase.GetAssetPath(selectedObject);
        string selectedAssetGUID = AssetDatabase.AssetPathToGUID(selectedAssetPath);
        string selectedAssetMetaPath = selectedAssetPath + MetaExtension;

        var references = new List<string>();
        System.Text.StringBuilder output = new System.Text.StringBuilder();

        var stopwatch = new Stopwatch();
        stopwatch.Start();

        var psi = new ProcessStartInfo();
        psi.WindowStyle = ProcessWindowStyle.Minimized;
        if (isMacOS)
        {
            psi.FileName = "/usr/bin/mdfind";
            psi.Arguments = string.Format("-onlyin {0} {1}", appDataPath, selectedAssetGUID);
        }
        else
        {
            psi.FileName = Path.Combine(Environment.CurrentDirectory, @"Tools\rg.exe");
            psi.Arguments = string.Format("--case-sensitive --follow --files-with-matches --no-text --fixed-strings " +
                                          "--ignore-file Assets/Editor/Misc/ignore.txt " +
                                          "--threads {0} --regexp {1} -- {2}",
                cpuCount, selectedAssetGUID, appDataPath);
        }

        psi.UseShellExecute = false;
        psi.RedirectStandardOutput = true;
        psi.RedirectStandardError = true;

        var process = new Process();
        process.StartInfo = psi;

        process.OutputDataReceived += (sender, e) =>
        {
            if (string.IsNullOrEmpty(e.Data))
                return;

            string relativePath = e.Data.Replace(appDataPath, "Assets").Replace("\\", "/");

            // skip the meta file of whatever we have selected
            if (relativePath == selectedAssetMetaPath)
                return;

            references.Add(relativePath);
        };

        process.ErrorDataReceived += (sender, e) =>
        {
            if (string.IsNullOrEmpty(e.Data))
                return;

            output.AppendLine("Error: " + e.Data);
        };

        process.Start();
        process.BeginOutputReadLine();
        process.BeginErrorReadLine();

        while (!process.HasExited)
        {
            if (stopwatch.ElapsedMilliseconds < totalWaitMilliseconds)
            {
                float progress = (float)((double)stopwatch.ElapsedMilliseconds / totalWaitMilliseconds);
                string info = string.Format("Finding {0}/{1}s {2:P2}", stopwatch.ElapsedMilliseconds / 1000,
                    totalWaitMilliseconds / 1000, progress);
                bool canceled = EditorUtility.DisplayCancelableProgressBar("Find References in Project", info, progress);

                if (canceled)
                {
                    process.Kill();
                    break;
                }

                Thread.Sleep(100);
            }
            else
            {
                process.Kill();
                break;
            }
        }

        if(output.Length > 0)
        {
            UnityEngine.Debug.LogWarning(output.ToString());
        }

        EditorUtility.ClearProgressBar();
        stopwatch.Stop();

        return references;
    }

    public static void Find()
    {
        var selectedObject = Selection.activeObject;
        List<string> references = FindObjectReference(selectedObject);

        if(references.Count <= 0)
        {
            UnityEngine.Debug.Log("No dependence");
        }
        else
        {
            foreach (string file in references)
            {
                string guid = AssetDatabase.AssetPathToGUID(file);

                string assetPath = file;
                if (file.EndsWith(MetaExtension))
                {
                    assetPath = file.Substring(0, file.Length - MetaExtension.Length);
                }

                UnityEngine.Debug.Log(string.Format("{0}\n{1}", file, guid), AssetDatabase.LoadMainAssetAtPath(assetPath));
            }
        }
    }

    public static bool FindValidate()
    {
        var obj = Selection.activeObject;
        if (obj != null && AssetDatabase.Contains(obj))
        {
            string path = AssetDatabase.GetAssetPath(obj);
            return !AssetDatabase.IsValidFolder(path);
        }
        return true;
    }
}
