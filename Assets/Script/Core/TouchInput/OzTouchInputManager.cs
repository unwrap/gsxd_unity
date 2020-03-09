using UnityEngine;
using System.Collections;
using System;
using System.Collections.Generic;

[SLua.CustomLuaClass]
public class OzTouchInputManager
{
    #region Delegate & Event

    public delegate void TouchInputEvent(Vector2 pos);
    public delegate void TouchInputPinchEvent(float d);

    #endregion

    #region
    private static List<OzTouchInput> list = new List<OzTouchInput>();

    public static void RegisterTouchInput(OzTouchInput input)
    {
        if (list.Contains(input) == false)
            list.Add(input);
    }

    public static void UnregisterTouchInput(OzTouchInput input)
    {
        list.Remove(input);
    }

    public static bool CheckPosition(OzTouchInput target, Vector2 pos)
    {
        if (target == null)
        {
            return false;
        }
        foreach (OzTouchInput input in list)
        {
            if (input == null)
            {
                continue;
            }
            if (input == target)
            {
                continue;
            }
            if (input.CheckPosition(pos))
            {
                return true;
            }
        }
        return false;
    }
    #endregion
}
