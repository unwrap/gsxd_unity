using Microsoft.IO;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.WebSockets;

namespace ETModel
{
    public class WService : AService
    {
        private readonly HttpListener httpListener;
        private readonly Dictionary<long, WChannel> channels = new Dictionary<long, WChannel>();

        public RecyclableMemoryStreamManager MemoryStreamManager = new RecyclableMemoryStreamManager();

        public WService(IEnumerable<string> prefixs, Action<AChannel> acceptCallback)
        {
            this.AcceptCallback += acceptCallback;
            this.httpListener = new HttpListener();

            StartAccept(prefixs).Coroutine();
        }

        public WService()
        {
        }

        public override AChannel GetChannel(long id)
        {
            WChannel channel;
            this.channels.TryGetValue(id, out channel);
            return channel;
        }

        public override AChannel ConnectChannel(IPEndPoint ipEndPoint)
        {
            throw new System.NotImplementedException();
        }

        public override AChannel ConnectChannel(string address)
        {
            ClientWebSocket webSocket = new ClientWebSocket();
            WChannel channel = new WChannel(webSocket, this);
            this.channels[channel.Id] = channel;
            channel.ConnectAsync(address).Coroutine();
            return channel;
        }

        public override void Remove(long id)
        {
            WChannel channel;
            if(!this.channels.TryGetValue(id, out channel))
            {
                return;
            }
            this.channels.Remove(id);
            channel.Dispose();
        }

        public override void Update()
        {
        }

        private async ETVoid StartAccept(IEnumerable<string> prefixs)
        {
            try
            {
                foreach(string prefix in prefixs)
                {
                    this.httpListener.Prefixes.Add(prefix);
                }
                httpListener.Start();
                while(true)
                {
                    try
                    {
                        HttpListenerContext httpListenerContext = await this.httpListener.GetContextAsync();
                        HttpListenerWebSocketContext webSocketContext = await httpListenerContext.AcceptWebSocketAsync(null);
                        WChannel channel = new WChannel(webSocketContext, this);
                        this.channels[channel.Id] = channel;
                        this.OnAccept(channel);
                    }
                    catch(Exception e)
                    {
                        UnityEngine.Debug.LogError(e);
                    }
                }
            }
            catch(HttpListenerException e)
            {
                if (e.ErrorCode == 5)
                {
                    throw new Exception($"CMD管理员中输入: netsh http add urlacl url=http://*:8080/ user=Everyone", e);
                }
                UnityEngine.Debug.LogError(e);
            }
            catch(Exception e)
            {
                UnityEngine.Debug.LogError(e);
            }
        }
    }
}
