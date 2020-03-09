namespace TableTool
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.CompilerServices;

    public class Room_level : LocalBean
    {
        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Room_level).GetProperties();
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
            this.LevelID = base.readInt();
            this.Notes = base.readLocalString();
            this.RoomIDs = base.readArraystring();
            this.RoomIDs1 = base.readArraystring();
            this.RoomIDs2 = base.readArraystring();
            this.RoomIDs3 = base.readArraystring();
            this.RoomIDs4 = base.readArraystring();
            this.RoomIDs5 = base.readArraystring();
            return true;
        }

        public int LevelID { get; private set; }

        public string Notes { get; private set; }

        public string[] RoomIDs { get; private set; }

        public string[] RoomIDs1 { get; private set; }

        public string[] RoomIDs2 { get; private set; }

        public string[] RoomIDs3 { get; private set; }

        public string[] RoomIDs4 { get; private set; }

        public string[] RoomIDs5 { get; private set; }
    }
}

