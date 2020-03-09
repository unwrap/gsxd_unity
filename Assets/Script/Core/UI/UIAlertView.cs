using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using System;

public class UIAlertView : MonoBehaviour
{
    private Vector3 mDefScale;
    private float m_defAlpha;
    private float mStartScale = 1.4f;
    private float mEndScale = 2f;

    private float mStartPos = 5.0f;

    private bool mIsAnim;
    private float mAnimTimer;
    private int mAnimState;
    private float[] mAnimTime = new float[] { 0.1f, 0.8f, 0.2f };

    private CanvasGroup m_canvasGroup;
    private Transform m_textTransform;
    private Text m_text;

    private Action mCallback;

    public void PlayAnim(Action callback = null)
    {
        this.mCallback = callback;
        if(this.m_canvasGroup != null)
        {
            this.m_canvasGroup.alpha = 0.0f;
        }
        if (this.m_textTransform != null)
        {
            //this.m_textTransform.localScale = this.mDefScale * this.mStartScale;
            this.m_textTransform.localPosition = new Vector3(0.0f, -this.mStartScale*this.mStartPos , 0.0f);
        }
        this.mAnimTimer = 0.0f;
        this.mAnimState = 0;
        this.mIsAnim = true;
    }

    public void PlayAnim(float showTime, Action callback = null)
    {
        mAnimTime[1] = showTime;
        PlayAnim(callback);
    }

    public void PlayStopAnim(Action callback = null)
    {
        if (!this.mIsAnim)
        {
            if( callback != null)
            {
                callback();
            }
            return;
        }
        this.mCallback = callback;
        this.mAnimState = 2;
        this.mAnimTimer = 0f;
    }

    public void StopAnim()
    {
        if (this.m_textTransform != null)
        {
            //this.m_textTransform.localScale = this.mDefScale;
        }
        if (this.m_canvasGroup != null)
        {
            this.m_canvasGroup.alpha = 0.0f;
        }
        this.mIsAnim = false;
        EffectEnd();
    }

    protected virtual void EffectEnd()
    {
        if (mCallback != null)
        {
            this.mCallback();
            this.mCallback = null;
        }
        ObjectPool.Recycle(this.gameObject);
    }

    private void Awake()
    {
        this.m_canvasGroup = this.GetComponentInChildren<CanvasGroup>();
        this.m_textTransform = this.transform.Find("bg");
        this.m_text = this.GetComponentInChildren<Text>();

        if (this.m_textTransform != null)
        {
            this.mDefScale = this.m_textTransform.localScale;
        }
        if(this.m_canvasGroup != null)
        {
            this.m_defAlpha = this.m_canvasGroup.alpha;
        }
    }

    private void Update()
    {
        TextAnimation(Time.deltaTime);
    }

    private void TextAnimation(float deltaTime)
    {
        if (!this.mIsAnim)
        {
            return;
        }

        float num = this.mAnimTime[this.mAnimState];
        this.mAnimTimer += deltaTime;
        if (this.mAnimState == 0)
        {
            if (this.mAnimTimer < num)
            {
                float num2 = Mathf.Sin(90f * this.mAnimTimer / num * Mathf.Deg2Rad);
                float d = Mathf.Lerp(this.mStartScale, 0.99f, num2);
                if(this.m_text != null)
                {
                    //this.m_text.color = new Color(this.m_defColor.r, this.m_defColor.g, this.m_defColor.b, num2);
                }
                if (this.m_canvasGroup != null)
                {
                    this.m_canvasGroup.alpha = num2;
                }
                if (this.m_textTransform != null)
                {
                    //this.m_textTransform.localScale = this.mDefScale * d;
                    this.m_textTransform.localPosition = new Vector3(0.0f, -d * this.mStartPos, 0.0f);
                }
            }
            else
            {
                if (this.m_canvasGroup != null)
                {
                    this.m_canvasGroup.alpha = this.m_defAlpha;
                }
                if (this.m_textTransform != null)
                {
                    //this.m_textTransform.localScale = this.mDefScale;
                    this.m_textTransform.localPosition = new Vector3(0.0f, 0.0f, 0.0f);
                }
                this.mAnimTimer = 0f;
                this.mAnimState++;
            }
        }
        else if (this.mAnimState == 1)
        {
            if (mAnimTimer > num)
            {
                this.mAnimTimer = 0f;
                this.mAnimState++;
            }
        }
        else
        {
            if (this.mAnimTimer < num)
            {
                float num3 = Mathf.Sin(90f * this.mAnimTimer / num * Mathf.Deg2Rad);
                float d2 = Mathf.Lerp(1f, this.mEndScale, num3);
                if (this.m_text != null)
                {
                    //this.m_text.color = new Color(this.m_defColor.r, this.m_defColor.g, this.m_defColor.b, 1f - num3);
                }
                if (this.m_canvasGroup != null)
                {
                    this.m_canvasGroup.alpha = 1.0f - num3;
                }
                if (this.m_textTransform != null)
                {
                    //this.m_textTransform.localScale = this.mDefScale * d2;
                    this.m_textTransform.localPosition = new Vector3(0.0f, d2 * this.mStartPos, 0.0f);
                }
            }
            else
            {
                StopAnim();
            }
        }
    }
}
