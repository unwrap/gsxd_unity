using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class AutoResizeBoxCollider : MonoBehaviour
{
    private BoxCollider m_boxCollider;
    private RectTransform m_transform;
    private Rect m_rect;

    private float m_width;
    private float m_height;

    private void Start()
    {
        this.m_transform = GetComponent<RectTransform>();
        this.m_boxCollider = GetComponent<BoxCollider>();
    }

    private void Update()
    {
        ResizeCollider();
    }

    private void ResizeCollider()
    {
        this.m_rect = this.m_transform.rect;
        if ( this.m_width != this.m_rect.width || this.m_height != this.m_rect.height)
        {
            this.m_boxCollider.center = new Vector3(0, this.m_rect.height * 0.5f, 0);
            this.m_boxCollider.size = new Vector3(this.m_rect.width, this.m_rect.height, 0.0f);
            this.m_width = this.m_rect.width;
            this.m_height = this.m_rect.height;
        }
    }
}
