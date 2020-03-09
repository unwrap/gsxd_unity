using System.Collections.Generic;
using UnityEditor;
using UnityEngine;


namespace PigeonCoopToolkit.Effects.Trails.Editor
{
    [CustomEditor(typeof(Trail))]
    [CanEditMultipleObjects]
    public class TrailEditor : TrailEditor_Base
    {
        protected override void DrawTrailSpecificGUI()
        {
            EditorGUILayout.PropertyField(serializedObject.FindProperty("MinVertexDistance"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("MaxNumberOfPoints"));
        }
    }
}
