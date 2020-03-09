using UnityEngine;
using System.Collections.Generic;

[SLua.CustomLuaClass]
public class OzDebug:MonoBehaviour
{
    static List<string> mLines = new List<string>();
    static OzDebug mInstance = null;

    private static float mTimer;

    static public void CreateInstance()
    {
        if ( mInstance == null )
        {
            GameObject go = new GameObject( "_OzDebug" );
            mInstance = go.AddComponent<OzDebug>();
            DontDestroyOnLoad( go );
        }
    }

    private static void LogString( string text )
    {
        int lineCount = 20;
        if ( Application.isPlaying )
        {
            if (mLines.Count >= lineCount) mLines.RemoveAt(0);
            mLines.Add( text );
            CreateInstance();
            mTimer = 0.0f;
        }
        else
        {
            Debug.Log( text );
        }
    }

    public static void Clear()
    {
        mTimer = -1.0f;
        mLines.Clear();
    }

    static public void Log( params object[] objs )
    {
        string text = "";

        for ( int i = 0; i < objs.Length; ++i )
        {
            if ( i == 0 )
            {
                text += objs[ i ].ToString();
            }
            else
            {
                text += ", " + objs[ i ].ToString();
            }
        }
        LogString( text );
    }

    private void Update()
    {
        if ( mTimer >= 0.0f )
        {
            mTimer += Time.deltaTime;
            if ( mTimer > 10.0f )
            {
                mTimer = -1.0f;
                mLines.Clear();
            }
        }
    }

    void OnGUI()
    {
        if ( mLines.Count != 0 )
        {
            for ( int i = 0, imax = mLines.Count; i < imax; ++i )
            {
                GUILayout.Label(mLines[i], GUILayout.Width(640f));
            }
        }
    }
}
