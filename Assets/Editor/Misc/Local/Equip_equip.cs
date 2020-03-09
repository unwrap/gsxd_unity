using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Equip_equip : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.Id = base.readInt();
            this.Name = base.readLocalString();
            this.PropType = base.readInt();
            this.Overlying = base.readInt();
            this.Position = base.readInt();
            this.Type = base.readInt();
            this.EquipIcon = base.readInt();
            this.Quality = base.readInt();
            this.Attributes = base.readArraystring();
            this.AttributesUp = base.readArrayint();
            this.Skills = base.readArrayint();
            this.SkillsUp = base.readArraystring();
            this.AdditionSkills = base.readArraystring();
            this.UnlockCondition = base.readArrayint();
            this.InitialPower = base.readLocalString();
            this.AddPower = base.readLocalString();
            this.Powerratio = base.readLocalString();
            this.SuperID = base.readArrayint();
            this.BreakNeed = base.readInt();
            this.MaxLevel = base.readInt();
            this.UpgradeNeed = base.readInt();
            this.Score = base.readInt();
            this.SellPrice = base.readInt();
            this.CritSellProb = base.readArraystring();
            this.SellDiamond = base.readArrayfloat();
            this.CardCost = base.readArrayint();
            this.CoinCost = base.readArrayint();
            return true;
        }

        public int Id { get; private set; }

        public string Name { get; private set; }

        public int PropType { get; private set; }

        public int Overlying { get; private set; }

        public int Position { get; private set; }

        public int Type { get; private set; }

        public int EquipIcon { get; private set; }

        public int Quality { get; private set; }

        public string[] Attributes { get; private set; }

        public int[] AttributesUp { get; private set; }

        public int[] Skills { get; private set; }

        public string[] SkillsUp { get; private set; }

        public string[] AdditionSkills { get; private set; }

        public int[] UnlockCondition { get; private set; }

        public string InitialPower { get; private set; }

        public string AddPower { get; private set; }

        public string Powerratio { get; private set; }

        public int[] SuperID { get; private set; }

        public int BreakNeed { get; private set; }

        public int MaxLevel { get; private set; }

        public int UpgradeNeed { get; private set; }

        public int Score { get; private set; }

        public int SellPrice { get; private set; }

        public string[] CritSellProb { get; private set; }

        public float[] SellDiamond { get; private set; }

        public int[] CardCost { get; private set; }

        public int[] CoinCost { get; private set; }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Equip_equip).GetProperties();
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
    }
}

