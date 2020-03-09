using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class GameStartController : MonoBehaviour
{
    [SerializeField]
    private Text m_tickText;
    [SerializeField]
    private AnimatedProgressbar m_progressBar;

    private string m_tickOriginalTxt;
    private bool isProgressAnim = false;
    private float progressTime = 3.0f;
    private float progressTimer = 0.0f;

    private void Start()
    {
        InitBuglySDK();
        Screen.sleepTimeout = UnityEngine.SleepTimeout.NeverSleep;

        this.m_tickOriginalTxt = this.m_tickText.text;
        this.m_progressBar.fillAmount = 0.0f;

        Transform versionTextObjTrans = this.transform.Find("bottom/VersionText");
        if (versionTextObjTrans != null)
        {
            GameObject versionTextObj = versionTextObjTrans.gameObject;
            Text versionText = versionTextObj.GetComponent<Text>();
            if (versionText != null)
            {
                versionText.text = string.Empty;
            }
        }

        this.isProgressAnim = true;
        this.progressTimer = 0.0f;

        EnterGame();
    }

    private void InitBuglySDK()
    {
        BuglyAgent.ConfigDebugMode(false);
        BuglyAgent.InitWithAppId("004e85ad39");

        BuglyAgent.EnableExceptionHandler();
        BuglyAgent.PrintLog(LogSeverity.LogInfo, "Init the bugly sdk");

        // set tag
#if UNITY_ANDROID
        BuglyAgent.SetScene(3450);
#else
        BuglyAgent.SetScene(3261);
#endif
    }

    private void EnterGame()
    {
        StartCoroutine(Initialize());
    }

    private IEnumerator Initialize()
    {
        AssetBundleLoadAssetOperation request = AssetBundleManager.Initialize();
        yield return request;
        OzLuaManager.Instance.Init(this.LuaBindProgress);
    }

    private void LuaBindProgress(int tick)
    {
        float t = (tick / 100.0f);
        if(this.m_tickText != null)
        {
            this.m_tickText.text = string.Format(LocalizedString.LOAD_RESOURCES, Mathf.CeilToInt(t * 100));
        }
        if (this.m_progressBar != null)
        {
            this.m_progressBar.fillAmount = t;
        }
    }
}
