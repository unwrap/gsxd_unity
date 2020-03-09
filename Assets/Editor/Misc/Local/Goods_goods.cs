namespace TableTool
{
    using System;
    using System.Collections.Generic;

    public class Goods_goods : LocalBean
    {
        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Goods_goods).GetProperties();
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
            this.GoodID = base.readInt();
            this.Notes = base.readLocalString();
            this.GoodsType = base.readInt();
            this.Ground = base.readInt();
            this.DropSound = base.readLocalString();
            this.GetSound = base.readInt();
            this.SizeX = base.readInt();
            this.SizeY = base.readInt();
            this.OffsetX = base.readFloat();
            this.OffsetY = base.readFloat();
            this.Args = base.readArraystring();
            return true;
        }

        public int GoodID { get; private set; }

        public string Notes { get; private set; }

        public int GoodsType { get; private set; }

        public int Ground { get; private set; }

        public string DropSound { get; private set; }

        public int GetSound { get; private set; }

        public int SizeX { get; private set; }

        public int SizeY { get; private set; }

        public float OffsetX { get; private set; }

        public float OffsetY { get; private set; }

        public string[] Args { get; private set; }

    }
}

