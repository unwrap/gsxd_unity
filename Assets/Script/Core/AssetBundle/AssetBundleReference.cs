using UnityEngine;
using System.Collections;

public class AssetBundleReference : MonoBehaviour
{
    public string assetBundleName;

    private void OnDestroy()
    {
        if (!string.IsNullOrEmpty(assetBundleName))
        {
            if (!AssetBundleManager.UnloadAssetBundle(assetBundleName, true, this.gameObject.name))
            {
                //Debug.LogWarningFormat("UnloadAssetBundle: {0} delete error.", assetBundleName);
            }
        }
    }
}
