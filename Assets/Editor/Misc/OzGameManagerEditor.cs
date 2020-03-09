using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(OzGameManager))]
public class OzGameManagerEditor : Editor
{
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();
        serializedObject.Update();
        serializedObject.ApplyModifiedProperties();

        OzGameManager mgr = target as OzGameManager;
        if(GUILayout.Button("Enter Background"))
        {
            mgr.SendEnterBackgroundMessage();
        }
        if(GUILayout.Button("Enter Foreground"))
        {
            mgr.SendEnterForegroundMessage();
        }
    }
}
