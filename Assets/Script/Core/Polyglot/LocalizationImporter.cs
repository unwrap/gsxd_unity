using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System;
using System.IO;
using System.Text.RegularExpressions;
using SLua;

[SLua.CustomLuaClass]
public static class LocalizationImporter
{
    private static Dictionary<string, string> languageStrings = new Dictionary<string, string>();

    private static string EmptyList = string.Empty;

    private static LuaFunction mTable;

    public static void RegisterLuaFunction(LuaFunction target)
    {
        mTable = target;
    }

    public static void OnDestroy()
    {
        mTable = null;
    }

    public static void Refresh()
    {
        languageStrings.Clear();
        PopulateLanguageStrings();
    }

    public static bool IsLineBreak(string currentString)
    {
        return currentString.Length == 1 && (currentString[0] == '\r' || currentString[0] == '\n')
            || currentString.Length == 2 && currentString.Equals(Environment.NewLine);
    }

    public static string GetLanguages(string key)
    {
        if (string.IsNullOrEmpty(key))
        {
            return EmptyList;
        }
        try
        {
            int intKey = int.Parse(key);
            if (mTable != null)
            {
                return mTable.call(intKey).ToString();
            }
        }
        catch
        {
            return EmptyList;
        }

        if (languageStrings == null || languageStrings.Count == 0)
        {
            PopulateLanguageStrings();
        }
        if (string.IsNullOrEmpty(key) || !languageStrings.ContainsKey(key))
        {
            return EmptyList;
        }

        return languageStrings[key];
    }

#if UNITY_EDITOR
    [DoNotToLua]
    public static Dictionary<string, string> GetLanguagesStartsWith(string key)
    {
        if (languageStrings == null || languageStrings.Count == 0)
        {
            PopulateLanguageStrings();
        }

        Dictionary<string, string> multipleLanguageStrings = new Dictionary<string, string>();
        foreach (KeyValuePair<string, string> languageString in languageStrings)
        {
            if (languageString.Key.ToLower().StartsWith(key.ToLower()))
            {
                multipleLanguageStrings.Add(languageString.Key, languageString.Value);
            }
        }

        return multipleLanguageStrings;
    }

    [DoNotToLua]
    public static Dictionary<string, string> GetLanguagesContains(string key)
    {
        if (languageStrings == null || languageStrings.Count == 0)
        {
            PopulateLanguageStrings();
        }

        Dictionary<string, string> multipleLanguageStrings = new Dictionary<string, string>();
        foreach (KeyValuePair<string, string> languageString in languageStrings)
        {
            if (languageString.Key.ToLower().Contains(key.ToLower()))
            {
                multipleLanguageStrings.Add(languageString.Key, languageString.Value);
            }
        }

        return multipleLanguageStrings;
    }

    [DoNotToLua]
    public static Dictionary<string, string> GetLanguageValues(string val)
    {
        if (languageStrings == null || languageStrings.Count == 0)
        {
            PopulateLanguageStrings();
        }

        Dictionary<string, string> multipleLanguageStrings = new Dictionary<string, string>();
        foreach (KeyValuePair<string, string> languageString in languageStrings)
        {
            if (languageString.Value.Contains(val))
            {
                multipleLanguageStrings.Add(languageString.Key, languageString.Value);
            }
        }

        return multipleLanguageStrings;
    }

#endif

    private static void PopulateLanguageStrings()
    {
        if (mTable != null)
        {
            return;
        }
#if UNITY_EDITOR
        string localizationCfgPath = Path.GetFullPath(Path.Combine(Application.dataPath, "Config/config/cfg_localization.lua"));
        string[] strLines = File.ReadAllLines(localizationCfgPath);
        Regex reg = new Regex(@"\{(.*)\}");
        Regex idReg = new Regex("id = ([0-9]*),");
        Regex desReg = new Regex("content = \"(.*)\"");
        for (int i = 0; i < strLines.Length; i++)
        {
            string strLine = strLines[i];
            foreach (Match m in reg.Matches(strLine))
            {
                string strValue = m.Value;
                Match idMatch = idReg.Match(strValue);
                Match desMatch = desReg.Match(strValue);
                if (idMatch.Success && desMatch.Success)
                {
                    string strKey = idMatch.Result("$1");
                    string strDes = desMatch.Result("$1");
                    strDes = strDes.Replace("\\n", "\n");

                    if (languageStrings.ContainsKey(strKey))
                    {
                        Debug.Log("The key '" + strKey + "' already exist, but is now overwritten by (" + strDes + ")");
                        languageStrings[strKey] = strDes;
                        continue;
                    }
                    languageStrings.Add(strKey, strDes);
                }
            }
        }
#endif
    }
}
