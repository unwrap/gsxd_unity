using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Buff_alone : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.BuffID = base.readInt();
            this.Notes = base.readLocalString();
            this.FxId = base.readInt();
            this.OverType = base.readInt();
            this.BuffType = base.readInt();
            this.DizzyChance = base.readInt();
            this.Attribute = base.readLocalString();
            this.FirstEffects = base.readArraystring();
            this.Effects = base.readArraystring();
            this.Attributes = base.readArraystring();
            this.Args = base.readArrayfloat();
            this.ArgsContent = base.readLocalString();
            this.Time = base.readInt();
            this.Delay_time = base.readInt();
            return true;
        }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Buff_alone).GetProperties();
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

        public int BuffID { get; private set; }

        public string Notes { get; private set; }

        public int FxId { get; private set; }

        public int OverType { get; private set; }

        public int BuffType { get; private set; }

        public int DizzyChance { get; private set; }

        public string Attribute { get; private set; }

        public string[] FirstEffects { get; private set; }

        public string[] Effects { get; private set; }

        public string[] Attributes { get; private set; }

        public float[] Args { get; private set; }

        public string ArgsContent { get; private set; }

        public int Time { get; private set; }

        public int Delay_time { get; private set; }
    }
}

