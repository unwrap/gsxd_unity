using System;

namespace ETModel
{
    public enum EntityStatus : byte
    {
        None = 0,
        IsFromPool = 0x01,
        IsRegister = 0x02,
        IsComponent = 0x04
    }

    public partial class Entity : Object, IDisposable
    {
        public long Id { get; set; }
        public long InstanceId { get; set; }

        private EntityStatus status = EntityStatus.None;

        public bool IsDisposed
        {
            get
            {
                return this.InstanceId == 0;
            }
        }

        protected Entity()
        {
            this.InstanceId = IdGenerater.GenerateId();
        }

        public virtual void Dispose()
        {
            if(this.IsDisposed)
            {
                return;
            }
            long instanceId = this.InstanceId;
            this.InstanceId = 0;

            this.status = EntityStatus.None;
        }
    }
}