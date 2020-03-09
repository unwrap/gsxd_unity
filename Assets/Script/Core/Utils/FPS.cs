using UnityEngine;
using System.Collections;

[SLua.CustomLuaClass]
public class FPS : MonoBehaviour
{
    public static FPS Instance
    {
        get
        {
            return OzSingleton.GetSingleTon<FPS>();
        }
    }

    private string sFPS = "";

    private GUIStyle mGUIStyle;
    private Rect mPosition;

    private float m_lastUpdateShowTime = 0.0f; //上一次更新帧率的时间;
    private float m_updateShowDeltaTime = 0.01f;//更新帧率的时间间隔;
    private int m_frameUpdate = 0;//帧数;
    private float m_fps = 0;

    private int frameRange = 60;
    private int averageFps = 0;
    private int[] fpsBuffer;
    private int fpsBufferIndex;
    private int highestFps;
    private int lowestFps;

    public string gameFPS
    {
        get
        {
            return sFPS;
        }
    }

    public void Init()
    {

    }

    private void Start()
    {
        int width = Screen.width;
        int height = Screen.height;
        mGUIStyle = new GUIStyle();
        int h = (height * 2 / 150);
        mPosition = new Rect(0f, height - h, (float)width, (float)h);
        mGUIStyle.alignment = TextAnchor.LowerLeft;
        mGUIStyle.fontSize = h;
        mGUIStyle.normal.textColor = Color.red;

        m_lastUpdateShowTime = Time.realtimeSinceStartup;
    }

    private void Update()
    {
        m_frameUpdate++;
        if(Time.realtimeSinceStartup - m_lastUpdateShowTime >= m_updateShowDeltaTime)
        {
            m_fps = m_frameUpdate / (Time.realtimeSinceStartup - m_lastUpdateShowTime);
            m_frameUpdate = 0;
            m_lastUpdateShowTime = Time.realtimeSinceStartup;
        }

        if(fpsBuffer == null || fpsBuffer.Length != frameRange)
        {
            InititalizeBuffer();
        }
        UpdateBuffer();
        CalcalateFps();

        sFPS = averageFps + "fps - " + m_fps.ToString("f" + Mathf.Clamp(1, 0, 10)); ; 
    }

    private void InititalizeBuffer()
    {
        if (frameRange <= 0)
        {
            frameRange = 1;
        }
        fpsBuffer = new int[frameRange];
        fpsBufferIndex = 0;
    }

    private void UpdateBuffer()
    {
        fpsBuffer[fpsBufferIndex++] = (int)(1f / Time.unscaledDeltaTime);
        if(fpsBufferIndex >= frameRange)
        {
            fpsBufferIndex = 0;
        }
    }

    private void CalcalateFps()
    {
        int sum = 0;
        for(int i = 0; i < frameRange; i++)
        {
            sum += fpsBuffer[i];
        }
        averageFps = sum / frameRange;
    }

    private void OnGUI()
    {
        GUI.Label(mPosition, sFPS, mGUIStyle);
    }
}
