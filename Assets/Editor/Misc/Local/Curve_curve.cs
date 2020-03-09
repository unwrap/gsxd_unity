using UnityEngine;

namespace TableTool
{
    public class Curve_curve : LocalBean
    {
        public int ID { get; private set; }

        public string Notes { get; private set; }

        public string[] Values { get; private set; }

        public AnimationCurve ToAnimationCurve()
        {
            Keyframe[] keyFrames = new Keyframe[this.Values.Length];
            for(int i = 0; i < this.Values.Length; i++)
            {
                string[] keys = this.Values[i].Split(',');
                keyFrames[i] = new Keyframe(float.Parse(keys[0]), float.Parse(keys[1]), float.Parse(keys[2]), float.Parse(keys[3]));
            }
            AnimationCurve ani = new AnimationCurve(keyFrames);
            return ani;
        }

        public string ToStringEx(int idx)
        {
            string[] keyFrames = new string[this.Values.Length];
            for(int i=0; i<this.Values.Length; i++)
            {
                string[] keys = this.Values[i].Split(',');
                keyFrames[i] = string.Format("{{{0},{1},{2},{3}}}", keys[0], keys[1], keys[2], keys[3]);
            }
            return string.Format("[{0}]={{id={1}, notes=\"{2}\", keyframe={{{3}}}",
                idx,
                this.ID,
                this.Notes,
                string.Join(",", keyFrames)
            );
        }

        protected override bool ReadImpl()
        {
            this.ID = base.readInt();
            this.Notes = base.readLocalString();
            this.Values = base.readArraystring();
            return true;
        }
    }
}
