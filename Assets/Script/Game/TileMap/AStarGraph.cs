using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[SerializeField]
public class AStarGraph
{
    [SerializeField]
    private int m_width;
    [SerializeField]
    private int m_height;
    [SerializeField]
    private int m_nodeSize;

#if UNITY_EDITOR
    public void DrawGraph(Vector3 pos)
    {
        Gizmos.color = Color.blue;



    }
#endif
}
