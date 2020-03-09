using UnityEngine;
using System.Collections;
using UnityEditor.UI;
using UnityEditor;

[CustomEditor(typeof(EffectController))]
public class EffectControllerEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        if (GUILayout.Button("play", GUILayout.Width(255)))
        {
            EffectController effect = target as EffectController;
            if (effect != null)
            {
                effect.Play();
                Debug.Log(effect.EffectTime);
            }
        }
    }
}