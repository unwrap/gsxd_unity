using System.Text.RegularExpressions;
using UnityEngine;

[SLua.CustomLuaClass]
public class OzAdsManager : LuaMonoBehaviourBase
{
    public static OzAdsManager Instance
    {
        get
        {
            return OzSingleton.GetSingleTon<OzAdsManager>();
        }
    }

    private string[] scenes;
    private int sceneIndex = 0;
    private string[] sceneNames;

    protected override void Awake()
    {
        this.m_LuaClassName = "game.ads.LuaAdsManager";
        base.Awake();
    }

    private void Log(string message)
    {
        Debug.Log("[TGSDK-Unity]  " + message);
    }

    private bool hasInit
    {
        get
        {
            return scenes != null;
        }
    }

    public void Init(bool debug, string appid)
    {
        /*
        TGSDK.SetDebugModel(debug);
        TGSDK.SDKInitFinishedCallback = (string msg) => {
            TGSDK.TagPayingUser(TGPayingUser.TGMediumPaymentUser, "CNY", 0, 0);
            Log("TGSDK finished : " + msg);
            Debug.Log("TGSDK GetUserGDPRConsentStatus = " + TGSDK.GetUserGDPRConsentStatus());
            TGSDK.SetUserGDPRConsentStatus("yes");
            Debug.Log("TGSDK GetIsAgeRestrictedUser = " + TGSDK.GetIsAgeRestrictedUser());
            TGSDK.SetIsAgeRestrictedUser("no");
            float bannerHeight = (float)(Screen.height) * 0.123f;
            TGSDK.SetBannerConfig("banner0", "TGBannerNormal", 0, Display.main.systemHeight - bannerHeight, Display.main.systemWidth, bannerHeight, 30);
            TGSDK.SetBannerConfig("banner1", "TGBannerNormal", 0, Display.main.systemHeight - 2 * bannerHeight, Display.main.systemWidth, bannerHeight, 30);
            TGSDK.SetBannerConfig("banner2", "TGBannerNormal", 0, Display.main.systemHeight - 3 * bannerHeight, Display.main.systemWidth, bannerHeight, 30);
        };
#if !UNITY_EDITOR
		TGSDK.Initialize (appid);
#endif
        */
    }

    public void PreloadAd()
    {
        /*
        TGSDK.PreloadAdSuccessCallback = (string msg) => {
            Log("PreloadAdSuccessCallback : " + msg);
            if(!string.IsNullOrEmpty(msg))
            {
                scenes = Regex.Split(msg, ",", RegexOptions.IgnoreCase);
                sceneNames = new string[scenes.Length];
                for (int i = 0; i < scenes.Length; i++)
                {
                    string scene = scenes[i];
                    string sceneName = TGSDK.GetSceneNameById(scene);
                    sceneNames[i] = sceneName + "(" + scene.Substring(0, 4) + ")";
                }
            }
        };
        TGSDK.PreloadAdFailedCallback = (string msg) => {
            Log("PreloadAdFailedCallback : " + msg);
            CallMethod("PreloadAdFailedCallback", msg);
        };
        TGSDK.InterstitialLoadedCallback = (string msg) => {
            Log("InterstitialLoadedCallback : " + msg);
            CallMethod("InterstitialLoadedCallback", msg);
        };
        TGSDK.InterstitialVideoLoadedCallback = (string msg) => {
            Log("InterstitialVideoLoadedCallback : " + msg);
            CallMethod("InterstitialVideoLoadedCallback", msg);
        };
        TGSDK.AwardVideoLoadedCallback = (string msg) => {
            Log("AwardVideoLoadedCallback : " + msg);
            CallMethod("AwardVideoLoadedCallback", msg);
        };
        TGSDK.AdShowSuccessCallback = (string scene, string msg) => {
            Log("AdShow : " + scene + " SuccessCallback : " + msg);
            CallMethod("AdShowSuccessCallback", scene, msg);
        };
        TGSDK.AdShowFailedCallback = (string scene, string msg, string err) => {
            Log("AdShow : " + scene + " FailedCallback : " + msg + ", " + err);
            CallMethod("AdShowFailedCallback", scene, msg, err);
        };
        TGSDK.AdCloseCallback = (string scene, string msg, bool award) => {
            Log("AdClose : " + scene + " Callback : " + msg + " Award : " + award);
            CallMethod("AdCloseCallback", scene, msg, award);
        };
        TGSDK.AdClickCallback = (string scene, string msg) => {
            Log("AdClick : " + scene + " Callback : " + msg);
            CallMethod("AdClickCallback", scene, msg);
        };
        TGSDK.PreloadAd();
        */
    }

    public void LastScene()
    {
        if(!this.hasInit)
        {
            return;
        }
        if (sceneIndex > 0)
        {
            sceneIndex--;
        }
    }

    public void NextScene()
    {
        if (!this.hasInit)
        {
            return;
        }
        if (sceneIndex < scenes.Length - 1)
        {
            sceneIndex++;
        }
    }

    public void ShowAd(string scene)
    {
        /*
        if(TGSDK.CouldShowAd(scene))
        {
            TGSDK.ShowAd(scene);
        }
        else
        {
            Log("Scene: " + scene + " could not to show");
        }
        */
    }

    public void ShowAd()
    {
        /*
        if (!this.hasInit)
        {
            return;
        }
        string sceneid = scenes[sceneIndex];
        if (TGSDK.CouldShowAd(sceneid))
        {
            TGSDK.ShowAd(sceneid);
        }
        else
        {
            Log("Scene " + sceneid + " could not to show");
        }
        */
    }

    public void ShowTestView()
    {
        /*
        if (!this.hasInit)
        {
            return;
        }
        string sceneid = scenes[sceneIndex];
        TGSDK.ShowTestView(sceneid);
        */
    }

    public void CloseBanner()
    {
        if (!this.hasInit)
        {
            return;
        }
        /*
        string sceneid = scenes[sceneIndex];
        TGSDK.CloseBanner(sceneid);
        */
    }

}
