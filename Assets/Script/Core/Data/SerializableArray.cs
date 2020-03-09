using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SerializableArray<T> : IList<T>
{
    [SerializeField]
    private List<T> list;

    public SerializableArray()
    {
        list = new List<T>();
    }

    public SerializableArray(IEnumerable<T> collection)
    {
        list = new List<T>(collection);
    }

    public SerializableArray(int capacity)
    {
        list = new List<T>(capacity);
    }

    public T this[int index]
    {
        get
        {
            return list[index];
        }

        set
        {
            list[index] = value;
        }
    }

    public int Count
    {
        get
        {
            return list.Count;
        }
    }

    public bool IsReadOnly
    {
        get
        {
            return false;
        }
    }

    public void Add(T item)
    {
        list.Add(item);
    }

    public void Clear()
    {
        list.Clear();
    }

    public bool Contains(T item)
    {
        return list.Contains(item);
    }

    public void CopyTo(T[] array, int arrayIndex)
    {
        list.CopyTo(array, arrayIndex);
    }

    public IEnumerator<T> GetEnumerator()
    {
        return list.GetEnumerator();
    }

    public int IndexOf(T item)
    {
        return list.IndexOf(item);
    }

    public void Insert(int index, T item)
    {
        list.Insert(index, item);
    }

    public bool Remove(T item)
    {
        return list.Remove(item);
    }

    public void RemoveAt(int index)
    {
        list.RemoveAt(index);
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return list.GetEnumerator();
    }
}
