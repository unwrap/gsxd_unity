using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.EventSystems;
using SLua;
using System;
using System.Collections.Generic;

[CustomLuaClassAttribute]
public class EventListener : LuaMonoBehaviourBase, IEventSystemHandler, IPointerClickHandler, ISubmitHandler, IPointerEnterHandler, IPointerDownHandler, IPointerUpHandler, IPointerExitHandler
{
    public LuaFunction onClick;
    public LuaFunction onDown;
    public LuaFunction onEnter;
    public LuaFunction onExit;
    public LuaFunction onUp;
    public LuaFunction onSelect;
    public LuaFunction onUpdateSelect;
    public LuaFunction onSubmit;

    private LuaTable mTarget;
	private bool mClickEffect = true;

    private Animator mAnimator;
    private PointerEventData mClickEventData;

	static public EventListener Get(GameObject go, LuaTable target, bool effect)
	{
		EventListener listener = go.GetComponent<EventListener>();
		if (listener == null) listener = go.AddComponent<EventListener>();
		listener.mTarget = target;
		listener.mClickEffect = effect;
		return listener;
	}

    static public EventListener Get(GameObject go, LuaTable target)
    {
		return EventListener.Get(go, target, true);
    }

    static public EventListener Get(GameObject go)
    {
        return EventListener.Get(go, null);
    }

	static public EventListener Get(Transform tf, LuaTable target, bool effect)
	{
		return EventListener.Get(tf.gameObject, target, effect);
	}

    static public EventListener Get(Transform tf, LuaTable target)
    {
		return EventListener.Get(tf.gameObject, target, true);
    }

    static public EventListener Get(Transform tf)
    {
		return EventListener.Get(tf.gameObject, null);
    }

    protected override void Awake()
    {
        base.Awake();
        this.mAnimator = this.GetComponent<Animator>();
		if (string.IsNullOrEmpty(m_LuaClassName) && this.mClickEffect)
        {
            this.m_LuaClassName = "game.effect.UIClickController";
            DoFile(m_LuaClassName);
        }
    }

    override protected void OnDestroy()
    {
        this.mTarget = null;
        this.onClick = null;
        this.onDown = null;
        this.onExit = null;
        this.onExit = null;
        this.onUp = null;
        this.onSelect = null;
        this.onUpdateSelect = null;
        this.onSubmit = null;
        base.OnDestroy();
    }

    public void PassPointerDownEvent(PointerEventData data)
    {
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(data, results);
        for (int i = 0; i < results.Count; i++)
        {
            if (this.gameObject != results[i].gameObject)
            {
                data.pointerCurrentRaycast = results[i];
                ExecuteEvents.Execute<IPointerDownHandler>(results[i].gameObject, data, ExecuteEvents.pointerDownHandler);
                break;
            }
        }
    }

    public void PassPointerUpEvent(PointerEventData data)
    {
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(data, results);
        for (int i = 0; i < results.Count; i++)
        {
            if (this.gameObject != results[i].gameObject)
            {
                data.pointerCurrentRaycast = results[i];
                ExecuteEvents.Execute<IPointerUpHandler>(results[i].gameObject, data, ExecuteEvents.pointerUpHandler);
                break;
            }
        }
    }

    public void PassPointerClickEvent(PointerEventData data)
    {
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(data, results);
        for(int i = 0; i < results.Count; i++)
        {
            if(this.gameObject != results[i].gameObject)
            {
                data.pointerCurrentRaycast = results[i];
                ExecuteEvents.Execute<IPointerClickHandler>(results[i].gameObject, data, ExecuteEvents.pointerClickHandler);
                break;
            }
        }
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        this.mClickEventData = eventData;

        float delayTimer = 0.0f;
        if (this.mClickEffect)
        {
            object ret = CallMethod(LuaMonoMethod.OnClick);
            delayTimer = Convert.ToSingle(ret);
        }

        if (delayTimer > 0)
        {
            this.Invoke("InvokeOnClickAction", delayTimer);
        }
        else
        {
            this.InvokeOnClickAction();
        }
    }

    private void InvokeOnClickAction()
    {
        if(this.mClickEventData == null)
        {
            return;
        }
        if (this.onClick != null)
        {
            //SoundManager.PlaySound("se_ok");
            if (this.mTarget != null)
            {
                this.onClick.call(this.mTarget, gameObject, this.mClickEventData);
            }
            else
            {
                this.onClick.call(gameObject, this.mClickEventData);
            }
        }
        
        this.mClickEventData = null;
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (this.onDown != null)
        {
            if (this.mTarget != null)
            {
                this.onDown.call(this.mTarget, gameObject, eventData);
            }
            else
            {
                this.onDown.call(gameObject, eventData);
            }
        }
		if(this.mClickEffect)
		{
			CallMethod(LuaMonoMethod.OnPointerDown);
		}
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        if (this.onEnter != null)
        {
            if (this.mTarget != null)
            {
                this.onEnter.call(this.mTarget, gameObject, eventData);
            }
            else
            {
                this.onEnter.call(gameObject, eventData);
            }
        }
		if(this.mClickEffect)
		{
			CallMethod(LuaMonoMethod.OnPointerEnter);
		}
    }
    public void OnPointerExit(PointerEventData eventData)
    {
        if (this.onExit != null)
        {
            if (this.mTarget != null)
            {
                this.onExit.call(this.mTarget, gameObject, eventData);
            }
            else
            {
                this.onExit.call(gameObject, eventData);
            }
        }
		if(this.mClickEffect)
		{
			CallMethod(LuaMonoMethod.OnPointerExit);
		}
    }
    public void OnPointerUp(PointerEventData eventData)
    {
        if (this.onUp != null)
        {
            if (this.mTarget != null)
            {
                this.onUp.call(this.mTarget, gameObject, eventData);
            }
            else
            {
                this.onUp.call(gameObject, eventData);
            }
        }
		if(this.mClickEffect)
		{
			CallMethod(LuaMonoMethod.OnPointerUp);
		}
    }

    public void OnSelect(BaseEventData eventData)
    {
        if (this.onSelect != null)
        {
            if (this.mTarget != null)
            {
                this.onSelect.call(this.mTarget, gameObject, eventData);
            }
            else
            {
                this.onSelect.call(gameObject, eventData);
            }
        }
    }

    public void OnSubmit(BaseEventData eventData)
    {
        if (this.onSubmit != null)
        {
            if (this.mTarget != null)
            {
                this.onSubmit.call(this.mTarget, eventData);
            }
            else
            {
                this.onSubmit.call(eventData);
            }
        }
    }
}
