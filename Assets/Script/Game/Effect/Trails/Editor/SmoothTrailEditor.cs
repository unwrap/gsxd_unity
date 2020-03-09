using System.Collections.Generic;
using UnityEditor;
using UnityEngine;


namespace PigeonCoopToolkit.Effects.Trails.Editor
{
    [CustomEditor(typeof(SmoothTrail))]
    [CanEditMultipleObjects]
    public class SmoothTrailEditor : TrailEditor_Base
    {
        protected override void DrawTrailSpecificGUI()
        {
            EditorGUILayout.PropertyField(serializedObject.FindProperty("MinControlPointDistance"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("MaxControlPoints"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("PointsBetweenControlPoints"));
        }
    }
}
