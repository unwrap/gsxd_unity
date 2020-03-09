using System.Collections.Generic;
using UnityEngine;

public static class ListPool<T>
{
    public static CoreObjectPool<List<T>> pool = new CoreObjectPool<List<T>>(() => new List<T>(), 1000, (lst) => lst.Clear());

    public static void GetIfNull(ref List<T> lst)
    {
        pool.GetIfNull(ref lst);
    }

    public static List<T> Get()
    {
        return pool.Get();
    }

    public static void Return(List<T> lst)
    {
        pool.Return(lst);
    }
}

public static class QueuePool<T>
{
    public static CoreObjectPool<Queue<T>> pool = new CoreObjectPool<Queue<T>>(() => new Queue<T>(), 1000, (queue) => queue.Clear());

    public static void GetIfNull(ref Queue<T> lst)
    {
        pool.GetIfNull(ref lst);
    }

    public static Queue<T> Get()
    {
        return pool.Get();
    }

    public static void Return(Queue<T> lst)
    {
        pool.Return(lst);
    }
}

public static class HashSetPool<T>
{
    public static CoreObjectPool<HashSet<T>> pool = new CoreObjectPool<HashSet<T>>(() => new HashSet<T>(), 1000, (lst) => lst.Clear());

    public static void GetIfNull(ref HashSet<T> lst)
    {
        pool.GetIfNull(ref lst);
    }

    public static HashSet<T> Get()
    {
        return pool.Get();
    }

    public static void Return(HashSet<T> lst)
    {
        pool.Return(lst);
    }
}

public static class DictionaryPool<TKey, TValue>
{
    public static CoreObjectPool<Dictionary<TKey, TValue>> pool = new CoreObjectPool<Dictionary<TKey, TValue>>(() => new Dictionary<TKey, TValue>(), 1000, (lst) => lst.Clear());

    public static void GetIfNull(ref Dictionary<TKey, TValue> dict)
    {
        pool.GetIfNull(ref dict);
    }

    public static Dictionary<TKey, TValue> Get()
    {
        return pool.Get();
    }

    public static void Return(Dictionary<TKey, TValue> dict)
    {
        pool.Return(dict);
    }
}

public static class GenericObjectPool<T> where T : class, new()
{
    private static CoreObjectPool<T> pool = new CoreObjectPool<T>(() => new T(), 30000);

    public static void GetIfNull(ref T obj)
    {
        pool.GetIfNull(ref obj);
    }

    public static T Get()
    {
        return pool.Get();
    }

    public static void Return(T obj)
    {
        pool.Return(obj);
    }
}
