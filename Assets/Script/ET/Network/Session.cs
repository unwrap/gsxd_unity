using SLua;
using System;
using System.IO;
using UnityEngine;

namespace ETModel
{
    [SLua.CustomLuaClass]
    public sealed class Session : Entity
    {
        private AChannel channel;

        private readonly byte[] opcodeBytes = new byte[2];

        public long LastRecvTime { get; private set; }
        public long LastSendTime { get; private set; }

        public Session(AChannel channel)
        {
            this.channel = channel;

            long timeNow = TimeHelper.Now();
            this.LastRecvTime = timeNow;
            this.LastSendTime = timeNow;

            long id = this.Id;

            this.channel.ErrorCallback += (c, e) =>
            {
                OzNetClient.Instance.DispatchClose(this, e);
            };
            this.channel.ReadCallback += OnRead;
        }

        public override void Dispose()
        {
            base.Dispose();
            if(this.channel != null)
            {
                this.channel.Dispose();
                this.channel = null;
            }            
        }

        public int Error
        {
            get
            {
                return this.channel.Error;
            }
            set
            {
                this.channel.Error = value;
            }
        }

        private MemoryStream Stream
        {
            get
            {
                return this.channel.Stream;
            }
        }

        public void Send(ByteStringArray data, ushort opcode)
        {
            if(this.IsDisposed)
            {
                throw new Exception("session已经被Dispose了");
            }
            this.LastSendTime = TimeHelper.Now();

            MemoryStream stream = this.Stream;
            stream.Seek(Packet.MessageIndex, SeekOrigin.Begin);
            stream.SetLength(Packet.MessageIndex);

            Array.Copy(data.data, 0, stream.GetBuffer(), Packet.MessageIndex, data.data.Length);
            stream.SetLength(Packet.MessageIndex + data.data.Length);

            stream.Seek(0, SeekOrigin.Begin);
            opcodeBytes.WriteTo(0, opcode);
            Array.Copy(opcodeBytes, 0, stream.GetBuffer(), 0, opcodeBytes.Length);

            this.Send(stream);
        }

        private void Send(MemoryStream stream)
        {
            this.channel.Send(stream);
        }

        private void OnRead(MemoryStream memoryStream)
        {
            try
            {
                this.Run(memoryStream);
            }
            catch(Exception e)
            {
                Debug.Log(e);
            }
        }

        private void Run(MemoryStream memoryStream)
        {
            memoryStream.Seek(Packet.MessageIndex, SeekOrigin.Begin);
            ushort opcode = BitConverter.ToUInt16(memoryStream.GetBuffer(), Packet.OpcodeIndex);

            byte[] aBytes = memoryStream.GetBuffer();

            byte[] bytes = new byte[memoryStream.Length - Packet.MessageIndex];
            Array.Copy(aBytes, Packet.MessageIndex, bytes, 0, memoryStream.Length - Packet.MessageIndex);

            OzNetClient.Instance.DispatchMessage(this, new ByteStringArray(bytes), opcode);
        }
    }
}
