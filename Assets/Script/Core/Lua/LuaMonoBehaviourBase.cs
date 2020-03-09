using UnityEngine;
using System.Collections;
using SLua;
using System.Collections.Generic;
using UnityEngine.SceneManagement;

[SLua.CustomLuaClass]
public class LuaMonoBehaviourBase : MonoBehaviour
{
    #region 回调方法
    public enum LuaMonoMethod
    {
        Start,
        Update,
        FixedUpdate,
        LateUpdate,
        OnEnable,
        OnDisable,
        OnDestroy,
        OnTriggerEnter,
        OnTriggerEnter2D,
        OnTriggerExit,
        OnTriggerExit2D,
        OnCollisionEnter,
        OnCollisionEnter2D,
        OnCollisionStay,
        OnCollisionExit,
        OnCollisionExit2D,
        OnClick,
        OnPointerEnter,
        OnPointerDown,
        OnPointerUp,
        OnPointerExit,
        OnRenderImage
    }

    private static string[] mLuaMonoMethd;

    //private Dictionary<LuaMonoMethod, LuaFunction> m_mapMonoMethod;
    private LuaFunction[] m_mapMonoMethod;

    #endregion

    [SerializeField]
    protected string m_LuaClassName;

    protected LuaTable m_table;

    protected int m_currentLayer;

    #region public

    public string LuaClassName
    {
        get
        {
            return m_LuaClassName;
        }
    }

    //取绑定的lua脚本
    public LuaTable GetLuaTable()
    {
        return this.m_table;
    }

    public void CleanLuaTable()
    {
        this.m_table.Dispose();
        this.m_table = null;
    }

    public LuaTable DoFile(string fn)
    {
        return this.DoFile(fn, false);
    }

    public LuaTable DoFile(string fn, bool forceDoFile)
    {
        if (m_LuaClassName == fn && this.m_table != null)
        {
            if(!forceDoFile)
            {
                return this.m_table;
            }
        }
        m_LuaClassName = fn;
        DoFileEx(fn);
        return this.m_table;
    }

    public void LuaInvoke(float delayTime, LuaFunction func, params object[] args)
    {
        StartCoroutine(doInvoke(delayTime, func, args));
    }

    public void RunCoroutine(YieldInstruction ins, LuaFunction func, params System.Object[] args)
    {
        StartCoroutine(doCoroutine(ins, func, args));
    }

    public void CancelCoroutine(YieldInstruction ins, LuaFunction func, params System.Object[] args)
    {
        StopCoroutine(doCoroutine(ins, func, args));
    }

    public void CallLuaFunction(string func)
    {
        CallMethod(func);
    }

    public void CallLuaFunction(string func, object arg)
    {
        CallMethod(func, arg);
    }

    public void CallLuaFunction(string func, object arg0, object arg1)
    {
        CallMethod(func, arg0, arg1);
    }

    public void CallLuaFunctionByParams(string func, params object[] args)
    {
        CallMethod(func, args);
    }

    #endregion

    #region CallMonoMethod

    virtual protected void Awake()
    {
        /*
        if (string.IsNullOrEmpty(m_LuaClassName))
        {
            m_LuaClassName = this.gameObject.name;
            Debug.LogWarning("You do not set lua class name, use GameObject's name \'" + gameObject.name + "\' instead!");
        }
       	*/

        this.m_currentLayer = this.gameObject.layer;

        if (string.IsNullOrEmpty(m_LuaClassName))
        {
            return;
        }
        DoFile(m_LuaClassName);
    }

    virtual protected void Update()
    {
        if(this.m_currentLayer != this.gameObject.layer)
        {
            this.m_currentLayer = this.gameObject.layer;
            if(this.m_currentLayer == GameUtil.HideLayer)
            {
                this.OnDisable();
            }
            else
            {
                if(this.m_table == null)
                {
                    if (!string.IsNullOrEmpty(m_LuaClassName))
                    {
                        DoFile(m_LuaClassName);
                    }
                }
                this.OnEnable();
            }
        }

        if(this.m_currentLayer != GameUtil.HideLayer)
        {
#if UNITY_EDITOR
            GameUtil.BeginMarkTime();
            UnityEngine.Profiling.Profiler.BeginSample(this.LuaClassName);
#endif
            CallMethod(LuaMonoMethod.Update);
#if UNITY_EDITOR
            UnityEngine.Profiling.Profiler.EndSample();
            GameUtil.EndMarkTime(this.LuaClassName, 5);
#endif

        }
    }

    protected void FixedUpdate()
    {
        if (this.m_currentLayer != GameUtil.HideLayer)
        {
            CallMethod(LuaMonoMethod.FixedUpdate);
        }
    }

    protected void LateUpdate()
    {
        if (this.m_currentLayer != GameUtil.HideLayer)
        {
            CallMethod(LuaMonoMethod.LateUpdate);
        }
    }

    protected void OnEnable()
    {
        CallMethod(LuaMonoMethod.OnEnable);
    }

    protected void OnDisable()
    {
        CallMethod(LuaMonoMethod.OnDisable);
    }

    virtual protected void OnDestroy()
    {
        CallMethod(LuaMonoMethod.OnDestroy);
        if(this.m_table != null)
        {
            this.m_table.Dispose();
            this.m_table = null;
        }
    }

    protected void OnTriggerEnter(Collider other)
    {
        CallMethod(LuaMonoMethod.OnTriggerEnter, other);
    }
    protected void OnTriggerEnter2D(Collider2D other)
    {
        CallMethod(LuaMonoMethod.OnTriggerEnter2D, other);
    }
    protected void OnTriggerExit(Collider other)
    {
        CallMethod(LuaMonoMethod.OnTriggerExit, other);
    }
    protected void OnTriggerExit2D(Collider2D other)
    {
        CallMethod(LuaMonoMethod.OnTriggerExit2D, other);
    }
    protected void OnCollisionEnter(Collision col)
    {
        CallMethod(LuaMonoMethod.OnCollisionEnter, col);
    }
    protected void OnCollisionEnter2D(Collision2D col)
    {
        CallMethod(LuaMonoMethod.OnCollisionEnter2D, col);
    }
    protected void OnCollisionStay(Collision collision)
    {
        CallMethod(LuaMonoMethod.OnCollisionStay, collision);
    }
    protected void OnCollisionExit(Collision col)
    {
        CallMethod(LuaMonoMethod.OnCollisionExit, col);
    }
    protected void OnCollisionExit2D(Collision2D col)
    {
        CallMethod(LuaMonoMethod.OnCollisionExit2D, col);
    }

    private void SetBehaviour(LuaTable myTable)
    {
        m_table = myTable;

        m_table["this"] = this;
        m_table["transform"] = transform;
        m_table["gameObject"] = this.gameObject;

        //m_mapMonoMethod = new Dictionary<LuaMonoMethod, LuaFunction>();
        int len = System.Enum.GetValues(typeof(LuaMonoBehaviour.LuaMonoMethod)).Length;
        m_mapMonoMethod = new LuaFunction[len];
        if (mLuaMonoMethd == null)
        {
            mLuaMonoMethd = new string[len];
            for (int i = 0; i < len; i++)
            {
                LuaMonoMethod method = (LuaMonoMethod)i;
                mLuaMonoMethd[i] = method.ToString();
            }
        }
        for (int i = 0; i < len; i++)
        {
            string methodName = mLuaMonoMethd[i];
            m_mapMonoMethod[i] = m_table[methodName] as LuaFunction;
        }

        CallMethod(LuaMonoMethod.Start);

        CallMethod(LuaMonoMethod.OnEnable);

        if (this.gameObject.activeSelf == false)
        {
            //OnDestroy被调用的前提是，这个gameObject被激活过
            this.gameObject.SetActive(true);
            this.gameObject.SetActive(false);
        }
    }

    #endregion

    #region private & protected

    protected object CallMethod(string methodName)
    {
        if(m_table == null)
        {
            return null;
        }
        func = m_table[methodName] as LuaFunction;
        if(func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table);
            }
            return func.call();
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(string methodName, object arg)
    {
        if (m_table == null)
        {
            return null;
        }
        func = m_table[methodName] as LuaFunction;
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table, arg);
            }
            return func.call(arg);
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(string methodName, object arg0, object arg1)
    {
        if (m_table == null)
        {
            return null;
        }
        func = m_table[methodName] as LuaFunction;
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table, arg0, arg1);
            }
            return func.call(arg0, arg1);
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(string methodName, params object[] args)
    {
        if (m_table == null)
        {
            return null;
        }
        func = m_table[methodName] as LuaFunction;
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table, args);
            }
            return func.call(args);
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(LuaMonoMethod method)
    {
        if (m_mapMonoMethod == null)
        {
            return null;
        }
        func = null;
        int i = (int)method;
        func = m_mapMonoMethod[i];
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table);
            }
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(LuaMonoMethod method, object arg)
    {
        if (m_mapMonoMethod == null)
        {
            return null;
        }
        func = null;
        int i = (int)method;
        func = m_mapMonoMethod[i];
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table, arg);
            }
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    protected object CallMethod(LuaMonoMethod method, object arg0, object arg1)
    {
        if (m_mapMonoMethod == null)
        {
            return null;
        }
        func = null;
        int i = (int)method;
        func = m_mapMonoMethod[i];
        if (func == null)
        {
            return null;
        }
        try
        {
            if (m_table != null)
            {
                return func.call(m_table, arg0, arg1);
            }
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    LuaFunction func = null;
    protected object CallMethod(LuaMonoMethod method, params object[] args)
    {
        if (m_mapMonoMethod == null)
        {
            return null;
        }
        func = null;
        int i = (int)method;
        func = m_mapMonoMethod[i];
        if (func == null)
        {
            return null;
        }
        try
        {
            if (args != null)
            {
                return func.call(args);
            }
            return func.call();
        }
        catch (System.Exception e)
        {
            Debug.LogWarning(FormatException(e), gameObject);
        }
        return null;
    }

    private IEnumerator doInvoke(float delayTime, LuaFunction func, params object[] args)
    {
        yield return new WaitForSeconds(delayTime);
        if (args != null)
        {
            func.call(args);
        }
        else
        {
            func.call();
        }
    }

    private IEnumerator doCoroutine(YieldInstruction ins, LuaFunction func, params System.Object[] args)
    {
        yield return ins;
        if (args != null)
        {
            func.call(args);
        }
        else
        {
            func.call();
        }
    }

    private void DoFileEx(string fn)
    {
        if (OzLuaManager.Instance == null || !OzLuaManager.Instance.isReady)
        {
            //Debug.LogErrorFormat("OzLuaManager do not initialize. error:{0}", fn);
            SceneManager.LoadScene("start");
            return;
        }
        try
        {
            object chunk = OzLuaManager.Instance.DoFile(fn);
            if (chunk != null && (chunk is LuaTable))
            {
                SetBehaviour(chunk as LuaTable);
            }
        }
        catch (System.Exception e)
        {
            Debug.LogError(FormatException(e), gameObject);
        }
    }

    public static string FormatException(System.Exception e)
    {
        string source = (string.IsNullOrEmpty(e.Source)) ? "<no source>" : e.Source.Substring(0, e.Source.Length - 2);
        return string.Format("{0}\nLua (at {2})", e.Message, string.Empty, source);
    }
    #endregion
}
