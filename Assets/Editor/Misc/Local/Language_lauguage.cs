namespace TableTool
{
    using System;
    using System.Collections.Generic;

    public class Language_lauguage : LocalBean
    {
        protected override bool ReadImpl()
        {
            this.TID = base.readLocalString();
            this.CN_s = base.readLocalString();
            this.CN_t = base.readLocalString();
            this.EN = base.readLocalString();
            this.FR = base.readLocalString();
            this.DE = base.readLocalString();
            this.ID = base.readLocalString();
            this.JP = base.readLocalString();
            this.KR = base.readLocalString();
            this.PT_BR = base.readLocalString();
            this.RU = base.readLocalString();
            this.ES_ES = base.readLocalString();
            return true;
        }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Language_lauguage).GetProperties();
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

        public string TID { get; private set; }

        public string CN_s { get; private set; }

        public string CN_t { get; private set; }

        public string EN { get; private set; }

        public string FR { get; private set; }

        public string DE { get; private set; }

        public string ID { get; private set; }

        public string JP { get; private set; }

        public string KR { get; private set; }

        public string PT_BR { get; private set; }

        public string RU { get; private set; }

        public string ES_ES { get; private set; }
    }
}

