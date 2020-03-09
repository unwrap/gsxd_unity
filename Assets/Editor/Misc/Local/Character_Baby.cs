namespace TableTool
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.CompilerServices;

    public class Character_Baby : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.BabyID = base.readLocalString();
            this.AttackValue = base.readInt();
            return true;
        }

        public string BabyID { get; private set; }

        public int AttackValue { get; private set; }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Character_Baby).GetProperties();
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

