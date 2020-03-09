using ETModel;
using SLua;
using System.Collections.Generic;
using UnityEngine;

[SLua.CustomLuaClass]
public class OzNetClient : MonoBehaviour
{
    public static OzNetClient Instance
    {
        get
        {
            return OzSingleton.GetSingleTon<OzNetClient>();
        }
    }

    public delegate void OnGetServerMessageCallback(Session s, ByteStringArray bytes, ushort messageId);
    public delegate void OnSessionClose(Session s, int error);

    public OnSessionClose OnClose;
    public OnGetServerMessageCallback OnGetServerMessage;

    protected AService Service;

    private void Awake()
    {
        this.Service = new TService(Packet.PacketSizeLength4);
    }

    private void Update()
    {
        if(this.Service != null)
        {
            this.Service.Update();
        }
    }

    public void DispatchMessage(Session s, ByteStringArray bytes, ushort messageId)
    {
        if(this.OnGetServerMessage != null)
        {
            this.OnGetServerMessage(s, bytes, messageId);
        }
    }

    public void DispatchClose(Session s, int error)
    {
        if(this.OnClose != null)
        {
            this.OnClose(s, error);
        }
    }

    //address表示ip:端口
    public Session ConnectServer(string address)
    {
        AChannel channel = this.Service.ConnectChannel(address);
        channel.Start();
        Session session = new Session(channel);
        return session;
    }
}
