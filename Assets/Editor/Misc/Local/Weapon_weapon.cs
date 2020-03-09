using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Weapon_weapon : LocalBean
    {
        public int WeaponID { get; private set; }

        public int SpecialAttribute { get; private set; }

        public string ModelID { get; private set; }

        public float ModelScale { get; private set; }

        public string[] Attributes { get; private set; }

        public int DebuffID { get; private set; }

        public int LookCamera { get; private set; }

        public int Attack { get; private set; }

        public float Distance { get; private set; }

        public float Speed { get; private set; }

        public float AttackSpeed { get; private set; }

        public float RandomAngle { get; private set; }

        public int WeaponNode { get; private set; }

        public int CreateNode { get; private set; }

        public float RotateSpeed { get; private set; }

        public string AttackPrevString { get; private set; }

        public string AttackEndString { get; private set; }

        public int Ballistic { get; private set; }

        public float BackRatio { get; private set; }

        public string CreatePath { get; private set; }

        public int CreateSoundID { get; private set; }

        public int DeadSoundID { get; private set; }

        public int HitWallSoundID { get; private set; }

        public int HittedEffectID { get; private set; }

        public int AliveTime { get; private set; }

        public int DeadDelay { get; private set; }

        public int DeadEffectID { get; private set; }

        public int DeadNode { get; private set; }

        public string[] Args { get; private set; }
        /*
        override public string ToString()
        {
            string formatStr = "WeaponID:{0} SpecialAttribute:{1} ModelID:{2} ModelScale:{3} Attributes:{4} DebuffID:{5} LookCamera:{6}" +
                " Attack:{7} Distance:{8} Speed:{9} AttackSpeed:{10} RandomAngle:{11} WeaponNode:{12} CreateNode:{13}" +
                " RotateSpeed:{14} AttackPrevString:{15} AttackEndString:{16} Ballistic:{17} BackRatio:{18} AliveTime:{19} Args:{20}";
            return string.Format(formatStr,
                this.WeaponID,
                this.SpecialAttribute,
                this.ModelID,
                this.ModelScale,
                string.Join(",", this.Attributes),
                this.DebuffID,
                this.LookCamera,
                this.Attack,
                this.Distance,
                this.Speed,
                this.AttackSpeed,
                this.RandomAngle,
                this.WeaponNode,
                this.CreateNode,
                this.RotateSpeed,
                this.AttackPrevString,
                this.AttackEndString,
                this.Ballistic,
                this.BackRatio,
                this.AliveTime,
                string.Join(",", this.Args)
            );
        }
        */

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Weapon_weapon).GetProperties();
            List<string> strs = new List<string>();
            foreach (System.Reflection.PropertyInfo info in properties)
            {
                var val = info.GetValue(this);
                Type t = val.GetType();
                string str = string.Empty;
                if (t.IsArray)
                {
                    Array arr = val as Array;
                    object[] strList = new object[arr.Length];
                    for (int i = 0; i < arr.Length; i++)
                    {
                        strList[i] = arr.GetValue(i);
                    }
                    str = string.Format(info.Name + ":{0}\n", string.Join(",", strList));
                }
                else
                {
                    str = string.Format(info.Name + ":{0}\n", val);
                }
                strs.Add(str);
            }
            return string.Join(" ", strs.ToArray());
        }

        protected override bool ReadImpl()
        {
            this.WeaponID = base.readInt();
            this.SpecialAttribute = base.readInt();
            this.ModelID = base.readLocalString();
            this.ModelScale = base.readFloat();
            this.Attributes = base.readArraystring();
            this.DebuffID = base.readInt();
            this.LookCamera = base.readInt();
            this.Attack = base.readInt();
            this.Distance = base.readFloat();
            this.Speed = base.readFloat();
            this.AttackSpeed = base.readFloat();
            this.RandomAngle = base.readFloat();
            this.WeaponNode = base.readInt();
            this.CreateNode = base.readInt();
            this.RotateSpeed = base.readFloat();
            this.AttackPrevString = base.readLocalString();
            this.AttackEndString = base.readLocalString();
            this.Ballistic = base.readInt();
            this.BackRatio = base.readFloat();
            this.CreatePath = base.readLocalString();
            this.CreateSoundID = base.readInt();
            this.DeadSoundID = base.readInt();
            this.HitWallSoundID = base.readInt();
            this.HittedEffectID = base.readInt();
            this.AliveTime = base.readInt();
            this.DeadDelay = base.readInt();
            this.DeadEffectID = base.readInt();
            this.DeadNode = base.readInt();
            this.Args = base.readArraystring();
            return true;
        }
    }
}
