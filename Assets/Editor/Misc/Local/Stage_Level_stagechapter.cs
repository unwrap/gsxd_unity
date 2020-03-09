namespace TableTool
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.CompilerServices;

    public class Stage_Level_stagechapter : LocalBean
    {
        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Stage_Level_stagechapter).GetProperties();
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
            this.Notes = base.readLocalString();
            this.TiledID = base.readInt();
            this.GameType = base.readInt();
            this.GameArgs = base.readArrayint();
            this.StyleSequence = base.readArraystring();
            this.StageLevel = base.readLocalString();
            this.OpenCondition = base.readLocalString();
            this.ArgsOpen = base.readInt();
            this.GoldRate = base.readFloat();
            this.EquipDropID = base.readInt();
            this.EquipProb = base.readInt();
            this.IntegralRate = base.readFloat();
            this.ExpBase = base.readInt();
            this.ExpAdd = base.readInt();
            this.GoldTurn = base.readArraystring();
            this.DropAddCond = base.readArrayint();
            this.DropAddProb = base.readInt();
            this.AdProb = base.readInt();
            this.AdTurn = base.readArraystring();
            this.ScrollRate = base.readArraystring();
            this.ScrollRateBoss = base.readArraystring();
            return true;
        }

        public int ID { get; private set; }

        public string Notes { get; private set; }

        public int TiledID { get; private set; }

        public int GameType { get; private set; }

        public int[] GameArgs { get; private set; }

        public string[] StyleSequence { get; private set; }

        public string StageLevel { get; private set; }

        public string OpenCondition { get; private set; }

        public int ArgsOpen { get; private set; }

        public float GoldRate { get; private set; }

        public int EquipDropID { get; private set; }

        public int EquipProb { get; private set; }

        public float IntegralRate { get; private set; }

        public int ExpBase { get; private set; }

        public int ExpAdd { get; private set; }

        public string[] GoldTurn { get; private set; }

        public int[] DropAddCond { get; private set; }

        public int DropAddProb { get; private set; }

        public int AdProb { get; private set; }

        public string[] AdTurn { get; private set; }

        public string[] ScrollRate { get; private set; }

        public string[] ScrollRateBoss { get; private set; }
    }
}

