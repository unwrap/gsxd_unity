using System.Collections.Generic;

public class CoreObjectPool<T> where T : class
{
    public delegate T Constructor();
    public delegate void OnReturn(T obj);
    public delegate void OnGet(T obj);

    private Constructor constructor;
    private OnReturn onReturn;
    private OnGet onGet;

    private int maxPoolSize;
    private Stack<T> pool = new Stack<T>();
    private HashSet<T> poolHashSet = new HashSet<T>();
    private object poolLock = new object();

    public int count
    {
        get
        {
            lock (this.poolLock)
            {
                return this.pool.Count;
            }
        }
    }

    public CoreObjectPool(Constructor constructor, int maxPoolSize = 1000, OnReturn onReturn = null, OnGet onGet = null)
    {
        this.constructor = constructor;
        this.onReturn = onReturn;
        this.onGet = onGet;
        this.maxPoolSize = maxPoolSize;
    }

    public void GetIfNull(ref T obj)
    {
        if (object.ReferenceEquals(obj, null))
            obj = Get();
    }

    public T Get()
    {
        T obj = null;
        // Pool check
        lock (this.poolLock)
        {
            if (this.pool.Count > 0)
            {
                obj = this.pool.Pop();
                this.poolHashSet.Remove(obj);
            }
        }

        // Construct new object if necessary
        if (object.ReferenceEquals(obj, null))
            obj = this.constructor();

        // Invoke onGet
        if (!object.ReferenceEquals(this.onGet, null))
            this.onGet(obj);

        return obj;
    }

    public void Return(T obj)
    {
        if (obj == null)
            return;

        // Contains check
        lock (this.poolLock)
        {
            if (this.poolHashSet.Contains(obj))
            {
                return; // Duplicate
            }
        }

        // Invoke onReturn
        if (!object.ReferenceEquals(this.onReturn, null))
            this.onReturn(obj);

        // Insert
        lock (this.poolLock)
        {
            if (this.pool.Count < this.maxPoolSize)
            {
                this.pool.Push(obj);
                this.poolHashSet.Add(obj);
            }
        }
    }
}
