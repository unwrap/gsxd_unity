using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;

[InitializeOnLoad]
public class BundleVersionChecker
{
    private const string ClassName = "CurrentBundleVersion";
    private const string TargetCodeFile = "Assets/Script/Game/Config/" + ClassName + ".cs";

    static BundleVersionChecker()
    {
        string bundleVersion = PlayerSettings.bundleVersion;
        string lastVersion = CurrentBundleVersion.version;

        if( lastVersion != bundleVersion )
        {
            Debug.Log("Found new bundle version " + bundleVersion + " replacing code from previous version " + lastVersion + " in file \"" + TargetCodeFile + "\"");
            CreateNewBuildVersionClassFile(bundleVersion);
        }
    }

    public static void UpdateBundleVersion()
    {
        Debug.Log("UpdateBundleVersion : " + PlayerSettings.bundleVersion);
        CreateNewBuildVersionClassFile(PlayerSettings.bundleVersion);
#if UNITY_ANDROID
        string bundleVersionCode = BundleVersion2Code(PlayerSettings.bundleVersion);
        PlayerSettings.Android.bundleVersionCode = int.Parse(bundleVersionCode);
#endif
    }

    private static string CreateNewBuildVersionClassFile(string bundleVersion)
    {
        using (StreamWriter writer = new StreamWriter(TargetCodeFile, false))
        {
            try
            {
                string code = GenerateCode(bundleVersion);
                writer.WriteLine("{0}", code);
            }
            catch(System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
                EditorUtility.DisplayDialog("Error when trying to regenerate class.", msg, "OK");
            }
        }
        return TargetCodeFile;
    }

    private static string GenerateCode(string bundleVersion)
    {
        string bundleVersionCode = BundleVersion2Code(bundleVersion);
        string code = "public static class " + ClassName + "\n{\n";
        code += System.String.Format("\tpublic static readonly string version = \"{0}\";", bundleVersion);
        code += System.String.Format("\n\tpublic static readonly int versionCode = {0};", int.Parse(bundleVersionCode));
        code += "\n}\n";
        return code;
    }

    public static string BundleVersion2Code(string bundleVersion)
    {
        string[] codes = bundleVersion.Split('.');
        int lastIndex = codes.Length - 1;
        if(codes[lastIndex].Length == 1)
        {
            codes[lastIndex] = "0" + codes[lastIndex];
        }
        string bundleVersionCode = string.Join("", codes);
        Debug.Log("bundleVersionCode:" + bundleVersionCode);
        return bundleVersionCode;
    }
}
