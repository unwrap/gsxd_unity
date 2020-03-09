using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using SLua;

[SLua.CustomLuaClass]
public class UIManager : MonoBehaviour
{
    private static UIManager m_instance;

    public static UIManager Instance
    {
        get
        {
            if (m_instance == null)
            {
                m_instance = GameObject.FindObjectOfType<UIManager>();
                if (m_instance == null)
                {
                    GameObject objPrefab = Resources.Load<GameObject>("Prefabs/Canvas");
                    GameObject obj = GameObject.Instantiate(objPrefab);
                    m_instance = obj.AddMissingComponent<UIManager>();
                }
                m_instance.gameObject.name = "Canvas";
            }
            return m_instance;
        }
    }

    public static LuaFunction onInit;

    #region member

	private Canvas m_canvas;
	private Camera m_uiCamera;

    private RectTransform m_canvasRoot;
    private RectTransform m_contentRoot;
    private RectTransform m_hudRoot;
    private RectTransform m_hud4BuildingRoot;
    private RectTransform m_hud4BattleRoot;
    private RectTransform m_dialogRoot;
    private RectTransform m_guideRoot;
    private RectTransform m_waitingRoot;
    private RectTransform m_alertRoot;
    private RectTransform m_tooltipRoot;
    private GameObject m_modal;
    private Image m_modalImage;

    private Color defaultColor;
    private bool isModalShowAnim;
    private bool isModalHideAnim;
    private float animTimer;
    private readonly float animTime = 0.3f;

    private int modalNum = 0;

    #endregion

    #region public

    public Vector2 size
    {
        get
        {
            if (m_canvasRoot != null)
            {
                return this.m_canvasRoot.sizeDelta;
            }
            return Vector2.one;
        }
    }

	public Canvas canvas
	{
		get
		{
			return this.m_canvas;
		}
	}

	public Camera uiCamera
	{
		get
		{
			return this.m_uiCamera;
		}
	}

    public RectTransform ContentRoot
    {
        get
        {
            return this.m_contentRoot;
        }
    }

    public RectTransform HUD4BattleRoot
    {
        get
        {
            return this.m_hud4BattleRoot;
        }
    }

    public RectTransform HUDRoot
    {
        get
        {
            return this.m_hudRoot;
        }
    }

    public RectTransform HUD4BuildingRoot
    {
        get
        {
            return this.m_hud4BuildingRoot;
        }
    }

    public RectTransform DialogRoot
    {
        get
        {
            return this.m_dialogRoot;
        }
    }

    public RectTransform GuideRoot
    {
        get
        {
            return this.m_guideRoot;
        }
    }

    public RectTransform WaitingRoot
    {
        get
        {
            return this.m_waitingRoot;
        }
    }

    public RectTransform AlertRoot
    {
        get
        {
            return this.m_alertRoot;
        }
    }

    public RectTransform TooltipRoot
    {
        get
        {
            return this.m_tooltipRoot;
        }
    }

    public void AddAlert(GameObject go)
    {
        Transform rt = go.GetComponent<Transform>();
        AddAlert(rt);
    }

    public void AddAlert(Transform alert)
    {
        if (alert == null)
        {
            return;
        }
        alert.SetParent(m_alertRoot);
        alert.localPosition = Vector3.zero;
        alert.localScale = Vector3.one;
    }

    public void AddWaiting(GameObject go)
    {
        RectTransform rt = go.GetComponent<RectTransform>();
        AddWaiting(rt);
    }

    public void AddWaiting(RectTransform tf)
    {
        if (tf == null)
        {
            return;
        }
        tf.SetParent(m_waitingRoot);
        tf.localPosition = Vector3.zero;
        tf.localScale = Vector3.one;
    }

    public void AddDialog(GameObject go)
    {
        RectTransform rt = go.GetComponent<RectTransform>();
        AddDialog(rt);
    }

    public void AddDialog(RectTransform dialog)
    {
        if (dialog == null)
        {
            return;
        }
        dialog.SetParent(m_dialogRoot);
        dialog.localPosition = Vector3.zero;
        dialog.localScale = Vector3.one;
    }

    public void ShowModal(bool animation)
    {
        this.modalNum++;
        if (this.modalNum > 1)
        {
            return;
        }
        this.m_modal.SetActive(true);
        if (animation)
        {
            this.m_modalImage.color = new Color(this.defaultColor.r, this.defaultColor.g, this.defaultColor.b, 0.0f);
            this.animTimer = 0.0f;
            this.isModalShowAnim = true;
            this.isModalHideAnim = false;
        }
        else
        {
            this.m_modalImage.color = this.defaultColor;
            this.animTimer = 0.0f;
            this.isModalShowAnim = false;
        }
    }

    public void ForceHideModal(bool animation)
    {
        this.modalNum = 0;
        this.HideModal(animation);
    }

    public void HideModal(bool animation)
    {
        this.modalNum--;
        if(this.modalNum > 0)
        {
            return;
        }
        if(this.modalNum < 0)
        {
            this.modalNum = 0;
        }
        if (animation)
        {
            this.animTimer = 0.0f;
            this.isModalShowAnim = false;
            this.isModalHideAnim = true;
        }
        else
        {
            this.m_modalImage.color = this.defaultColor;
            this.animTimer = 0.0f;
            this.isModalHideAnim = false;
            this.m_modal.SetActive(false);
        }
    }

    #endregion

    #region private

    private void Awake()
    {
        m_instance = this;
        modalNum = 0;

        this.m_canvas = this.gameObject.GetComponent<Canvas>();
		this.m_uiCamera = this.gameObject.GetComponentInChildren<Camera>();

        this.m_canvasRoot = this.transform as RectTransform;
        if (this.m_canvasRoot == null)
        {
            this.m_canvasRoot = this.gameObject.AddComponent<RectTransform>();
        }
        this.m_contentRoot = this.m_canvasRoot.Find("Content") as RectTransform;
        if (this.m_contentRoot == null)
        {
            this.m_contentRoot = AddChild("Content", this.m_canvasRoot);
        }
        this.m_hudRoot = this.m_contentRoot.Find("HUD") as RectTransform;
        if(this.m_hudRoot == null)
        {
            this.m_hudRoot = AddChild("HUD", this.m_canvasRoot);
        }
        this.m_hudRoot.SetAsFirstSibling();

        this.m_hud4BattleRoot = this.m_contentRoot.Find("HUD4Battle") as RectTransform;
        if(this.m_hud4BattleRoot == null)
        {
            this.m_hud4BattleRoot = AddChild("HUD4Battle", this.m_canvasRoot);
        }
        this.m_hud4BattleRoot.SetAsFirstSibling();

        this.m_hud4BuildingRoot = this.m_hudRoot.Find("HUD4Building") as RectTransform;
        if(this.m_hud4BuildingRoot == null)
        {
            this.m_hud4BuildingRoot = AddChild("HUD4Building", this.m_hudRoot);
        }
        this.m_hud4BuildingRoot.SetAsFirstSibling();

        this.m_dialogRoot = this.m_canvasRoot.Find("Dialog") as RectTransform;
        if (this.m_dialogRoot == null)
        {
            this.m_dialogRoot = AddChild("Dialog", this.m_canvasRoot);
        }

        RectTransform tf = this.m_dialogRoot.Find("Modal") as RectTransform;
        if (tf == null)
        {
            tf = AddChild("Modal", this.m_dialogRoot);
        }
        this.m_modal = tf.gameObject;
        this.m_modalImage = this.m_modal.GetComponent<Image>();
        if (this.m_modalImage == null)
        {
            this.m_modalImage = this.m_modal.gameObject.AddComponent<Image>();
            this.m_modalImage.color = new Color(0.0f, 0.0f, 0.0f, 0.5f);
        }
        this.defaultColor = this.m_modalImage.color;
        this.m_modal.SetActive(false);

        this.m_guideRoot = this.m_canvasRoot.Find("Guide") as RectTransform;
        if (this.m_guideRoot == null)
        {
            this.m_guideRoot = AddChild("Guide", this.m_canvasRoot);
            this.m_guideRoot.SetSiblingIndex(this.m_dialogRoot.GetSiblingIndex() + 1);
        }

        this.m_waitingRoot = this.m_canvasRoot.Find("Waiting") as RectTransform;
        if (this.m_waitingRoot == null)
        {
            this.m_waitingRoot = AddChild("Waiting", this.m_canvasRoot);
        }

        this.m_tooltipRoot = this.m_canvasRoot.Find("Tooltip") as RectTransform;
        if(this.m_tooltipRoot == null)
        {
            this.m_tooltipRoot = AddChild("Tooltip", this.m_canvasRoot);
        }

        this.m_alertRoot = this.m_canvasRoot.Find("Alert") as RectTransform;
        if (this.m_alertRoot == null)
        {
            GameObject go = new GameObject("Alert");
            this.m_alertRoot = go.AddComponent<RectTransform>();
            this.m_alertRoot.SetParent(this.m_canvasRoot, false);
            this.m_alertRoot.offsetMax = Vector2.zero;
            this.m_alertRoot.offsetMin = Vector2.zero;
            this.m_alertRoot.anchorMin = Vector2.zero;
            this.m_alertRoot.anchorMax = Vector2.one;
            GameUtil.SetLayer(this.m_alertRoot, 5);
        }

        if( UIManager.onInit != null )
        {
            UIManager.onInit.call();
        }
    }

    private void OnDestroy()
    {
        modalNum = 0;
        m_instance = null;
		this.m_uiCamera = null;
    }

    private void Update()
    {
        float deltaTime = Time.deltaTime;
        AnimationModalShow(deltaTime);
        AnimationModalHide(deltaTime);
    }

    private RectTransform AddChild(string name, RectTransform parent)
    {
        GameObject go = new GameObject(name);
        RectTransform tf = go.AddComponent<RectTransform>();
        tf.SetParent(parent, false);
        tf.offsetMax = Vector2.zero;
        tf.offsetMin = Vector2.zero;
        tf.anchorMin = Vector2.zero;
        tf.anchorMax = Vector2.one;
        GameUtil.SetLayer(tf, 5);
        return tf;
    }

    private void AnimationModalShow(float deltaTime)
    {
        if (!this.isModalShowAnim)
        {
            return;
        }
        this.animTimer += deltaTime;
        if (this.animTimer < this.animTime)
        {
            float num = Mathf.Sin(90f * this.animTimer / this.animTime * Mathf.Deg2Rad);
            this.m_modalImage.color = new Color(this.defaultColor.r, this.defaultColor.g, this.defaultColor.b, this.defaultColor.a * num);
        }
        else
        {
            this.m_modalImage.color = this.defaultColor;
            this.animTimer = 0.0f;
            this.isModalShowAnim = false;
        }
    }

    private void AnimationModalHide(float deltaTime)
    {
        if (!this.isModalHideAnim)
        {
            return;
        }
        this.animTimer += deltaTime;
        if (this.animTimer < this.animTime)
        {
            float num = Mathf.Sin(90f * this.animTimer / this.animTime * Mathf.Deg2Rad);
            this.m_modalImage.color = new Color(this.defaultColor.r, this.defaultColor.g, this.defaultColor.b, this.defaultColor.a * (1.0f - num));
        }
        else
        {
            this.m_modalImage.color = this.defaultColor;
            this.animTimer = 0.0f;
            this.isModalHideAnim = false;
            this.m_modal.SetActive(false);
        }
    }

    #endregion
}
