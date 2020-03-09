using UnityEngine;
using System.Collections;

[SLua.CustomLuaClass]
public static class Ease
{
    public static float Loop(float duration, float from, float to, float offsetPercent)
    {
        var range = to - from;
        var total = (Time.time + duration * offsetPercent) * (Mathf.Abs(range) / duration);
        if (range > 0)
            return from + Time.time - (range * Mathf.FloorToInt((Time.time / range)));
        else
            return from - (Time.time - (Mathf.Abs(range) * Mathf.FloorToInt((total / Mathf.Abs(range)))));
    }
    public static float Loop(float duration, float from, float to)
    {
        return Loop(duration, from, to, 0);
    }

    public static float Wave(float duration, float from, float to, float offsetPercent)
    {
        var range = (to - from) / 2;
        return from + range + Mathf.Sin(((Time.time + duration * offsetPercent) / duration) * (Mathf.PI * 2)) * range;
    }
    public static float Wave(float duration, float from, float to)
    {
        return Wave(duration, from, to, 0);
    }

    public static float Linear(float t) { return t; }
    public static float QuadIn(float t) { return t * t; }
    public static float QuadOut(float t) { return 1 - QuadIn(1 - t); }
    public static float QuadInOut(float t) { return (t <= 0.5f) ? QuadIn(t * 2) / 2 : QuadOut(t * 2 - 1) / 2 + 0.5f; }
    public static float CubeIn(float t) { return t * t * t; }
    public static float CubeOut(float t) { return 1 - CubeIn(1 - t); }
    public static float CubeInOut(float t) { return (t <= 0.5f) ? CubeIn(t * 2) / 2 : CubeOut(t * 2 - 1) / 2 + 0.5f; }
    public static float BackIn(float t) { return t * t * (2.70158f * t - 1.70158f); }
    public static float BackOut(float t) { return 1 - BackIn(1 - t); }
    public static float BackInOut(float t) { return (t <= 0.5f) ? BackIn(t * 2) / 2 : BackOut(t * 2 - 1) / 2 + 0.5f; }
    public static float ExpoIn(float t) { return (float)Mathf.Pow(2, 10 * (t - 1)); }
    public static float ExpoOut(float t) { return 1 - ExpoIn(t); }
    public static float ExpoInOut(float t) { return t < .5f ? ExpoIn(t * 2) / 2 : ExpoOut(t * 2) / 2; }
    public static float SineIn(float t) { return -Mathf.Cos(Mathf.PI / 2 * t) + 1; }
    public static float SineOut(float t) { return Mathf.Sin(Mathf.PI / 2 * t); }
    public static float SineInOut(float t) { return -Mathf.Cos(Mathf.PI * t) / 2f + .5f; }
    public static float ElasticIn(float t) { return 1 - ElasticOut(1 - t); }
    public static float ElasticOut(float t) { return Mathf.Pow(2, -10 * t) * Mathf.Sin((t - 0.075f) * (2 * Mathf.PI) / 0.3f) + 1; }
    public static float ElasticInOut(float t) { return (t <= 0.5f) ? ElasticIn(t * 2) / 2 : ElasticOut(t * 2 - 1) / 2 + 0.5f; }

    public static float Spring(float t)
    {
        t = Mathf.Clamp01(t);
        t = (Mathf.Sin(t * Mathf.PI * (.2f + 2.5f * t * t * t)) * Mathf.Pow(1f - t, 2.2f) + t) * (1f + (1.2f * (1f - t)));
        return t;
    }

    public static Vector3 BSplineCurve(Vector3 form, Vector3 to, Vector3 off, float t)
    {
        Vector3 zero = Vector3.zero;
        zero.x = Mathf.Pow(1f - t, 2f) * form.x + 2f * t * (1f - t) * off.x + Mathf.Pow(t, 2f) * to.x;
        zero.y = Mathf.Pow(1f - t, 2f) * form.y + 2f * t * (1f - t) * off.y + Mathf.Pow(t, 2f) * to.y;
        zero.z = Mathf.Pow(1f - t, 2f) * form.z + 2f * t * (1f - t) * off.z + Mathf.Pow(t, 2f) * to.z;
        return zero;
    }
}
