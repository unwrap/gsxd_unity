using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[SLua.CustomLuaClass]
public static class MathUtil
{
    static int Bit(int a, int b)
    {
        return (a >> b) & 1;
    }

    public static Color IntToColor(int i, float a)
    {
        int r = Bit(i, 2) + Bit(i, 3) * 2 + 1;
        int g = Bit(i, 1) + Bit(i, 4) * 2 + 1;
        int b = Bit(i, 0) + Bit(i, 5) * 2 + 1;

        return new Color(r * 0.25F, g * 0.25F, b * 0.25F, a);
    }

    public static int RandomInt(int min, int max)
    {
        return Random.Range(min, max);
    }
}
