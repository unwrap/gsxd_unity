using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("UI/Localized Text", 11)]
[RequireComponent(typeof(Text))]
public class LocalizedText : MonoBehaviour
{
    [SerializeField]
    private Text m_text;
    [SerializeField]
    private string m_key;
    [SerializeField]
    private string m_zhText;

    protected void Awake()
    {
        this.OnLocalize();
    }

    public void Reset()
    {
        this.m_text = GetComponent<Text>();
    }

#if UNITY_EDITOR
    public string GetText()
    {
        return this.m_text.text;
    }

    public void SerializeZhText(string value)
    {
        this.m_text.text = value;
        this.m_zhText = value;
    }
#endif

    public void OnLocalize()
    {
#if UNITY_EDITOR
        var flags = m_text != null ? m_text.hideFlags : HideFlags.None;
        if (m_text != null)
            m_text.hideFlags = HideFlags.DontSave;
#endif

        SetText(LocalizationImporter.GetLanguages(m_key));

#if UNITY_EDITOR
        if (m_text != null)
            m_text.hideFlags = flags;
#endif
    }

    private void SetText(string value)
    {
        if(string.IsNullOrEmpty(value))
        {
            return;
        }
        if(this.m_text == null)
        {
            Debug.LogWarning("Missing text component for " + this, this);
            return;
        }
        if(this.m_text.text == m_zhText)
        {
            this.m_text.text = value;
        }
    }
}
