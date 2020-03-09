using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class EditorBase : Editor
{
    Dictionary<string, SerializedProperty> props = new Dictionary<string, SerializedProperty>();

    private static GUIContent content = new GUIContent();
    private static GUILayoutOption[] noOptions = new GUILayoutOption[0];

    public sealed override void OnInspectorGUI()
    {
        EditorGUI.indentLevel = 0;
        serializedObject.Update();
        Inspector();
        serializedObject.ApplyModifiedProperties();
    }

    protected virtual void Inspector()
    {

    }

    protected SerializedProperty FindProperty(string name)
    {
        SerializedProperty res;
        if(!props.TryGetValue(name, out res))
        {
            res = props[name] = serializedObject.FindProperty(name);
        }
        if(res == null)
        {
            throw new System.ArgumentException(name);
        }
        return res;
    }

    protected void Section(string label)
    {
        EditorGUILayout.Separator();
        EditorGUILayout.LabelField(label, EditorStyles.boldLabel);
    }

    protected void FloatField(string propertyPath, string label = null, string tooltip = null, float min = float.NegativeInfinity, float max = float.PositiveInfinity)
    {
        PropertyField(propertyPath, label, tooltip);
        Clamp(propertyPath, min, max);
    }

    protected bool PropertyField(string propertyPath, string label = null, string tooltip = null)
    {
        return PropertyField(FindProperty(propertyPath), label, tooltip, propertyPath);
    }

    protected bool PropertyField(SerializedProperty prop, string label = null, string tooltip = null)
    {
        return PropertyField(prop, label, tooltip, prop.propertyPath);
    }

    protected bool PropertyField(SerializedProperty prop, string label, string tooltip, string propertyPath)
    {
        content.text = label ?? prop.displayName;
        content.tooltip = tooltip;
        EditorGUILayout.PropertyField(prop, content, true, noOptions);
        return prop.propertyType == SerializedPropertyType.Boolean ? !prop.hasMultipleDifferentValues && prop.boolValue : true;
    }

    protected void Popup(string propertyPath, GUIContent[] options, string label = null)
    {
        SerializedProperty prop = FindProperty(propertyPath);
        content.text = label ?? prop.displayName;
        EditorGUI.BeginChangeCheck();
        EditorGUI.showMixedValue = prop.hasMultipleDifferentValues;
        int newVal = EditorGUILayout.Popup(content, prop.propertyType == SerializedPropertyType.Enum ? prop.enumValueIndex : prop.intValue, options);
        if(EditorGUI.EndChangeCheck())
        {
            if(prop.propertyType == SerializedPropertyType.Enum)
            {
                prop.enumValueIndex = newVal;
            }
            else
            {
                prop.intValue = newVal;
            }
        }
        EditorGUI.showMixedValue = false;
    }

    protected void Mask(string propertyPath, string[] options, string label = null)
    {
        SerializedProperty prop = FindProperty(propertyPath);
        content.text = label ?? prop.displayName;
        EditorGUI.BeginChangeCheck();
        EditorGUI.showMixedValue = prop.hasMultipleDifferentValues;
        int newVal = EditorGUILayout.MaskField(content, prop.intValue, options);
        if(EditorGUI.EndChangeCheck())
        {
            prop.intValue = newVal;
        }
        EditorGUI.showMixedValue = false;
    }

    protected void IntSlider(string propertyPath, int left, int right)
    {
        SerializedProperty prop = FindProperty(propertyPath);
        content.text = prop.displayName;
        EditorGUILayout.IntSlider(prop, left, right, content, noOptions);
    }

    protected void Clamp(string name, float min, float max = float.PositiveInfinity)
    {
        SerializedProperty prop = FindProperty(name);
        if(!prop.hasMultipleDifferentValues)
        {
            prop.floatValue = Mathf.Clamp(prop.floatValue, min, max);
        }
    }

    protected void ClampInt(string name, int min, int max = int.MaxValue)
    {
        SerializedProperty prop = FindProperty(name);
        if(!prop.hasMultipleDifferentValues)
        {
            prop.intValue = Mathf.Clamp(prop.intValue, min, max);
        }
    }
}
