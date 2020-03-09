using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Skill_skill : LocalBean
    {
        public int SkillID { get; private set; }

        public int SkillIcon { get; private set; }

        public string[] Attributes { get; private set; }

        public int[] Effects { get; private set; }

        public int[] Buffs { get; private set; }

        public int[] Debuffs { get; private set; }

        public int LearnEffectID { get; private set; }

        public string[] Args { get; private set; }

        /*
        public override string ToString()
        {
            return string.Format("id:{0} icon:{1} att:{2} effects:{3} buffs:{3} debuffs:{4} learnEffectID:{5} args:{6}",
                this.SkillID,
                this.SkillIcon,
                string.Join(",", Attributes),
                string.Join(",", Effects),
                string.Join(",", Buffs),
                string.Join(",", Debuffs),
                this.LearnEffectID,
                string.Join(",", Args)
            );
        }
        */

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Skill_skill).GetProperties();
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
            this.SkillID = base.readInt();
            this.SkillIcon = base.readInt();
            this.Attributes = base.readArraystring();
            this.Effects = base.readArrayint();
            this.Buffs = base.readArrayint();
            this.Debuffs = base.readArrayint();
            this.LearnEffectID = base.readInt();
            this.Args = base.readArraystring();
            return true;
        }
    }
}