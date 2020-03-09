using UnityEngine;
using System.Collections;
using UnityEngine.UI;

[SLua.CustomLuaClass]
public class Empty4Raycast : MaskableGraphic
{
    protected Empty4Raycast()
    {
        useLegacyMeshGeneration = false;
    }

    protected override void OnPopulateMesh(VertexHelper toFill)
    {
        toFill.Clear();
    }
}
