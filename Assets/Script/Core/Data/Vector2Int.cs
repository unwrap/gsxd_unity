using System.Diagnostics;
using UnityEngine;

[SLua.CustomLuaClass]
[System.Serializable]
[DebuggerDisplay("v2Int:({x}, {y})")]
public class Vector2Int
{
    public int x = 0;
    public int y = 0;

    [System.NonSerialized]
    public bool isMark = false;

    public Vector2Int(int x, int y)
    {
        this.x = x;
        this.y = y;
    }

    public Vector2Int()
    { }

    public Vector2Int(Vector3 position)
    {
        this.x = Mathf.FloorToInt(position.x);
        this.y = Mathf.FloorToInt(position.y);
    }

    public Vector2 ToVector2()
    {
        return new Vector2(x, y);
    }

    public override string ToString()
    {
        return string.Format("({0}, {1})", x, y);
    }

    public bool Equals(Vector2Int other)
    {
        if (ReferenceEquals(null, other)) return false;
        if (ReferenceEquals(this, other)) return true;
        return other.x == x && other.y == y;
    }

    public override bool Equals(object obj)
    {
        if (ReferenceEquals(null, obj)) return false;
        if (ReferenceEquals(this, obj)) return true;
        return obj.GetType() == typeof(Vector2Int) && Equals((Vector2Int)obj);
    }

    public override int GetHashCode()
    {
        unchecked
        {
            return (x * 397) ^ y;
        }
    }

    public static bool operator ==(Vector2Int left, Vector2Int right)
    {
        return Equals(left, right);
    }

    public static bool operator !=(Vector2Int left, Vector2Int right)
    {
        return !Equals(left, right);
    }

    public static Vector2Int operator +(Vector2Int left, Vector2Int right)
    {
        return new Vector2Int(left.x + right.x, left.y + right.y);
    }

    public static Vector2Int operator -(Vector2Int left, Vector2Int right)
    {
        return new Vector2Int(left.x - right.x, left.y - right.y);
    }

    public static Vector2Int operator *(Vector2Int a, int b)
    {
        return new Vector2Int(a.x * b, a.y * b);
    }

}
