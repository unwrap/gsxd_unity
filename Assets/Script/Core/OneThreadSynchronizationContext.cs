using System;
using System.Collections.Concurrent;
using System.Threading;

public class OneThreadSynchronizationContext : SynchronizationContext
{
    private static OneThreadSynchronizationContext _instance;
    public static OneThreadSynchronizationContext Instance
    {
        get
        {
            if(_instance == null)
            {
                _instance = new OneThreadSynchronizationContext();
            }
            return _instance;
        }
    }

    private readonly int mainThreadId = Thread.CurrentThread.ManagedThreadId;

    // 线程同步队列,发送接收socket回调都放到该队列,由poll线程统一执行
    private readonly ConcurrentQueue<Action> queue = new ConcurrentQueue<Action>();

    private Action a;

    public void Update()
    {
        while (true)
        {
            if (!this.queue.TryDequeue(out a))
            {
                return;
            }
            a();
        }
    }

    public void OnDestroy()
    {
        _instance = null;
    }

    public override void Post(SendOrPostCallback callback, object state)
    {
        if (Thread.CurrentThread.ManagedThreadId == this.mainThreadId)
        {
            callback(state);
            return;
        }

        this.queue.Enqueue(() => { callback(state); });
    }
}
