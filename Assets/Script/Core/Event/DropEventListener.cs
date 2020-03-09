using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.EventSystems;
using SLua;
using System;

[SLua.CustomLuaClass]
public class DropEventListener : MonoBehaviour, IDropHandler, IPointerEnterHandler, IPointerExitHandler
{
    public LuaFunction onPointerEnter;
    public LuaFunction onPointerExit;
    public LuaFunction onDrop;

    private LuaTable mTarget;

    static public DropEventListener Get(GameObject go, LuaTable target)
    {
        DropEventListener listener = go.GetComponent<DropEventListener>();
        if (listener == null) listener = go.AddComponent<DropEventListener>();
        listener.mTarget = target;
        return listener;
    }

    static public DropEventListener Get(GameObject go)
    {
        return DropEventListener.Get(go, null);
    }

    static public DropEventListener Get(Transform tf, LuaTable target)
    {
        return DropEventListener.Get(tf.gameObject, target);
    }

    static public DropEventListener Get(Transform tf)
    {
        return DropEventListener.Get(tf.gameObject, null);
    }

    private void OnDestroy()
    {
        this.mTarget = null;
        this.onDrop = null;
        this.onPointerEnter = null;
        this.onPointerExit = null;
    }

    public void OnDrop(PointerEventData eventData)
    {
        if( this.onDrop != null )
        {
            if (this.mTarget != null)
            {
                this.onDrop.call(this.mTarget, eventData);
            }
            else
            {
                this.onDrop.call(eventData);
            }
        }
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        if( this.onPointerEnter != null )
        {
            if (this.mTarget != null)
            {
                this.onPointerEnter.call(this.mTarget, eventData);
            }
            else
            {
                this.onPointerEnter.call(eventData);
            }
        }
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if( this.onPointerExit != null )
        {
            if (this.mTarget != null)
            {
                this.onPointerExit.call(this.mTarget, eventData);
            }
            else
            {
                this.onPointerExit.call(eventData);
            }
        }
    }
}
