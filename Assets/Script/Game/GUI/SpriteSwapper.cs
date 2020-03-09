using UnityEngine;
using UnityEngine.UI;

[SLua.CustomLuaClass]
public class SpriteSwapper : MonoBehaviour
{
    public Sprite enabledSprite;
    public Sprite disabledSprite;

    private bool m_swapped = true;

    private Image m_image;

    public void Awake()
    {
        m_image = GetComponent<Image>();
    }

    public void SetEnable(bool val)
    {
        this.m_swapped = !val;
        if (m_swapped)
        {
            m_image.sprite = enabledSprite;
        }
        else
        {
            m_image.sprite = disabledSprite;
        }
    }

    public void SwapSprite()
    {
        if (m_swapped)
        {
            m_swapped = false;
            m_image.sprite = disabledSprite;
        }
        else
        {
            m_swapped = true;
            m_image.sprite = enabledSprite;
        }
    }
}