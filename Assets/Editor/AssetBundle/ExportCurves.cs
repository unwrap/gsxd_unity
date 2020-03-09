using System.IO;
using UnityEditor;
using UnityEngine;

public class ExportCurves
{
    public static void ExportGameCurve(AnimationCurve[] curves)
    {
        GameCurve gc = GameCurve.CreateInstance<GameCurve>();
        gc.curves = curves;
        AssetDatabase.CreateAsset(gc, "Assets/RawResources/Scene/Animation/game_curve.asset");
    }
}
