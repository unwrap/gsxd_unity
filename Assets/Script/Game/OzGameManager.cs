using UnityEngine;

[SLua.CustomLuaClass]
public class OzGameManager : LuaMonoBehaviourBase
{
    public static OzGameManager Instance
    {
        get
        {
            return OzSingleton.GetSingleTon<OzGameManager>();
        }
    }

    private static string FuncOnApplicationPause = "OnApplicationPause";
    private static string FuncOnApplicationQuit = "OnApplicationQuit";

    public void Init() { }

    protected override void Awake()
    {
        m_LuaClassName = "game.LuaGameManager";
        base.Awake();
    }

    protected override void OnDestroy()
    {
        LocalizationImporter.OnDestroy();
        base.OnDestroy();
    }

    private void OnApplicationPause(bool pauseStatus)
    {
        CallMethod(FuncOnApplicationPause, pauseStatus);
    }

    private void OnApplicationQuit()
    {
        CallMethod(FuncOnApplicationQuit);
    }

#if UNITY_EDITOR
    [SLua.DoNotToLua]
    private void SendApplicationPauseMessage(bool isPause)
    {
        Transform[] transList = GameObject.FindObjectsOfType<Transform>();
        for (int i = 0; i < transList.Length; i++)
        {
            Transform trans = transList[i];
            //Note that messages will not be sent to inactive objects
            trans.SendMessage("OnApplicationPause", isPause, SendMessageOptions.DontRequireReceiver);
        }
    }

    [SLua.DoNotToLua]
    private void SendApplicationFocusMessage(bool isFocus)
    {
        Transform[] transList = GameObject.FindObjectsOfType<Transform>();
        for (int i = 0; i < transList.Length; i++)
        {
            Transform trans = transList[i];
            //Note that messages will not be sent to inactive objects
            trans.SendMessage("OnApplicationFocus", isFocus, SendMessageOptions.DontRequireReceiver);
        }
    }

    [SLua.DoNotToLua]
    public void SendEnterBackgroundMessage()
    {
        SendApplicationPauseMessage(true);
        SendApplicationFocusMessage(false);
    }

    [SLua.DoNotToLua]
    public void SendEnterForegroundMessage()
    {
        SendApplicationFocusMessage(true);
        SendApplicationPauseMessage(false);
    }
#endif
}
