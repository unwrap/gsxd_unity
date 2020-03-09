using System.Collections.Generic;
using UnityEditor;
using UnityEditor.AnimatedValues;
using UnityEngine;

[CustomEditor(typeof(LocalizedText))]
[CanEditMultipleObjects]
public class LocalizedTextEditor : Editor
{
    private Vector2 scrollValues;
    private AnimBool showValuesAutoComplete;

    private string zhString;

    private GUIStyle contentStyle;

    public void OnEnable()
    {
        showValuesAutoComplete = new AnimBool(true);
        showValuesAutoComplete.valueChanged.AddListener(Repaint);

        contentStyle = EditorStyles.miniButtonLeft;
        contentStyle.fontSize = 12;
        contentStyle.alignment = TextAnchor.MiddleLeft;
    }

    private void DrawValuesAutoComplete(SerializedProperty property, string stringValue)
    {
        Dictionary<string, string> localizedStrings = LocalizationImporter.GetLanguageValues(stringValue);
        if (localizedStrings.Count == 0)
        {
            localizedStrings = LocalizationImporter.GetLanguagesContains(stringValue);
        }

        showValuesAutoComplete.target = EditorGUILayout.Foldout(showValuesAutoComplete.target, "Auto-Complete");
        if (EditorGUILayout.BeginFadeGroup(showValuesAutoComplete.faded))
        {
            EditorGUI.indentLevel++;
            float height = EditorGUIUtility.singleLineHeight * (Mathf.Min(localizedStrings.Count, 6) + 1);
            this.scrollValues = EditorGUILayout.BeginScrollView(this.scrollValues, GUILayout.Height(height));
            foreach (KeyValuePair<string, string> local in localizedStrings)
            {
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel(local.Key);
                if (GUILayout.Button(local.Value, contentStyle))
                {
                    property.stringValue = local.Key;
                    this.zhString = local.Value;
                    GUIUtility.hotControl = 0;
                    GUIUtility.keyboardControl = 0;
                }
                EditorGUILayout.EndHorizontal();
            }
            EditorGUILayout.EndScrollView();
            EditorGUI.indentLevel--;
        }
        EditorGUILayout.EndFadeGroup();
    }

    public override void OnInspectorGUI()
    {
        EditorGUI.BeginChangeCheck();

        serializedObject.Update();

        SerializedProperty iterator = serializedObject.GetIterator();

        LocalizedText text = target as LocalizedText;
        if (text != null)
        {
            if (this.zhString != text.GetText())
            {
                this.zhString = text.GetText();
            }
            text.SerializeZhText(this.zhString);
        }

        for (bool enterChildren = true; iterator.NextVisible(enterChildren); enterChildren = false)
        {
            if (iterator.name == "m_zhText")
            {
                EditorGUILayout.LabelField("zhText", iterator.stringValue, new GUILayoutOption[0]);
            }
            else if (iterator.name == "m_key")
            {
                EditorGUILayout.PropertyField(iterator, true, new GUILayoutOption[0]);
                string key = iterator.stringValue;
                string localizedString = LocalizationImporter.GetLanguages(key);
                if (string.IsNullOrEmpty(zhString))
                {
                    zhString = localizedString;
                }
                EditorGUILayout.LabelField("中文", localizedString, new GUILayoutOption[0]);
                if (!string.IsNullOrEmpty(zhString) && zhString != localizedString)
                {
                    DrawValuesAutoComplete(iterator, zhString);
                }
            }
        }

        serializedObject.ApplyModifiedProperties();

        if (EditorGUI.EndChangeCheck())
        {
            if (text != null)
            {
                text.OnLocalize();
            }
        }
    }
}
