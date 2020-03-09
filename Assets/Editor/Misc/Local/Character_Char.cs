using System;
using System.Collections.Generic;

namespace TableTool
{
    public class Character_Char : LocalBean
    {
        public int CharID { get; private set; }

        public int TypeID { get; private set; }

        public string ModelID { get; private set; }

        public float BodyScale { get; private set; }

        public string TextureID { get; private set; }

        public int WeaponID { get; private set; }

        public int Attackrangetype { get; private set; }

        public int Speed { get; private set; }

        public int HP { get; private set; }

        public int RotateSpeed { get; private set; }

        public int BodyAttack { get; private set; }

        public int Divide { get; private set; }

        public int[] Skills { get; private set; }

        public float BackRatio { get; private set; }

        public float[] ActionSpeed { get; private set; }

        public int HittedEffectID { get; private set; }

        public int DeadSoundID { get; private set; }

        public int Cache { get; private set; }

        public override string ToString()
        {
            System.Reflection.PropertyInfo[] properties = typeof(Character_Char).GetProperties();
            List<string> strs = new List<string>();
            foreach (System.Reflection.PropertyInfo info in properties)
            {
                var val = info.GetValue(this);
                Type t = val.GetType();
                string str = string.Empty;
                if(t.IsArray)
                {
                    Array arr = val as Array;
                    object[] strList = new object[arr.Length];
                    for(int i = 0; i < arr.Length; i++)
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
            this.CharID = base.readInt();
            this.TypeID = base.readInt();
            this.ModelID = base.readLocalString();
            this.BodyScale = base.readFloat();
            this.TextureID = base.readLocalString();
            this.WeaponID = base.readInt();
            this.Attackrangetype = base.readInt();
            this.Speed = base.readInt();
            this.HP = base.readInt();
            this.RotateSpeed = base.readInt();
            this.BodyAttack = base.readInt();
            this.Divide = base.readInt();
            this.Skills = base.readArrayint();
            this.BackRatio = base.readFloat();
            this.ActionSpeed = base.readArrayfloat();
            this.HittedEffectID = base.readInt();
            this.DeadSoundID = base.readInt();
            this.Cache = base.readInt();
            return true;
        }
    }
}
