namespace TableTool
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.CompilerServices;

    public class Room_room : LocalBean
    {
        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Room_room).GetProperties();
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
            this.RoomID = base.readInt();
            this.Notes = base.readLocalString();
            this.Difficult = base.readInt();
            this.GoodsOffset = base.readArrayfloat();
            this.Shape = base.readInt();
            this.CameraRound = base.readArrayfloat();
            return true;
        }

        public int RoomID { get; private set; }

        public string Notes { get; private set; }

        public int Difficult { get; private set; }

        public float[] GoodsOffset { get; private set; }

        public int Shape { get; private set; }

        public float[] CameraRound { get; private set; }
    }
}

