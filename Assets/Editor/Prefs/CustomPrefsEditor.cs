using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;
using System;
using System.Globalization;
using UnityEditor.Callbacks;

#if UNITY_EDITOR_WIN
using Microsoft.Win32;
#elif UNITY_EDITOR_OSX
using System.IO;
#else // LINUX
using System.IO;
using System.Xml;
#endif

public class CustomPrefsEditor : EditorWindow
{
    protected const int RECORDS_PER_PAGE = 50;

    protected const string DEFAULT_STRING = "[^_; = ElinaKristinaMyGirlsLoveYou'16 = ;_^]";
    protected const float DEFAULT_FLOAT = float.MinValue + 2016.0122f;
    protected const int DEFAULT_INT = int.MinValue + 20130524;

    protected const string UNKNOWN_VALUE_DESCRIPTION = "Value corrupted / wrong Unity version";
    protected const string STRING_TOO_LONG = "String is too long";

    private static CustomPrefsEditor instance;

    [SerializeField]
    private SortingType sortingType = SortingType.KeyAscending;

    [SerializeField]
    private string searchPattern;

    [SerializeField]
    private List<PrefsRecord> allRecords;

    [SerializeField]
    private List<PrefsRecord> filteredRecords;

    [SerializeField]
    private Vector2 scrollPosition;

    [SerializeField]
    private int recordsCurrentPage;

    [SerializeField]
    private int recordsTotalPages;

    [SerializeField]
    private bool addingNewRecord;

    [SerializeField]
    private int newRecordType;

    [SerializeField]
    private string newRecordKey;

    [SerializeField]
    private string newRecordStringValue;

    [SerializeField]
    private int newRecordIntValue;

    [SerializeField]
    private float newRecordFloatValue;

    public static void ShowWindow()
    {
        CustomPrefsEditor myself = GetWindow<CustomPrefsEditor>(false, "Prefs Editor", true);
        myself.minSize = new Vector2(500, 300);
        myself.RefreshData();
    }

    [DidReloadScripts]
    private static void OnRecompile()
    {
        if (instance) instance.Repaint();
    }

    private void OnEnable()
    {
        instance = this;
    }

    #region GUI
    private void OnGUI()
    {
        if (allRecords == null) allRecords = new List<PrefsRecord>();
        if (filteredRecords == null) filteredRecords = new List<PrefsRecord>();

        using (CustomEditorGUI.Horizontal(CustomEditorGUI.Toolbar))
        {
            if (GUILayout.Button(new GUIContent("+", "Create new prefs record."), EditorStyles.toolbarButton, GUILayout.Width(20)))
            {
                addingNewRecord = true;
            }

            if (GUILayout.Button(new GUIContent("Refresh", "Re-read and re-parse all prefs."), EditorStyles.toolbarButton, GUILayout.Width(50)))
            {
                RefreshData();
                GUIUtility.keyboardControl = 0;
                scrollPosition = Vector2.zero;
                recordsCurrentPage = 0;
            }

            EditorGUI.BeginChangeCheck();
            sortingType = (SortingType)EditorGUILayout.EnumPopup(sortingType, EditorStyles.toolbarDropDown, GUILayout.Width(110));
            if (EditorGUI.EndChangeCheck())
            {
                ApplySorting();
            }

            GUILayout.Space(10);

            EditorGUI.BeginChangeCheck();
            searchPattern = CustomEditorGUI.SearchToolbar(searchPattern);
            if (EditorGUI.EndChangeCheck())
            {
                ApplyFiltering();
            }
        }

        if (addingNewRecord)
        {
            using (CustomEditorGUI.Horizontal(CustomEditorGUI.PanelWithBackground))
            {
                string[] types = { "String", "Int", "Float" };
                newRecordType = EditorGUILayout.Popup(newRecordType, types, GUILayout.Width(50));
                Color guiColor = GUI.color;

                GUILayout.Label("Key:", GUILayout.ExpandWidth(false));
                newRecordKey = EditorGUILayout.TextField(newRecordKey);
                GUILayout.Label("Value:", GUILayout.ExpandWidth(false));

                if (newRecordType == 0)
                {
                    newRecordStringValue = EditorGUILayout.TextField(newRecordStringValue);
                }
                else if (newRecordType == 1)
                {
                    newRecordIntValue = EditorGUILayout.IntField(newRecordIntValue);
                }
                else
                {
                    newRecordFloatValue = EditorGUILayout.FloatField(newRecordFloatValue);
                }

                GUI.color = guiColor;

                if (GUILayout.Button("OK", CustomEditorGUI.CompactButton, GUILayout.Width(30)))
                {
                    if (string.IsNullOrEmpty(newRecordKey) ||
                            (newRecordType == 0 && string.IsNullOrEmpty(newRecordStringValue)) ||
                            (newRecordType == 1 && newRecordIntValue == 0) ||
                            (newRecordType == 2 && Math.Abs(newRecordFloatValue) < 0.00000001f))
                    {
                        ShowNotification(new GUIContent("Please fill in the pref first!"));
                    }
                    else
                    {
                        PrefsRecord newRecord;

                        if (newRecordType == 0)
                        {
                            newRecord = new PrefsRecord(newRecordKey, newRecordStringValue);
                        }
                        else if (newRecordType == 1)
                        {
                            newRecord = new PrefsRecord(newRecordKey, newRecordIntValue);
                        }
                        else
                        {
                            newRecord = new PrefsRecord(newRecordKey, newRecordFloatValue);
                        }

                        if (newRecord.Save())
                        {
                            allRecords.Add(newRecord);
                            ApplySorting();
                            CloseNewRecordPanel();
                        }
                    }
                }
                if (GUILayout.Button("Cancel", CustomEditorGUI.CompactButton, GUILayout.Width(60)))
                {
                    CloseNewRecordPanel();
                }
            }
        }

        using (CustomEditorGUI.Vertical(CustomEditorGUI.PanelWithBackground))
        {
            GUILayout.Space(5);

            DrawRecordsPages();

            GUILayout.Space(5);
        }
    }

    private void CloseNewRecordPanel()
    {
        addingNewRecord = false;
        newRecordKey = string.Empty;
        newRecordStringValue = string.Empty;
        newRecordIntValue = 0;
        newRecordFloatValue = 0;
        GUIUtility.keyboardControl = 0;
    }

    private void DrawRecordsPages()
    {
        recordsTotalPages = Math.Max(1, (int)Math.Ceiling((double)filteredRecords.Count / RECORDS_PER_PAGE));

        if (recordsCurrentPage < 0) recordsCurrentPage = 0;
        if (recordsCurrentPage + 1 > recordsTotalPages) recordsCurrentPage = recordsTotalPages - 1;

        int fromRecord = recordsCurrentPage * RECORDS_PER_PAGE;
        int toRecord = fromRecord + Math.Min(RECORDS_PER_PAGE, filteredRecords.Count - fromRecord);

        if (recordsTotalPages > 1)
        {
            GUILayout.Label("Prefs " + fromRecord + " - " + toRecord + " from " + filteredRecords.Count);
        }

        scrollPosition = GUILayout.BeginScrollView(scrollPosition);
        for (int i = fromRecord; i < toRecord; i++)
        {
            bool recordRemoved;
            DrawRecord(i, out recordRemoved);
            if (recordRemoved)
            {
                break;
            }
        }
        GUILayout.EndScrollView();

        if (recordsTotalPages <= 1) return;

        GUILayout.Space(5);
        using (CustomEditorGUI.Horizontal())
        {
            GUILayout.FlexibleSpace();

            GUI.enabled = recordsCurrentPage > 0;
            if (GUILayout.Button("<<", GUILayout.Width(50)))
            {
                RemoveNotification();
                recordsCurrentPage = 0;
                scrollPosition = Vector2.zero;
            }
            if (GUILayout.Button("<", GUILayout.Width(50)))
            {
                RemoveNotification();
                recordsCurrentPage--;
                scrollPosition = Vector2.zero;
            }
            GUI.enabled = true;
            GUILayout.Label(recordsCurrentPage + 1 + " of " + recordsTotalPages, CustomEditorGUI.CenteredLabel, GUILayout.Width(100));
            GUI.enabled = recordsCurrentPage < recordsTotalPages - 1;
            if (GUILayout.Button(">", GUILayout.Width(50)))
            {
                RemoveNotification();
                recordsCurrentPage++;
                scrollPosition = Vector2.zero;
            }
            if (GUILayout.Button(">>", GUILayout.Width(50)))
            {
                RemoveNotification();
                recordsCurrentPage = recordsTotalPages - 1;
                scrollPosition = Vector2.zero;
            }
            GUI.enabled = true;

            GUILayout.FlexibleSpace();
        }
    }

    protected void DrawRecord(int recordIndex, out bool recordRemoved)
    {
        recordRemoved = false;
        PrefsRecord record = filteredRecords[recordIndex];

        CustomEditorGUI.Separator();

        using (CustomEditorGUI.Horizontal(CustomEditorGUI.PanelWithBackground))
        {
            if (GUILayout.Button(new GUIContent("X", "Delete this pref."), CustomEditorGUI.CompactButton, GUILayout.Width(20)))
            {
                record.Delete();
                allRecords.Remove(record);
                filteredRecords.Remove(record);
                recordRemoved = true;
                return;
            }

            GUI.enabled = record.dirtyValue || record.dirtyKey && record.prefType != PrefsRecord.PrefsType.Unknown;
            if (GUILayout.Button(new GUIContent("S", "Save changes in this pref."), CustomEditorGUI.CompactButton, GUILayout.Width(20)))
            {
                record.Save();
                GUIUtility.keyboardControl = 0;
            }
            GUI.enabled = true;

            GUI.enabled = record.prefType != PrefsRecord.PrefsType.Unknown;

            GUI.enabled = true;

            if (GUILayout.Button(new GUIContent("...", "Other operations"), CustomEditorGUI.CompactButton, GUILayout.Width(25)))
            {
                ShowOtherMenu(record);
            }

            Color guiColor = GUI.color;

            GUI.enabled = record.prefType != PrefsRecord.PrefsType.Unknown;

            record.Key = EditorGUILayout.TextField(record.Key, GUILayout.MaxWidth(200), GUILayout.MinWidth(50));

            if (record.prefType == PrefsRecord.PrefsType.String)
            {
                // to avoid TextMeshGenerator error because of too much characters
                if (record.StringValue.Length > 16382)
                {
                    GUI.enabled = false;
                    EditorGUILayout.TextField(STRING_TOO_LONG, GUILayout.MinWidth(150));
                    GUI.enabled = record.prefType != PrefsRecord.PrefsType.Unknown;
                }
                else
                {
                    record.StringValue = EditorGUILayout.TextField(record.StringValue, GUILayout.MinWidth(150));
                }
            }
            else if (record.prefType == PrefsRecord.PrefsType.Int)
            {
                record.IntValue = EditorGUILayout.IntField(record.IntValue, GUILayout.MinWidth(150));
            }
            else if (record.prefType == PrefsRecord.PrefsType.Float)
            {
                record.FloatValue = EditorGUILayout.FloatField(record.FloatValue, GUILayout.MinWidth(150));
            }
            else
            {
                GUI.enabled = false;
                EditorGUILayout.TextField(UNKNOWN_VALUE_DESCRIPTION, GUILayout.MinWidth(150));
                GUI.enabled = record.prefType != PrefsRecord.PrefsType.Unknown;
            }
            GUI.color = guiColor;
            GUI.enabled = true;

            EditorGUILayout.LabelField(record.DisplayType, GUILayout.Width(70));
        }
    }

    private void ShowOtherMenu(PrefsRecord record)
    {
        GenericMenu menu = new GenericMenu();
        menu.AddItem(new GUIContent("Copy to clipboard"), false, () =>
        {
            EditorGUIUtility.systemCopyBuffer = record.ToString();
        });
        menu.ShowAsContext();
    }

    #endregion

    #region Data

    private void RefreshData()
    {
        List<string> keys = new List<string>();

#if UNITY_EDITOR_WIN
        keys.AddRange(ReadKeysWin());
#elif UNITY_EDITOR_OSX
			keys.AddRange(ReadKeysOSX());
#else // LINUX
			keys.AddRange(ReadKeysLinux());
#endif

        keys.Remove("UnityGraphicsQuality");
        keys.Remove("UnitySelectMonitor");
        keys.Remove("Screenmanager Resolution Width");
        keys.Remove("Screenmanager Resolution Height");
        keys.Remove("Screenmanager Is Fullscreen mode");
        keys.Remove("unity.cloud_userid");
        keys.Remove("unity.player_session_background_time");
        keys.Remove("unity.player_session_elapsed_time");
        keys.Remove("unity.player_sessionid");

        if (allRecords == null) allRecords = new List<PrefsRecord>();
        if (filteredRecords == null) filteredRecords = new List<PrefsRecord>();

        allRecords.Clear();
        filteredRecords.Clear();

        int keysCount = keys.Count;
        bool showProgress = keysCount >= 500;

        for (int i = 0; i < keysCount; i++)
        {
            string keyName = keys[i];
            if (showProgress)
            {
                if (EditorUtility.DisplayCancelableProgressBar("Reading PlayerPrefs [" + (i + 1) + " of " + keysCount + "]", "Reading " + keyName, (float)i / keysCount))
                {
                    break;
                }
            }
            allRecords.Add(new PrefsRecord(keyName));
        }

        if (showProgress) EditorUtility.ClearProgressBar();

        ApplySorting();
    }

    private void ApplySorting()
    {
        switch (sortingType)
        {
            case SortingType.KeyAscending:
                allRecords.Sort(PrefsRecord.SortByNameAscending);
                break;
            case SortingType.KeyDescending:
                allRecords.Sort(PrefsRecord.SortByNameDescending);
                break;
            case SortingType.Type:
                allRecords.Sort(PrefsRecord.SortByType);
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }

        ApplyFiltering();
    }

    private void ApplyFiltering()
    {
        filteredRecords.Clear();
        if (string.IsNullOrEmpty(searchPattern))
        {
            filteredRecords.AddRange(allRecords);
        }
        else
        {
            for (int i = 0; i < allRecords.Count; i++)
            {
                if (allRecords[i].Key.ToLowerInvariant().Contains(searchPattern.Trim().ToLowerInvariant()))
                {
                    filteredRecords.Add(allRecords[i]);
                }
            }
        }
    }

    #region ReadKeys

#if UNITY_EDITOR_WIN

    private string[] ReadKeysWin()
    {
#if UNITY_5_5_OR_NEWER
		RegistryKey registryLocation = Registry.CurrentUser.CreateSubKey("Software\\Unity\\UnityEditor\\" + PlayerSettings.companyName + "\\" + PlayerSettings.productName);
#else
        RegistryKey registryLocation = Registry.CurrentUser.CreateSubKey("Software\\" + PlayerSettings.companyName + "\\" + PlayerSettings.productName);
#endif
        if (registryLocation == null)
        {
            return new string[0];
        }

        string[] names = registryLocation.GetValueNames();
        string[] result = new string[names.Length];

        for (int i = 0; i < names.Length; i++)
        {
            string key = names[i];
            if (key.IndexOf('_') > 0)
            {
                result[i] = key.Substring(0, key.LastIndexOf('_'));
            }
            else
            {
                result[i] = key;
            }
        }

        return result;
    }

#elif UNITY_EDITOR_OSX

		private string[] ReadKeysOSX()
		{
			string plistPath = Environment.GetFolderPath(Environment.SpecialFolder.Personal) + "/Library/Preferences/unity." + 
				PlayerSettings.companyName + "." + PlayerSettings.productName + ".plist";

			if (!File.Exists (plistPath)) 
			{
				return new string[0];
			}

			Dictionary<string, object> parsedPlist = (Dictionary<string, object>)PlistCS.Plist.readPlist(plistPath);

			string[] keys = new string[parsedPlist.Keys.Count];
			parsedPlist.Keys.CopyTo (keys, 0);

			return keys;
		}

#else // LINUX!

		private string[] ReadKeysLinux()
		{
			string prefsPath = Environment.GetFolderPath(Environment.SpecialFolder.Personal) + "/.config/unity3d/" + 
				PlayerSettings.companyName + "/" + PlayerSettings.productName + "/prefs";

			if (!File.Exists(prefsPath)) 
			{
				return new string[0];
			}

			XmlDocument prefsXML = new XmlDocument();
			prefsXML.Load(prefsPath);
			XmlNodeList prefsList = prefsXML.SelectNodes("/unity_prefs/pref");

			string[] keys = new string[prefsList.Count];

			for (int i = 0; i < keys.Length; i++)
			{
				keys[i] = prefsList[i].Attributes["name"].Value;
			}

			return keys;
		}

#endif
    #endregion

    private enum SortingType : byte
    {
        KeyAscending = 0,
        KeyDescending = 2,
        Type = 5
    }

    #endregion

    #region PrefsRecord
    [Serializable]
    internal class PrefsRecord
    {
        internal PrefsType prefType = PrefsType.Unknown;

        internal bool dirtyKey;
        internal bool dirtyValue;

        [SerializeField]
        private string savedKey;

        [SerializeField]
        private string key;

        internal string Key
        {
            get { return key; }
            set
            {
                if (value == key) return;
                key = value;

                dirtyKey = true;
            }
        }

        [SerializeField]
        private string stringValue;

        internal string StringValue
        {
            get { return stringValue; }
            set
            {
                if (value == stringValue) return;

                stringValue = value;
                dirtyValue = true;
            }
        }

        [SerializeField]
        private int intValue;

        internal int IntValue
        {
            get { return intValue; }
            set
            {
                if (value == intValue) return;

                intValue = value;
                dirtyValue = true;
            }
        }

        [SerializeField]
        private float floatValue;

        internal float FloatValue
        {
            get { return floatValue; }
            set
            {
                if (Math.Abs(value - floatValue) < 0.0000001f) return;

                floatValue = value;
                dirtyValue = true;
            }
        }

        internal string DisplayValue
        {
            get
            {
                switch (prefType)
                {
                    case PrefsType.Unknown:
                        return UNKNOWN_VALUE_DESCRIPTION;
                    case PrefsType.String:
                        return stringValue;
                    case PrefsType.Int:
                        return intValue.ToString();
                    case PrefsType.Float:
                        return floatValue.ToString(CultureInfo.InvariantCulture);
                    default:
                        throw new ArgumentOutOfRangeException();
                }
            }
        }

        internal string DisplayType
        {
            get { return prefType.ToString(); }
        }

        internal static int SortByNameAscending(PrefsRecord n1, PrefsRecord n2)
        {
            return string.CompareOrdinal(n1.key, n2.key);
        }

        internal static int SortByNameDescending(PrefsRecord n1, PrefsRecord n2)
        {
            int result = string.CompareOrdinal(n2.key, n1.key);
            return result;
        }

        internal static int SortByType(PrefsRecord n1, PrefsRecord n2)
        {
            int result = string.CompareOrdinal(n1.DisplayType, n2.DisplayType);
            if (result == 0)
            {
                return SortByNameAscending(n1, n2);
            }
            return result;
        }

        internal PrefsRecord(string newKey, string value)
        {
            key = savedKey = newKey;
            stringValue = value;

            prefType = PrefsType.String;
        }

        internal PrefsRecord(string newKey, int value)
        {
            key = savedKey = newKey;
            intValue = value;

            prefType = PrefsType.Int;
        }

        internal PrefsRecord(string newKey, float value)
        {
            key = savedKey = newKey;
            floatValue = value;

            prefType = PrefsType.Float;
        }

        internal PrefsRecord(string originalKey)
        {
            key = savedKey = originalKey;

            ReadValue();
        }

        internal bool Save(bool newRecord = false)
        {
            string savedString = stringValue;
            string newSavedKey = key;

            if (newSavedKey != savedKey && PlayerPrefs.HasKey(newSavedKey))
            {
                if (!EditorUtility.DisplayDialog("Pref overwrite", "Pref with name " + key + " already exists!\n" + "Are you sure you wish to overwrite it?", "Yes", "No"))
                {
                    return false;
                }
            }

            if (dirtyKey)
            {
                PlayerPrefs.DeleteKey(savedKey);
            }

            switch (prefType)
            {
                case PrefsType.Unknown:
                    Debug.LogError("Can't save Pref of unknown type!");
                    break;
                case PrefsType.String:
                    PlayerPrefs.SetString(newSavedKey, savedString);
                    break;
                case PrefsType.Int:
                    PlayerPrefs.SetInt(newSavedKey, intValue);
                    break;
                case PrefsType.Float:
                    PlayerPrefs.SetFloat(newSavedKey, floatValue);
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            savedKey = newSavedKey;

            dirtyKey = false;
            dirtyValue = false;

            PlayerPrefs.Save();

            return true;
        }

        internal void Delete()
        {
            PlayerPrefs.DeleteKey(savedKey);
            PlayerPrefs.Save();
        }

        public override string ToString()
        {
            string result = "Key: " + key + Environment.NewLine + "Value: " + DisplayValue; ;
            return result;
        }

        private void ReadValue()
        {
            float floatTry = PlayerPrefs.GetFloat(key, DEFAULT_FLOAT);
            if (Math.Abs(floatTry - DEFAULT_FLOAT) > 0.0000001f)
            {
                prefType = PrefsType.Float;
                floatValue = floatTry;
                return;
            }

            int intTry = PlayerPrefs.GetInt(key, DEFAULT_INT);
            if (intTry != DEFAULT_INT)
            {
                prefType = PrefsType.Int;
                intValue = intTry;
                return;
            }

            string stringTry = PlayerPrefs.GetString(key, DEFAULT_STRING);
            if (stringTry != DEFAULT_STRING)
            {
                prefType = PrefsType.String;
                stringValue = stringTry;
                return;
            }
        }

        internal enum PrefsType : byte
        {
            Unknown,
            String,
            Int,
            Float
        }
    }
    #endregion
}
