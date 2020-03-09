using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Soldier_soldier : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.CharID = base.readInt();
            this.Notes = base.readLocalString();
            this.GoldDropLevel = base.readInt();
            this.ScrollDropLevel = base.readInt();
            this.GoldDropGold1 = base.readInt();
            this.GoldDropGold2 = base.readInt();
            this.EquipRate = base.readFloat();
            this.Exp = base.readInt();
            this.DropRadius = base.readInt();
            this.HPDrop1 = base.readInt();
            this.HPDrop2 = base.readInt();
            this.HPDrop3 = base.readInt();
            this.BodyHitSoundID = base.readInt();
            return true;
        }

        public int CharID { get; private set; }

        public string Notes { get; private set; }

        public int GoldDropLevel { get; private set; }

        public int ScrollDropLevel { get; private set; }

        public int GoldDropGold1 { get; private set; }

        public int GoldDropGold2 { get; private set; }

        public float EquipRate { get; private set; }

        public int Exp { get; private set; }

        public int DropRadius { get; private set; }

        public int HPDrop1 { get; private set; }

        public int HPDrop2 { get; private set; }

        public int HPDrop3 { get; private set; }

        public int BodyHitSoundID { get; private set; }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Soldier_soldier).GetProperties();
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

