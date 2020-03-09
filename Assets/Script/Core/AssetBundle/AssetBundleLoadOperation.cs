using UnityEngine;
using System.Collections;
using System;
using UnityEngine.SceneManagement;

[SLua.CustomLuaClass]
public abstract class AssetBundleLoadOperation : IEnumerator
{
	public object Current
	{
		get
		{
			return null;
		}
	}

	public bool MoveNext()
	{
		return !IsDone();
	}

	public void Reset()
	{
	}

	public abstract bool Update();

	public abstract bool IsDone();
}

#if UNITY_EDITOR
public class AssetBundleLoadLevelSimulationOperation : AssetBundleLoadOperation
{
	AsyncOperation m_Operation = null;

	public AssetBundleLoadLevelSimulationOperation(string assetBundleName, string levelName)
	{
		string[] levelPaths = UnityEditor.AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName(assetBundleName, levelName);
		if(levelPaths.Length == 0)
		{
			Debug.LogError("There is no scene with name \"" + levelName + "\" in " + assetBundleName);
			return;
		}
		m_Operation = UnityEditor.EditorApplication.LoadLevelAsyncInPlayMode(levelPaths[0]);
	}

	public override bool IsDone()
	{
		return m_Operation == null || m_Operation.isDone;
	}

	public override bool Update()
	{
		return false;
	}
}
#endif

[SLua.CustomLuaClass]
public class AssetBundleLoadLevelOperation : AssetBundleLoadOperation
{
	protected string m_AssetBundleName;
	protected string m_LevelName;
	protected AsyncOperation m_Request;

	public AssetBundleLoadLevelOperation(string assetbundleName, string levelName)
	{
		this.m_AssetBundleName = assetbundleName;
		this.m_LevelName = levelName;
	}

	public override bool IsDone()
	{
		return m_Request != null && m_Request.isDone;
	}

	public override bool Update()
	{
		if(this.m_Request != null)
		{
			return false;
		}
		LoadedAssetBundle bundle = AssetBundleManager.GetLoadedAssetBundle(m_AssetBundleName);
		if(bundle != null)
		{
			m_Request = SceneManager.LoadSceneAsync(m_LevelName);
			return false;
		}
		return true;
	}
}

[SLua.CustomLuaClass]
public abstract class AssetBundleDownloadOperation:AssetBundleLoadOperation
{
    bool done;

    public string assetBundleName { get; private set; }
    public LoadedAssetBundle assetBundle { get; protected set; }
    public string error { get; protected set; }

    protected abstract bool downloadIsDone { get; }
    protected abstract void FinishDownload();

    public override bool Update()
    {
        if (!done && downloadIsDone)
        {
            FinishDownload();
            done = true;
        }

        return !done;
    }

    public override bool IsDone()
    {
        return done;
    }

    public AssetBundleDownloadOperation(string assetBundleName)
    {
        this.assetBundleName = assetBundleName;
    }
}

public class AssetBundleLoadFromFileAsyncOperation : AssetBundleDownloadOperation
{
    private AssetBundleCreateRequest m_request;
    private bool m_needUnload;

    public AssetBundleLoadFromFileAsyncOperation(string assetBundleName, AssetBundleCreateRequest req, bool needUnload) : base(assetBundleName)
    {
        this.m_request = req;
        this.m_needUnload = needUnload;
    }

    protected override bool downloadIsDone
    {
        get
        {
            return (m_request == null) || m_request.isDone;
        }
    }

    protected override void FinishDownload()
    {
        AssetBundle bundle = m_request.assetBundle;
        if(bundle == null)
        {
            error = string.Format("{0} is not a valid asset bundle.", assetBundleName);
        }
        else
        {
            assetBundle = new LoadedAssetBundle(bundle, assetBundleName, this.m_needUnload);
        }

        m_request = null;
    }
}

[SLua.CustomLuaClass]
public abstract class AssetBundleLoadAssetOperation:AssetBundleLoadOperation
{
	public abstract UnityEngine.Object GetAsset();

	public abstract GameObject GetGameObject();
}

#if UNITY_EDITOR
public class AssetBundleLoadAssetOperationSimulation : AssetBundleLoadAssetOperation
{
	UnityEngine.Object m_SimulatedObject;

	public AssetBundleLoadAssetOperationSimulation(UnityEngine.Object simulatedObject)
	{
		m_SimulatedObject = simulatedObject;
	}

    public float progress
    {
        get
        {
            return 1.0f;
        }
    }

	public override UnityEngine.Object GetAsset()
	{
		return m_SimulatedObject;
	}

	public override GameObject GetGameObject()
	{
		if(m_SimulatedObject == null)
		{
			return null;
		}
		GameObject go = GameUtil.Instantiate(m_SimulatedObject) as GameObject;
		return go;
	}

	public override bool IsDone()
	{
		return true;
	}

	public override bool Update()
	{
		return true;
	}
}
#endif

[SLua.CustomLuaClass]
public class AssetBundleLoadAssetOperationFull : AssetBundleLoadAssetOperation
{
	protected string m_AssetBundleName;
	protected string m_AssetName;
	protected System.Type m_Type;
	protected AssetBundleRequest m_Request = null;

	public AssetBundleLoadAssetOperationFull(string bundleName, string assetName, System.Type type)
	{
		this.m_AssetBundleName = bundleName;
		this.m_AssetName = assetName;
		this.m_Type = type;
	}

    public float progress
    {
        get
        {
            if(m_Request != null)
            {
                if(this.IsDone())
                {
                    return 1.0f;
                }
                return m_Request.progress;
            }
            return 1.0f;
        }
    }

    public override UnityEngine.Object GetAsset()
	{
		if(m_Request != null && m_Request.isDone)
		{
			return m_Request.asset;
		}
		return null;
	}

	public override GameObject GetGameObject()
	{
		if(m_Request != null && m_Request.isDone)
		{
			if(m_Request.asset == null)
			{
				return null;
			}
			GameObject go = GameUtil.Instantiate(m_Request.asset) as GameObject;
			if(go != null)
			{
				AssetBundleReference bundleRef = go.AddMissingComponent<AssetBundleReference>();
				bundleRef.assetBundleName = m_AssetBundleName;
			}
			return go;
		}
		return null;
	}

	public override bool IsDone()
	{
		return m_Request != null && m_Request.isDone;
	}

	public override bool Update()
	{
		if(m_Request != null)
		{
			return false;
		}
		LoadedAssetBundle bundle = AssetBundleManager.GetLoadedAssetBundle(m_AssetBundleName);
		if(bundle != null)
		{
            if (bundle.m_AssetBundle != null)
            {
                m_Request = bundle.m_AssetBundle.LoadAssetAsync(m_AssetName, m_Type);
            }
			return false;
		}
		return true;
	}
}

[SLua.CustomLuaClass]
public class AssetBundleLoadManifestOperation:AssetBundleLoadAssetOperationFull
{
	public AssetBundleLoadManifestOperation(string bundleName, string assetName, System.Type type) : base(bundleName, assetName, type)
	{
	}

	public override bool Update()
	{
		base.Update();
		if(m_Request != null && m_Request.isDone)
		{
			AssetBundleManager.AssetBundleManifestObject = GetAsset() as AssetBundleManifest;
			return false;
		}
		return true;
	}
}

