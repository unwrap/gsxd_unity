using UnityEngine;
using System.Collections;
using System;
using UnityEditor;

public struct CustomEditorGUI : IDisposable
{
    private static GUIStyle toolbar;
    internal static GUIStyle Toolbar
    {
        get
        {
            if (toolbar == null)
            {
                toolbar = new GUIStyle(EditorStyles.toolbar);
                toolbar.margin.top++;
            }

            return toolbar;
        }
    }

    private static GUIStyle compactButton;
    internal static GUIStyle CompactButton
    {
        get
        {
            if (compactButton == null)
            {
                compactButton = new GUIStyle(GUI.skin.button);
                compactButton.margin = RichLabel.margin;
                compactButton.overflow = RichLabel.overflow;
                compactButton.padding = new RectOffset(5, 5, 1, 4);
                compactButton.margin = new RectOffset(2, 2, 3, 2);
                compactButton.richText = true;
            }

            return compactButton;
        }
    }

    private static GUIStyle line;
    internal static void Separator()
    {
        if (line == null)
        {
            line = new GUIStyle(GUI.skin.box);
            line.border.top = line.border.bottom = 1;
            line.margin.top = line.margin.bottom = 1;
            line.padding.top = line.padding.bottom = 1;
        }
        GUILayout.Box(GUIContent.none, line, GUILayout.ExpandWidth(true), GUILayout.Height(1f));
    }

    private static GUIStyle richLabel;
    internal static GUIStyle RichLabel
    {
        get
        {
            if (richLabel == null)
            {
                richLabel = new GUIStyle(EditorStyles.label);
                richLabel.wordWrap = true;
                richLabel.richText = true;
            }

            return richLabel;
        }
    }

    private static GUIStyle centeredLabel;
    internal static GUIStyle CenteredLabel
    {
        get
        {
            if (centeredLabel == null)
            {
                centeredLabel = new GUIStyle(RichLabel);
                centeredLabel.alignment = TextAnchor.MiddleCenter;
            }

            return centeredLabel;
        }
    }

    private static GUIStyle toolbarSeachTextField;
    internal static GUIStyle ToolbarSeachTextField
    {
        get
        {
            if (toolbarSeachTextField == null)
            {
                toolbarSeachTextField = GetBuiltinStyle("ToolbarSeachTextField");
            }

            return toolbarSeachTextField;
        }
    }

    private static GUIStyle toolbarSeachCancelButton;
    internal static GUIStyle ToolbarSeachCancelButton
    {
        get
        {
            if (toolbarSeachCancelButton == null)
            {
                toolbarSeachCancelButton = GetBuiltinStyle("ToolbarSeachCancelButton");
            }

            return toolbarSeachCancelButton;
        }
    }

    private static GUIStyle toolbarSeachCancelButtonEmpty;
    internal static GUIStyle ToolbarSeachCancelButtonEmpty
    {
        get
        {
            if (toolbarSeachCancelButtonEmpty == null)
            {
                toolbarSeachCancelButtonEmpty = GetBuiltinStyle("ToolbarSeachCancelButtonEmpty");
            }

            return toolbarSeachCancelButtonEmpty;
        }
    }

    private static GUIStyle panelWithBackground;
    internal static GUIStyle PanelWithBackground
    {
        get
        {
            if (panelWithBackground == null)
            {
                panelWithBackground = new GUIStyle(GUI.skin.box);
                panelWithBackground.padding = new RectOffset();
            }

            return panelWithBackground;
        }
    }

    private static GUIStyle GetBuiltinStyle(string name)
    {
        GUIStyle style = GUI.skin.FindStyle(name);
        if (style == null)
        {
            style = EditorGUIUtility.GetBuiltinSkin(EditorSkin.Inspector).FindStyle(name);
        }

        if (style == null)
        {
            style = GUIStyle.none;
            Debug.LogError("Can't find builtin style " + name);
        }

        return style;
    }

    internal static string SearchToolbar(string searchPattern)
    {
        Rect searchFieldRect = EditorGUILayout.GetControlRect(false, ToolbarSeachTextField.lineHeight, ToolbarSeachTextField);
        Rect searchFieldTextRect = searchFieldRect;
        searchFieldTextRect.width -= 14f;

        searchPattern = EditorGUI.TextField(searchFieldTextRect, searchPattern, ToolbarSeachTextField);

        GUILayout.Space(10);

        Rect searchFieldButtonRect = searchFieldRect;
        searchFieldButtonRect.x += searchFieldRect.width - 14f;
        searchFieldButtonRect.width = 14f;

        GUIStyle buttonStyle = string.IsNullOrEmpty(searchPattern) ? ToolbarSeachCancelButtonEmpty : ToolbarSeachCancelButton;
        if (GUI.Button(searchFieldButtonRect, GUIContent.none, buttonStyle) && !string.IsNullOrEmpty(searchPattern))
        {
            searchPattern = string.Empty;
            GUIUtility.keyboardControl = 0;
        }

        return searchPattern;
    }

    private readonly LayoutMode mode;

    internal static CustomEditorGUI Horizontal(params GUILayoutOption[] options)
    {
        return Horizontal(GUIStyle.none, options);
    }

    internal static CustomEditorGUI Horizontal(GUIStyle style, params GUILayoutOption[] options)
    {
        return new CustomEditorGUI(LayoutMode.Horizontal, style, options);
    }

    internal static CustomEditorGUI Vertical(GUIStyle style, params GUILayoutOption[] options)
    {
        return new CustomEditorGUI(LayoutMode.Vertical, style, options);
    }

    private CustomEditorGUI(LayoutMode layoutMode, GUIStyle style, params GUILayoutOption[] options)
    {
        mode = layoutMode;
        if (mode == LayoutMode.Horizontal)
        {
            GUILayout.BeginHorizontal(style, options);
        }
        else
        {
            GUILayout.BeginVertical(style, options);
        }
    }

    public void Dispose()
    {
        if (mode == LayoutMode.Horizontal)
        {
            GUILayout.EndHorizontal();
        }
        else
        {
            GUILayout.EndVertical();
        }
    }

    private enum LayoutMode : byte
    {
        Horizontal,
        Vertical
    }
}
