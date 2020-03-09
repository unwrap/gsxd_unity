using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEngine;

public class CompileCoreScript
{
    static public string GenPath = "Assets/Script/Core";
    static public string WrapperName = "gameCore.dll";

    public static void CompileCoreScriptToDLL()
    {
        #region scripts
        List<string> scripts = new List<string>();
        string[] guids = AssetDatabase.FindAssets("t:Script", new string[1] { Path.GetDirectoryName(GenPath) }).Distinct().ToArray();
        int guidCount = guids.Length;
        for (int i = 0; i < guidCount; i++)
        {
            // path may contains space
            string path = "\"" + AssetDatabase.GUIDToAssetPath(guids[i]) + "\"";
            if (!scripts.Contains(path))
                scripts.Add(path);
        }

        if (scripts.Count == 0)
        {
            Debug.LogError("No Scripts");
            return;
        }
        #endregion

        #region libraries
        List<string> libraries = new List<string>();
        string[] referenced = new string[] { "UnityEngine", "UnityEngine.UI" };
        string projectPath = Path.GetFullPath(Application.dataPath + "/..").Replace("\\", "/");
        // http://stackoverflow.com/questions/52797/how-do-i-get-the-path-of-the-assembly-the-code-is-in
        foreach (var assem in AppDomain.CurrentDomain.GetAssemblies())
        {
            UriBuilder uri = new UriBuilder(assem.CodeBase);
            string path = Uri.UnescapeDataString(uri.Path).Replace("\\", "/");
            string name = Path.GetFileNameWithoutExtension(path);
            // ignore dll for Editor
            if ((path.StartsWith(projectPath) && !path.Contains("/Editor/") && !path.Contains("CSharp-Editor"))
                || referenced.Contains(name))
            {
                libraries.Add(path);
            }
        }
        #endregion

        #region mono compile            
        string editorData = EditorApplication.applicationContentsPath;
#if UNITY_EDITOR_OSX && !UNITY_5_4_OR_NEWER
			editorData += "/Frameworks";
#endif
        List<string> arg = new List<string>();
        arg.Add("/target:library");
        arg.Add(string.Format("/out:\"{0}\"", WrapperName));
        arg.Add(string.Format("/r:\"{0}\"", string.Join(";", libraries.ToArray())));
        arg.AddRange(scripts);

        const string ArgumentFile = "LuaCodeGen.txt";
        File.WriteAllLines(ArgumentFile, arg.ToArray());

        Environment.SetEnvironmentVariable("MONO_PATH", editorData + "/Mono/lib/mono/unity");
        Environment.SetEnvironmentVariable("MONO_CFG_DIR", editorData + "/Mono/etc");
        string mono = editorData + "/Mono/bin/mono";
#if UNITY_EDITOR_WIN
        mono += ".exe";
#endif
        string smcs = editorData + "/Mono/lib/mono/unity/smcs.exe";
        // wrapping since we may have space
#if UNITY_EDITOR_WIN
        mono = "\"" + mono + "\"";
#endif
        smcs = "\"" + smcs + "\"";
        #endregion

        #region execute bash
        StringBuilder output = new StringBuilder();
        StringBuilder error = new StringBuilder();
        bool success = false;
        try
        {
            var process = new System.Diagnostics.Process();
            process.StartInfo.FileName = mono;
            process.StartInfo.Arguments = smcs + " @" + ArgumentFile;
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;

            using (var outputWaitHandle = new System.Threading.AutoResetEvent(false))
            using (var errorWaitHandle = new System.Threading.AutoResetEvent(false))
            {
                process.OutputDataReceived += (sender, e) =>
                {
                    if (e.Data == null)
                    {
                        outputWaitHandle.Set();
                    }
                    else
                    {
                        output.AppendLine(e.Data);
                    }
                };
                process.ErrorDataReceived += (sender, e) =>
                {
                    if (e.Data == null)
                    {
                        errorWaitHandle.Set();
                    }
                    else
                    {
                        error.AppendLine(e.Data);
                    }
                };
                // http://stackoverflow.com/questions/139593/processstartinfo-hanging-on-waitforexit-why
                process.Start();

                process.BeginOutputReadLine();
                process.BeginErrorReadLine();

                const int timeout = 300;
                if (process.WaitForExit(timeout * 1000) &&
                    outputWaitHandle.WaitOne(timeout * 1000) &&
                    errorWaitHandle.WaitOne(timeout * 1000))
                {
                    success = (process.ExitCode == 0);
                }
            }
        }
        catch (System.Exception ex)
        {
            Debug.LogError(ex);
        }
        #endregion

        Debug.Log(output.ToString());
        if (success)
        {
            Directory.Delete(GenPath, true);
            Directory.CreateDirectory(GenPath);
            File.Move(WrapperName, GenPath + WrapperName);
            // AssetDatabase.Refresh();
            File.Delete(ArgumentFile);
        }
        else
        {
            Debug.LogError(error.ToString());
        }
    }
}
