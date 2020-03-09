using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class KeyVData : ScriptableObject
{
	private static KeyVData m_instance;
	public static KeyVData Instance
	{
		get 
		{
			if (m_instance == null) 
			{
				m_instance = Resources.Load<KeyVData>("des");
				#if UNITY_EDITOR
				if(m_instance == null)
				{
					m_instance =  KeyVData.CreateInstance<KeyVData>();
					AssetDatabase.CreateAsset(m_instance,"Assets/Resources/des.asset");
				}
				#endif
			}
			return m_instance;
		}
	}

    public byte[] KEY;
    public byte[] IV;
    public string version;
}
