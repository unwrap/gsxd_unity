using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.EventSystems;
using SLua;
using System;

[SLua.CustomLuaClass]
public class DragEventListener : MonoBehaviour, IBeginDragHandler, IDragHandler, IEndDragHandler
{
    public LuaFunction onBeginDrag;
    public LuaFunction onDrag;
    public LuaFunction onEndDrag;

    private LuaTable mTarget;

    static public DragEventListener Get(GameObject go, LuaTable target)
    {
        DragEventListener listener = go.GetComponent<DragEventListener>();
        if (listener == null) listener = go.AddComponent<DragEventListener>();
        listener.mTarget = target;
        return listener;
    }

    static public DragEventListener Get(GameObject go)
    {
        return DragEventListener.Get(go, null);
    }

    static public DragEventListener Get(Transform tf, LuaTable target)
    {
        return DragEventListener.Get(tf.gameObject, target);
    }

    static public DragEventListener Get(Transform tf)
    {
        return DragEventListener.Get(tf.gameObject, null);
    }

    private void OnDestroy()
    {
        this.mTarget = null;
        this.onBeginDrag = null;
        this.onDrag = null;
        this.onEndDrag = null;
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        if (this.onBeginDrag != null)
        {
            if( this.mTarget != null )
            {
                this.onBeginDrag.call(this.mTarget, eventData);
            }
            else
            {
                this.onBeginDrag.call(eventData);
            }
        }
    }

    public void OnDrag(PointerEventData eventData)
    {
        if (this.onDrag != null)
        {
            if (this.mTarget != null)
            {
                this.onDrag.call(this.mTarget, eventData);
            }
            else
            {
                this.onDrag.call(eventData);
            }
        }
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        if (this.onEndDrag != null)
        {
            if (this.mTarget != null)
            {
                this.onEndDrag.call(this.mTarget,eventData);
            }
            else
            {
                this.onEndDrag.call(eventData);
            }
        }
    }
}
