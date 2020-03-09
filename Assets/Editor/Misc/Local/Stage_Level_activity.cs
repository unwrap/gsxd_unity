namespace TableTool
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.CompilerServices;

    public class Stage_Level_activity : LocalBean
    {
        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Stage_Level_activity).GetProperties();
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
            this.ID = base.readInt();
            this.Type = base.readInt();
            this.Notes = base.readLocalString();
            this.Difficult = base.readInt();
            this.StageLevel = base.readLocalString();
            this.MaxLayer = base.readInt();
            this.StyleSequence = base.readArraystring();
            this.LevelCondition = base.readInt();
            this.TimeCondition = base.readArrayint();
            this.Number = base.readInt();
            this.Power = base.readArrayint();
            this.Price = base.readArrayint();
            this.GoldRate = base.readFloat();
            this.EquipDropID = base.readInt();
            this.EquipProb = base.readInt();
            this.IntegralRate = base.readFloat();
            this.Reward = base.readArrayint();
            this.Args = base.readArraystring();
            this.StandardRoom = base.readLocalString();
            this.Integral_Ratio = base.readFloat();
            this.ExpBase = base.readInt();
            this.ExpAdd = base.readInt();
            return true;
        }

        public int ID { get; private set; }

        public int Type { get; private set; }

        public string Notes { get; private set; }

        public int Difficult { get; private set; }

        public string StageLevel { get; private set; }

        public int MaxLayer { get; private set; }

        public string[] StyleSequence { get; private set; }

        public int LevelCondition { get; private set; }

        public int[] TimeCondition { get; private set; }

        public int Number { get; private set; }

        public int[] Power { get; private set; }

        public int[] Price { get; private set; }

        public float GoldRate { get; private set; }

        public int EquipDropID { get; private set; }

        public int EquipProb { get; private set; }

        public float IntegralRate { get; private set; }

        public int[] Reward { get; private set; }

        public string[] Args { get; private set; }

        public string StandardRoom { get; private set; }

        public float Integral_Ratio { get; private set; }

        public int ExpBase { get; private set; }

        public int ExpAdd { get; private set; }
    }
}

