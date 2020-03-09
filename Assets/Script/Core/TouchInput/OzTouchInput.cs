using UnityEngine;
using System.Collections;
using System;

[SLua.CustomLuaClass]
public class OzTouchInput : MonoBehaviour
{
    #region Delegate & Event

    public delegate void TouchInputEvent(Vector2 pos);
    public delegate void TouchInputPinchEvent(float d);
    public delegate bool TouchCheckGUI(Vector2 pos);

    public TouchInputEvent touchInputDownEventHandler;
    public TouchInputEvent touchInputMoveEventHandler;
    public TouchInputEvent touchInputMoveDeltaEventHandler;
    public TouchInputEvent touchInputUpEventHandler;
    public TouchInputEvent touchInputCancelEventHandler;
    public TouchInputPinchEvent touchInputPinchEventHandler;

    public TouchCheckGUI checkGUIHandler;

    public Action backButtonEventHandler;

    #endregion

    #region Members

    private int mainFingerId = -1;
    private int subFingerId = -1;
    private Vector2[] downPos;
    private bool leftDown;
    private Vector2 moveDelta;
    private bool mobilePlatform;
    private float lastTime;

    private Vector2 oldMovePos;
    public float mouseWheelSpeed = 10.0f;

    private ScreenArea retrictArea = ScreenArea.FullScreen;

    #endregion

    static public OzTouchInput Get(GameObject go)
    {
        OzTouchInput listener = go.GetComponent<OzTouchInput>();
        if (listener == null)
        {
            listener = go.AddComponent<OzTouchInput>();
        }
        return listener;
    }

    public void SetRetrictArea(ScreenArea area)
    {
        this.retrictArea = area;
    }

    public void ResetAllTouchInfo(bool notify = false)
    {
        if (notify && (this.mainFingerId >= 0 || this.leftDown) && this.touchInputUpEventHandler != null)
        {
            this.touchInputUpEventHandler(Vector2.zero);
        }
        this.mainFingerId = -1;
        this.subFingerId = -1;
        this.leftDown = false;
    }

    #region Monobehaviors

    protected virtual void Awake()
    {
        this.downPos = new Vector2[5];
        this.moveDelta = new Vector2();

#if ((UNITY_ANDROID || UNITY_IPHONE || UNITY_WP8 || UNITY_BLACKBERRY) && !UNITY_EDITOR) 
		this.mobilePlatform = true;
#else
        this.mobilePlatform = false;
#endif

        InitInputEvent();

        OzTouchInputManager.RegisterTouchInput(this);
    }

    protected virtual void OnDestroy()
    {
        OzTouchInputManager.UnregisterTouchInput(this);
    }

    protected void OnApplicationPause()
    {
        ResetAllTouchInfo(true);
    }

    protected virtual void InitInputEvent()
    {

    }

    protected virtual void Update()
    {
        if (this.mobilePlatform)
        {
            UpdateMobile();
        }
        else
        {
            UpdateMouse();
        }
    }

    #endregion

    #region private methods

    private void UpdateMobile()
    {
        int touchCount = Input.touchCount;
        if (touchCount == 0)
        {
            this.ResetAllTouchInfo();
            if (Application.platform == RuntimePlatform.Android && Input.GetKey(KeyCode.Escape) && this.lastTime + 0.2f < Time.time)
            {
                this.lastTime = Time.time;
                if (this.backButtonEventHandler != null)
                {
                    this.backButtonEventHandler();
                }
                return;
            }
        }
        else
        {
            for (int i = 0; i < touchCount; i++)
            {
                Touch touch = Input.GetTouch(i);
                int fingerId = touch.fingerId;
                if (fingerId > 2)
                {
                    continue;
                }
                if (touch.phase == TouchPhase.Began && !CheckGUI(touch.position) && this.CheckPosition(touch.position))
                {
                    this.downPos[fingerId] = touch.position;
                    if (this.mainFingerId < 0)
                    {
                        this.mainFingerId = fingerId;
                        if (this.touchInputDownEventHandler != null)
                        {
                            this.touchInputDownEventHandler(touch.position);
                        }
                    }
                    else
                    {
                        this.subFingerId = fingerId;
                    }
                }
                else if (touch.phase == TouchPhase.Moved)
                {
                    if (this.mainFingerId >= 0 && this.subFingerId >= 0)
                    {
                        Vector2 mainPos = Vector2.zero;
                        Vector2 subPos = Vector2.zero;
                        Vector2 b = Vector2.zero;
                        Vector2 b2 = Vector2.zero;
                        int num = 0;
                        for (int j = 0; j < touchCount; j++)
                        {
                            Touch touch2 = Input.GetTouch(j);
                            if (this.mainFingerId == touch2.fingerId)
                            {
                                mainPos = touch2.position;
                                b = touch2.deltaPosition;
                                num++;
                            }
                            else if (this.subFingerId == touch2.fingerId)
                            {
                                subPos = touch2.position;
                                b2 = touch2.deltaPosition;
                                num++;
                            }
                        }
                        if (num == 2)
                        {
                            float num2 = Vector2.Distance(mainPos, subPos);
                            float num3 = Vector2.Distance(mainPos - b, subPos - b2);
                            float d = num2 - num3;
                            //DebugConsole.Log( d );
                            if (this.touchInputPinchEventHandler != null)
                            {
                                this.touchInputPinchEventHandler(d);
                            }
                        }
                    }
                    else if (fingerId == this.mainFingerId && this.mainFingerId >= 0)
                    {
                        if (this.touchInputMoveEventHandler != null)
                        {
                            this.touchInputMoveEventHandler(touch.position);
                        }
                        if (this.touchInputMoveDeltaEventHandler != null)
                        {
                            this.touchInputMoveDeltaEventHandler(touch.deltaPosition);
                        }
                    }
                }
                else if (touch.phase == TouchPhase.Ended)
                {
                    if (fingerId == this.mainFingerId)
                    {
                        this.mainFingerId = -1;
                        this.subFingerId = -1;

                        if (this.touchInputUpEventHandler != null)
                        {
                            this.touchInputUpEventHandler(touch.position);
                        }
                    }
                    else
                    {
                        this.subFingerId = -1;
                    }
                }
                else if (touch.phase == TouchPhase.Canceled)
                {
                    if (fingerId == this.mainFingerId)
                    {
                        this.mainFingerId = -1;
                        this.subFingerId = -1;
                        if (this.touchInputCancelEventHandler != null)
                        {
                            this.touchInputCancelEventHandler(touch.position);
                        }
                    }
                    else
                    {
                        this.subFingerId = -1;
                    }
                }
            }
        }
    }

    private void UpdateMouse()
    {
        if (Input.GetKeyDown(KeyCode.Backspace))
        {
            if (this.backButtonEventHandler != null)
            {
                this.backButtonEventHandler();
            }
            return;
        }

        if (Input.GetMouseButtonDown(0) && !CheckGUI(Input.mousePosition) && this.CheckPosition(Input.mousePosition))
        {
            this.leftDown = true;
            this.downPos[0] = Input.mousePosition;
            this.oldMovePos = Input.mousePosition;
            if (this.touchInputDownEventHandler != null)
            {
                Vector2 pos = Input.mousePosition;
                this.touchInputDownEventHandler(pos);
            }
        }

        if (Input.GetMouseButtonUp(0) && this.leftDown)
        {
            this.leftDown = false;
            if (this.touchInputUpEventHandler != null)
            {
                Vector2 pos = Input.mousePosition;
                this.touchInputUpEventHandler(pos);
            }
        }

        if (this.leftDown)
        {
            float num = Vector2.Distance(this.oldMovePos, Input.mousePosition);
            if (num >= 0.001f)
            {
                if (this.touchInputMoveEventHandler != null)
                {
                    this.touchInputMoveEventHandler(Input.mousePosition);
                }
                this.moveDelta.x = Input.mousePosition.x - this.oldMovePos.x;
                this.moveDelta.y = Input.mousePosition.y - this.oldMovePos.y;
                if (this.touchInputMoveDeltaEventHandler != null)
                {
                    this.touchInputMoveDeltaEventHandler(this.moveDelta);
                }
            }
            this.oldMovePos = Input.mousePosition;
        }

        float d = Input.GetAxis("Mouse ScrollWheel");
        if (Mathf.Abs(d) > 0.01f)
        {
            d *= this.mouseWheelSpeed;
            if (this.touchInputPinchEventHandler != null)
            {
                this.touchInputPinchEventHandler(d);
            }
        }
    }

    public bool CheckPosition(Vector2 pos)
    {
        if (this == null)
            return false;

        if (!this.gameObject.activeSelf)
        {
            return false;
        }
        switch (this.retrictArea)
        {
            case ScreenArea.FullScreen:
                return true;
            case ScreenArea.Left:
                if (pos.x < (Screen.width * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.Right:
                if (pos.x > (Screen.width * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.Top:
                if (pos.y > (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.Bottom:
                if (pos.y < (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.TopLeft:
                if (pos.x < (Screen.width * 0.5f) && pos.y > (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.TopRight:
                if (pos.x > (Screen.width * 0.5f) && pos.y > (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.BottomLeft:
                if (pos.x >= 0.0f && pos.y >= 0.0f && pos.x < (Screen.width * 0.5f) && pos.y < (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
            case ScreenArea.BottomRight:
                if (pos.x > (Screen.width * 0.5f) && pos.y < (Screen.height * 0.5f))
                {
                    return true;
                }
                break;
        }
        return false;
    }

    protected virtual bool CheckGUI(Vector2 pos)
    {
        if(this.checkGUIHandler != null)
        {
            return this.checkGUIHandler(pos);
        }
        return false;
    }
    #endregion
}

[SLua.CustomLuaClass]
public enum ScreenArea
{
    FullScreen,
    Left,
    Right,
    Top,
    Bottom,
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight
}
