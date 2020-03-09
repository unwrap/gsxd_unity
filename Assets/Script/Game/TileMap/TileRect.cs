using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[SerializeField]
public class TileRect
{
    public TileType type;

    public int xMin;
    public int zMin;

    public int xMax;
    public int zMax;

    public int width
    {
        get
        {
            return xMax - xMin + 1;
        }
    }

    public int length
    {
        get
        {
            return zMax - zMin + 1;
        }
    }
}
