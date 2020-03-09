using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;

public static class BetterDefinesUtils
{
    public const string DEBUG_PROFILER = "DEBUG_PROFILER";
    public const string BANSHU = "BANSHU";

    public static void AddProfiler()
    {
        BetterDefinesUtils.ToggleDefine(DEBUG_PROFILER, true, EditorUserBuildSettings.selectedBuildTargetGroup);
    }

    public static void RemoveProfiler()
    {
        BetterDefinesUtils.ToggleDefine(DEBUG_PROFILER, false, EditorUserBuildSettings.selectedBuildTargetGroup);
    }

    public static void AddBanShuDefine()
    {
        BetterDefinesUtils.ToggleDefine(BANSHU, true, EditorUserBuildSettings.selectedBuildTargetGroup);
    }

    public static void RemoveBanShuDefine()
    {
        BetterDefinesUtils.ToggleDefine(BANSHU, false, EditorUserBuildSettings.selectedBuildTargetGroup);
    }

    public static void ToggleDefine(string define, bool enable, BuildTargetGroup targetPlatform)
    {
        var scriptDefines = PlayerSettings.GetScriptingDefineSymbolsForGroup(targetPlatform);
        var flags = new List<string>(scriptDefines.Split(';'));

        if (flags.Contains(define))
        {
            if (!enable)
            {
                flags.Remove(define);
            }
        }
        else
        {
            if (enable)
            {
                flags.Add(define);
            }
        }

        var result = string.Join(";", flags.ToArray());

        if (scriptDefines != result)
        {
            PlayerSettings.SetScriptingDefineSymbolsForGroup(targetPlatform, result);
        }
    }
}
