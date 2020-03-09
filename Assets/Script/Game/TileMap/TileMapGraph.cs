using System;
using System.Collections;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif
using UnityEngine;

[SLua.CustomLuaClass]
public class TileMapGraph : MonoBehaviour
{
    [Serializable]
    public class TileTypeDictionary : SerializableDictionary<int, TileType> { }

    [SLua.DoNotToLua]
    public GameObject[] tilePrefabs;
    [SLua.DoNotToLua]
    public GameObject[] wallPrefabs;

    public float width = 8;
    public float length = 15;
   
    public float nodeSize = 0.4f;

    public int xNode
    {
        get
        {
            return Mathf.CeilToInt(width / nodeSize);
        }
    }
    public int zNode
    {
        get
        {
            return Mathf.CeilToInt(length / nodeSize);
        }
    }

    [SerializeField]
    private TileTypeDictionary idx2TileType = new TileTypeDictionary();

    public TileType GetTileValue(int x, int z)
    {
        int index = z * xNode + x;
        return GetTileValue(index);
    }

    private TileType GetTileValue(int index)
    {
        if(index >= xNode * zNode)
        {
            return TileType.Block;
        }
        if(idx2TileType.ContainsKey(index))
        {
            return idx2TileType[index];
        }
        return TileType.None;
    }

    public void SetTileValue(int x, int z, TileType t)
    {
        if(x < 0 || z < 0)
        {
            return;
        }
        int index = z * xNode + x;
        if(index >= xNode * zNode)
        {
            return;
        }
        idx2TileType[index] = t;
#if UNITY_EDITOR
        EditorUtility.SetDirty(this);
#endif
    }

    public void SetTileValues()
    {

    }

#if UNITY_EDITOR
    //A*
    [SLua.DoNotToLua]
    public bool drawGizmos = false;

    [SLua.DoNotToLua]
    public void InitValues()
    {
        idx2TileType.Clear();
    }

    [SLua.DoNotToLua]
    public void EditorObserver(float x, float z, TileType t)
    {
        Vector3 offset = new Vector3(-xNode * nodeSize * 0.5f, 0, -zNode * nodeSize * 0.5f);
        Vector3 current = new Vector3(x, 0, z) - offset;

        int xPos = Mathf.FloorToInt(current.x / nodeSize);
        int zPos = Mathf.FloorToInt(current.z / nodeSize);

        //Debug.LogFormat("x:{0}, z:{1}, t:{2}, x1:{3}, z1:{4}", xPos, zPos, t, x, z);

        SetTileValue(xPos, zPos, t);
    }

    [SLua.DoNotToLua]
    public void OnDrawGizmosSelected()
    {
        if(!drawGizmos)
        {
            return;
        }
        Gizmos.color = Color.blue;

        Vector3 offset = new Vector3(-xNode * nodeSize * 0.5f, 0, -zNode * nodeSize * 0.5f);
        float yPos = 0.1f;

        /*
        Vector3 topLeft = Vector3.zero + offset;
        Vector3 topRight = new Vector3(0, yPos, zNode * nodeSize) + offset;
        Vector3 bottomLeft = new Vector3(xNode * nodeSize, yPos, 0) + offset;
        Vector3 bottomRight = new Vector3(xNode * nodeSize, yPos, zNode * nodeSize) + offset;
        Gizmos.DrawLine(topLeft, topRight);
        Gizmos.DrawLine(topRight, bottomRight);
        Gizmos.DrawLine(bottomRight, bottomLeft);
        Gizmos.DrawLine(bottomLeft, topLeft);
        */
        
        for(int x = 0; x <= xNode; x++)
        {
            Vector3 a = new Vector3(x * nodeSize, yPos, 0) + offset;
            Vector3 b = new Vector3(x * nodeSize, yPos, zNode * nodeSize) + offset;
            Gizmos.DrawLine(a, b);
        }
        for(int z = 0; z <= zNode; z++)
        {
            Vector3 a = new Vector3(0, yPos, z * nodeSize) + offset;
            Vector3 b = new Vector3(xNode * nodeSize, yPos, z * nodeSize) + offset;
            Gizmos.DrawLine(a, b);
        }

        for(int x = 0; x < xNode; x++)
        {
            for(int z = 0; z < zNode; z++)
            {
                TileType t = GetTileValue(x, z);
                if(t != TileType.None)
                {
                    DrawGrid(offset, nodeSize, x, z);
                }
            }
        }
    }

    private void DrawGrid(Vector3 offset, float nodeSize, int x, int z)
    {
        float yPos = 0.15f;
        Vector3 a = new Vector3(x * nodeSize, yPos, z * nodeSize) + offset;
        Vector3 b = new Vector3(x * nodeSize, yPos, (z + 1) * nodeSize) + offset;
        Vector3 c = new Vector3((x + 1) * nodeSize, yPos, z * nodeSize) + offset;
        Vector3 d = new Vector3((x + 1) * nodeSize, yPos, (z + 1) * nodeSize) + offset;

        Gizmos.color = Color.red;
        Gizmos.DrawLine(a, b);
        Gizmos.DrawLine(b, d);
        Gizmos.DrawLine(d, c);
        Gizmos.DrawLine(c, a);
    }
#endif
}
