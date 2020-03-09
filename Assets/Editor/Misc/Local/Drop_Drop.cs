namespace TableTool
{
    using System;
    using System.Collections.Generic;

    public class Drop_Drop : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.DropID = base.readInt();
            this.Notes = base.readLocalString();
            this.DropType = base.readInt();
            this.Prob = base.readArraystring();
            this.Rand1 = base.readArraystring();
            this.Rand2 = base.readArraystring();
            this.Rand3 = base.readArraystring();
            this.Rand4 = base.readArraystring();
            this.Rand5 = base.readArraystring();
            this.Fixed = base.readArraystring();
            return true;
        }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Drop_Drop).GetProperties();
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

        public int DropID { get; private set; }

        public string Notes { get; private set; }

        public int DropType { get; private set; }

        public string[] Prob { get; private set; }

        public string[] Rand1 { get; private set; }

        public string[] Rand2 { get; private set; }

        public string[] Rand3 { get; private set; }

        public string[] Rand4 { get; private set; }

        public string[] Rand5 { get; private set; }

        public string[] Fixed { get; private set; }
    }
}

