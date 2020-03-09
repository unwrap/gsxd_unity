using UnityEngine;
using System.Collections;

[SLua.CustomLuaClass]
public class LuaCameraMonoBehaviour : LuaMonoBehaviourBase
{
    protected void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        CallMethod(LuaMonoMethod.OnRenderImage, source, destination);
    }
}
