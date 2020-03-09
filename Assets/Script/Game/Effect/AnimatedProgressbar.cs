using UnityEngine;
using UnityEngine.UI;

[DisallowMultipleComponent]
[SLua.CustomLuaClass]
public class AnimatedProgressbar : MonoBehaviour
{
    [SerializeField]
    private RawImage m_barUI = null;
    [SerializeField]
    private float m_speed = 0;
    [SerializeField]
    private float m_fillAmount = 0;

    private float m_initUvRectWidth;
    private bool m_isInit;

    public float fillAmount
    {
        get
        {
            return m_fillAmount;
        }
        set
        {
            Init();
            m_fillAmount = Mathf.Clamp01(value);

            Vector3 localScale = m_barUI.rectTransform.localScale;
            localScale.x = m_fillAmount;
            m_barUI.rectTransform.localScale = localScale;

            Rect rect = m_barUI.uvRect;
            rect.width = m_initUvRectWidth * m_fillAmount;
            m_barUI.uvRect = rect;
        }
    }

    private void Init()
    {
        if(m_isInit)
        {
            return;
        }
        m_isInit = true;
        m_initUvRectWidth = m_barUI.uvRect.width;
        fillAmount = m_fillAmount;
    }

    private void Awake()
    {
        Init();
    }

    private void Update()
    {
        Rect rect = m_barUI.uvRect;
        rect.x -= m_speed;
        m_barUI.uvRect = rect;
    }
}
