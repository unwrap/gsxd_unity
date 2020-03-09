using UnityEngine;
using System.Collections;
using UI;

public class UIDialogView : MonoBehaviour
{
	private enum VisibleType
	{
		NONE,
		SHOW,
		HIDE
	}

	public enum ShowAnimType
	{
		none,
		scaleAnim,
		positionAnim,
        curveAnim
	}

	#region member

	public event Dialog.DialogCloseDelegate HideEvent;

    public Dialog.DialogCloseDelegate hideCallback;
    public Dialog.DialogShowedDelegate ShowedEvent;

    public ShowAnimType animType = ShowAnimType.scaleAnim;

    public bool mIsModal;

	private readonly float visibleAnimationTime = 0.5f;
	private float visibleAnimationTimer;
	private Vector3 defaultScale = Vector3.one;
	private VisibleType visibleType;
	private float showPosMoveLength;

    private Animator mAnimator;
    private float mCurveAnimTime = 0.0f;

	private DialogState mState = DialogState.OK;

	protected object mData;
	public object Data
	{
		get
		{
			return mData;
		}
	}

	public virtual void SetData( object value )
	{
		this.mData = value;
	}

	#endregion

	#region public

	public virtual void Show()
	{
		if( this.visibleType == VisibleType.SHOW )
		{
			return;
		}
        this.mAnimator = this.gameObject.GetComponent<Animator>();
        if(this.mAnimator != null)
        {
            this.animType = ShowAnimType.curveAnim;
        }
        this.Initialize();
		this.visibleAnimationTimer = 0f;
		this.visibleType = VisibleType.SHOW;
	}

	public virtual void Hide( DialogState state )
	{
		if( this.visibleType == VisibleType.HIDE )
		{
			return;
		}
        this.OnHide();
		PlayStateSE( state );
		this.mState = state;
		this.visibleAnimationTimer = 0f;
		this.visibleType = VisibleType.HIDE;
    }

    public void Remove()
    {
        //Destroy( this.gameObject );
        ObjectPool.Recycle(this.gameObject);
        if (this.HideEvent != null)
        {
            this.HideEvent(this, this.mState);
        }
        if (this.hideCallback != null)
        {
            this.hideCallback(this, this.mState);
        }

        this.ShowedEvent = null;
        this.HideEvent = null;
        this.hideCallback = null;
    }

    public void Dispose()
	{
		this.ShowedEvent = null;
		this.HideEvent = null;
        this.hideCallback = null;
    }

	#endregion

	#region private

	private void Initialize()
	{
		if( this.animType == ShowAnimType.scaleAnim )
		{
			this.defaultScale = Vector3.one;
			this.gameObject.transform.localScale = Vector3.zero;
		}
		else if( this.animType == ShowAnimType.positionAnim )
		{
			this.gameObject.transform.localScale = Vector3.one;
			showPosMoveLength = UIManager.Instance.size.x * 0.5f;
			this.gameObject.transform.localPosition = new Vector3( this.showPosMoveLength, 0f, 0f );
		}
        else if(this.animType == ShowAnimType.curveAnim)
        {
            if(this.mAnimator == null)
            {
                this.animType = ShowAnimType.scaleAnim;
                this.defaultScale = Vector3.one;
                this.gameObject.transform.localScale = Vector3.zero;
            }
            else
            {
                this.mAnimator.Play("Open");
                this.mAnimator.Update(0.0f);
                AnimatorStateInfo info = this.mAnimator.GetCurrentAnimatorStateInfo(0);
                this.mCurveAnimTime = info.length;
            }
        }
	}

    private void OnHide()
    {
        if(this.mAnimator != null)
        {
            this.mAnimator.Play("Close");
            this.mAnimator.Update(0);
            this.mCurveAnimTime = this.mAnimator.GetCurrentAnimatorStateInfo(0).length;
        }
    }

    private void OnDestroy()
    {
        this.Dispose();
    }

	private void Update()
	{
		if( this.visibleType == VisibleType.NONE )
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		ScaleAnim( deltaTime );
		PositionAnim( deltaTime );
        CurveAnim(deltaTime);
	}

    private void CurveAnim(float deltaTime)
    {
        if(this.animType != ShowAnimType.curveAnim)
        {
            return;
        }
        this.visibleAnimationTimer += deltaTime;
        if(this.visibleAnimationTimer >= this.mCurveAnimTime)
        {
            this.visibleAnimationTimer = 0f;
            if (this.visibleType == VisibleType.SHOW)
            {
                this.visibleType = VisibleType.NONE;
                if (this.ShowedEvent != null)
                {
                    this.ShowedEvent(this);
                }
            }
            else
            {
                this.visibleType = VisibleType.NONE;
                this.Remove();
            }
        }
    }

	private void ScaleAnim( float deltaTime )
	{
		if( this.animType != ShowAnimType.scaleAnim )
		{
			return;
		}
		this.visibleAnimationTimer += deltaTime;
        float animTime = this.visibleType == VisibleType.SHOW ? 0.3f : 0.2f;
		if( this.visibleAnimationTimer < animTime)
		{
			float f = this.visibleAnimationTimer / animTime;
			float num = this.visibleType != VisibleType.SHOW ? Mathf.Cos(f) : Mathf.Sin(f);
            if(this.visibleType == VisibleType.SHOW)
            {
                num = Ease.Spring(num);
            }
			this.gameObject.transform.localScale = new Vector3( num, num, 1f );
		}
		else
		{
			this.visibleAnimationTimer = 0f;
			if( this.visibleType == VisibleType.SHOW )
			{
				this.visibleType = VisibleType.NONE;
				base.gameObject.transform.localScale = this.defaultScale;
				if( this.ShowedEvent != null )
				{
					this.ShowedEvent( this );
				}
			}
			else
			{
				this.visibleType = VisibleType.NONE;
				base.gameObject.transform.localScale = Vector3.zero;
				this.Remove();
			}
		}
	}

	private void PositionAnim( float deltaTime )
	{
		if( this.animType != ShowAnimType.positionAnim )
		{
			return;
		}
		this.visibleAnimationTimer += deltaTime;
		if( this.visibleAnimationTimer < this.visibleAnimationTime )
		{
			float t = Mathf.Sin( 90f * this.visibleAnimationTimer / this.visibleAnimationTime * Mathf.Deg2Rad );
			float pos = this.visibleType != VisibleType.SHOW ? Mathf.Lerp( 0f, this.showPosMoveLength, t ) : Mathf.Lerp( this.showPosMoveLength, 0f, t );
			this.gameObject.transform.localPosition = new Vector3( pos, 0f, 0f );
		}
		else
		{
			this.visibleAnimationTimer = 0f;
			if( this.visibleType == VisibleType.SHOW )
			{
				this.visibleType = VisibleType.NONE;
				this.gameObject.transform.localPosition = Vector3.zero;
				if( this.ShowedEvent != null )
				{
					this.ShowedEvent( this );
				}
			}
			else
			{
				this.visibleType = VisibleType.NONE;
				this.gameObject.transform.localPosition = new Vector3( this.showPosMoveLength, 0f, 0f );
				this.Remove();
			}
		}
	}

	private void PlayStateSE( DialogState state )
	{
		if( state == DialogState.OK )
		{
			//SoundManager.Instance.PlayOK();
		}
		else
		{
			//SoundManager.Instance.PlayCancel();
		}
	}

	#endregion
}
