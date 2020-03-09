using UnityEngine;

[SLua.CustomLuaClass]
public class GameCurve : ScriptableObject
{
    public AnimationCurve[] curves;

    private static GameCurve m_instance;
    public static GameCurve Instance
    {
        get
        {
            if (m_instance == null)
            {
                m_instance = AssetBundleManager.LoadAsset("animation/game_curve.u3d", "game_curve", typeof(GameCurve)) as GameCurve;
            }
            return m_instance;
        }
    }

    public AnimationCurve GetCurve(int idx)
    {
        if(idx >=0 || idx < curves.Length)
        {
            return curves[idx];
        }
        return null;
    }
}
