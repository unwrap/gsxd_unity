namespace TableTool
{
    using System;
    using System.Collections.Generic;

    public class Stage_Level_chapter : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.RoomID = base.readLocalString();
            this.Notes = base.readLocalString();
            this.Attributes = base.readArraystring();
            this.MapAttributes = base.readArraystring();
            this.StandardDefence = base.readLong();
            this.RoomIDs = base.readArraystring();
            this.RoomIDs1 = base.readArraystring();
            return true;
        }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Stage_Level_chapter).GetProperties();
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

        public string RoomID { get; private set; }

        public string Notes { get; private set; }

        public string[] Attributes { get; private set; }

        public string[] MapAttributes { get; private set; }

        public long StandardDefence { get; private set; }

        public string[] RoomIDs { get; private set; }

        public string[] RoomIDs1 { get; private set; }
    }
}

