using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;

[SLua.CustomLuaClass]
public class AnimatedButton : UIBehaviour, IPointerDownHandler
{
    [Serializable]
    public class ButtonClickedEvent : UnityEvent { }

    public bool interactable = true;

    [SerializeField]
    private ButtonClickedEvent m_OnClick = new ButtonClickedEvent();

    private Animator m_animator;

    override protected void Start()
    {
        base.Start();
        m_animator = GetComponent<Animator>();
    }

    public ButtonClickedEvent onClick
    {
        get { return m_OnClick; }
        set { m_OnClick = value; }
    }

    public virtual void OnPointerDown(PointerEventData eventData)
    {
        if (eventData.button != PointerEventData.InputButton.Left || !interactable)
            return;

        Press();
    }

    private void Press()
    {
        if (!IsActive())
            return;

        m_animator.SetTrigger("Pressed");
        Invoke("InvokeOnClickAction", 0.1f);
    }

    private void InvokeOnClickAction()
    {
        m_OnClick.Invoke();
    }
}
