using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameBootstrap : MonoBehaviour
{
    private void Start()
    {
        string strObj = "bootstrap";

        GameObject obj = AssetBundleManager.InstantiateGameObject("bootstrap/bootstrap.u3d", strObj);
        obj.name = "bootstrap";
        RectTransform objTrans = obj.AddMissingComponent<RectTransform>();
        objTrans.SetParent(this.transform, false);
        objTrans.offsetMax = Vector2.zero;
        objTrans.offsetMin = Vector2.zero;
        objTrans.anchorMin = Vector2.zero;
        objTrans.anchorMax = Vector2.one;
        GameUtil.SetLayer(objTrans, 5);
    }
}
