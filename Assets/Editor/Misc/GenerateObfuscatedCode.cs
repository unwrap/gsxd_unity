using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class GenerateObfuscatedCode
{
    private const string TargetCodeDir = "Assets/Script/ObfuscatedCode/Code";
    private const string CodeInvokeClassName = "CodeInvoke";
    private const string CodeInvokeClass = "Assets/Script/ObfuscatedCode/" + CodeInvokeClassName + ".cs";

    public static void GenerateCodes()
    {
        DirectoryInfo dir = new DirectoryInfo(TargetCodeDir);
        if (dir.Exists)
        {
            dir.Delete(true);
        }

        if (!Directory.Exists(TargetCodeDir))
        {
            dir = Directory.CreateDirectory(TargetCodeDir);
        }

        Dictionary<string, string> class2func = new Dictionary<string, string>();
        int classNum = 100;
#if lunplayios2
        classNum = 200;
#endif
        for (int i = 0; i < classNum; i++)
        {
            string codeClass = GetRandomString(5, false, true, true, false, "");
            string codeFunc = GetRandomString(10, false, true, true, false, "");

            if(!class2func.ContainsKey(codeClass))
            {
                class2func[codeClass] = codeFunc;
                CreateNewClassFile(codeClass, codeFunc);
            }
        }

        string code = "public static class " + CodeInvokeClassName + "\n{\n";
        code += "\tpublic static void Invoke()\n\t{\n";
        foreach (KeyValuePair<string, string> pair in class2func)
        {
            code += System.String.Format("\t\t{0}.{1}{2}", pair.Key, pair.Value, "();\n");
        }
        code += "\t}\n";
        code += "}\n";

        using (StreamWriter writer = new StreamWriter(CodeInvokeClass, false))
        {
            try
            {
                writer.WriteLine("{0}", code);
            }
            catch (System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
            }
        }

        System.Threading.Thread.Sleep(1000);
        AssetDatabase.Refresh();
    }

    private static string CreateNewClassFile(string codeClass, string codeFunc)
    {
        string classFilePath = TargetCodeDir + "/" + codeClass + ".cs";
        using (StreamWriter writer = new StreamWriter(classFilePath, false))
        {
            try
            {
                string code = GenerateCode(codeClass, codeFunc);
                writer.WriteLine("{0}", code);
            }
            catch (System.Exception ex)
            {
                string msg = " threw:\n" + ex.ToString();
                Debug.LogError(msg);
            }
        }
        return classFilePath;
    }

    private static string GenerateCode(string ClassName, string funcName)
    {
        string code = "public static class " + ClassName + "\n{\n";
        code += System.String.Format("\tpublic static void {0}{1}", funcName, "(){}");
        code += "\n}\n";
        return code;
    }

    private static string GetRandomString(int length, bool useNum, bool useLow, bool useUpp, bool useSpe, string custom)
    {
        byte[] b = new byte[4];
        new System.Security.Cryptography.RNGCryptoServiceProvider().GetBytes(b);
        System.Random r = new System.Random(BitConverter.ToInt32(b, 0));
        string s = null, str = custom;
        if (useNum == true) { str += "0123456789"; }
        if (useLow == true) { str += "abcdefghijklmnopqrstuvwxyz"; }
        if (useUpp == true) { str += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; }
        if (useSpe == true) { str += "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"; }
        for (int i = 0; i < length; i++)
        {
            s += str.Substring(r.Next(0, str.Length - 1), 1);
        }
        return s;
    }
}
