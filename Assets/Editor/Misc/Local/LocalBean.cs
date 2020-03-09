namespace TableTool
{
    using System;
    using System.IO;
    using System.Net;
    using System.Text;
    using UnityEngine;

    public abstract class LocalBean
    {
        private short messageLength;
        private int position = 0;
        private static readonly long t19700101;
        private static readonly int time_factor;
        private static readonly Encoding encoding;
        private FileStream file;
        private byte[] raws;
        private byte[] datas_short = new byte[2];
        private byte[] datas_int = new byte[4];
        private int datas_int_i;
        private byte[] datas_long = new byte[8];
        private byte[] datas_float = new byte[4];
        private int datas_float_i;
        private float datas_float_f;
        private short count_arraystring;
        private short count_arraybool;
        private short count_arrayfloat;

        static LocalBean()
        {
            DateTime time = new DateTime(0x7b2, 1, 1, 0, 0, 0, 0);
            t19700101 = time.Ticks;
            time_factor = 0x2710;
            encoding = Encoding.UTF8;
        }

        public int getLength() =>
            this.messageLength;

        protected bool[] readArraybool()
        {
            this.count_arraybool = this.readShort();
            bool[] flagArray = new bool[this.count_arraybool];
            for (int i = 0; i < this.count_arraybool; i++)
            {
                flagArray[i] = this.readBool();
            }
            return flagArray;
        }

        protected double[] readArraydouble()
        {
            short num = this.readShort();
            double[] numArray = new double[num];
            for (int i = 0; i < num; i++)
            {
                numArray[i] = this.readDouble();
            }
            return numArray;
        }

        protected float[] readArrayfloat()
        {
            this.count_arrayfloat = this.readShort();
            float[] numArray = new float[this.count_arrayfloat];
            for (int i = 0; i < this.count_arrayfloat; i++)
            {
                numArray[i] = this.readFloat();
            }
            return numArray;
        }

        protected int[] readArrayint()
        {
            short num = this.readShort();
            int[] numArray = new int[num];
            for (int i = 0; i < num; i++)
            {
                numArray[i] = this.readInt();
            }
            return numArray;
        }

        protected long[] readArraylong()
        {
            short num = this.readShort();
            long[] numArray = new long[num];
            for (int i = 0; i < num; i++)
            {
                numArray[i] = this.readLong();
            }
            return numArray;
        }

        protected short[] readArrayshort()
        {
            short num = this.readShort();
            short[] numArray = new short[num];
            for (int i = 0; i < num; i++)
            {
                numArray[i] = this.readShort();
            }
            return numArray;
        }

        protected string[] readArraystring()
        {
            this.count_arraystring = this.readShort();
            string[] strArray = new string[this.count_arraystring];
            for (int i = 0; i < this.count_arraystring; i++)
            {
                strArray[i] = this.readLocalString();
            }
            return strArray;
        }

        protected bool readBool() =>
            (this.readShort() == 1);

        protected void readBytes(byte[] datas, int buffLength)
        {
            int index = 0;
            while (index < buffLength)
            {
                datas[index] = this.raws[this.position];
                index++;
                this.position++;
            }
        }

        protected string readCommonString()
        {
            string key = this.readLocalString();
            return this.toCommonString(key);
        }

        protected DateTime readDate()
        {
            long num = this.readLong() * time_factor;
            return new DateTime(num + t19700101);
        }

        protected double readDouble()
        {
            byte[] datas = new byte[8];
            this.readBytes(datas, 8);
            return BitConverter.Int64BitsToDouble(IPAddress.NetworkToHostOrder(BitConverter.ToInt64(datas, 0)));
        }

        protected float readFloat()
        {
            this.readBytes(this.datas_float, 4);
            this.datas_float_i = BitConverter.ToInt32(this.datas_float, 0);
            this.datas_float_i = IPAddress.NetworkToHostOrder(this.datas_float_i);
            byte[] bytes = BitConverter.GetBytes(this.datas_float_i);
            this.datas_float_f = BitConverter.ToSingle(bytes, 0);
            return this.datas_float_f;
        }

        public int readFromBytes(byte[] raws, int startPos)
        {
            this.raws = raws;
            this.position = startPos;
            try
            {
                this.messageLength = this.readShort();
                if (!this.ReadImpl())
                {
                    return -1;
                }
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return this.position;
        }

        protected abstract bool ReadImpl();
        protected int readInt()
        {
            this.readBytes(this.datas_int, 4);
            this.datas_int_i = BitConverter.ToInt32(this.datas_int, 0);
            this.datas_int_i = IPAddress.NetworkToHostOrder(this.datas_int_i);
            return this.datas_int_i;
        }

        protected string readLocalString()
        {
            short num = this.readShort();
            byte[] datas = new byte[num - 2];
            this.readBytes(datas, num - 2);
            try
            {
                return encoding.GetString(datas);
            }
            catch (Exception exception)
            {
                Debug.LogError("get string ecode error " + exception.Message);
                return string.Empty;
            }
        }

        protected long readLong()
        {
            this.readBytes(this.datas_long, 8);
            return IPAddress.NetworkToHostOrder(BitConverter.ToInt64(this.datas_long, 0));
        }

        protected short readShort()
        {
            this.readBytes(this.datas_short, 2);
            return IPAddress.NetworkToHostOrder(BitConverter.ToInt16(this.datas_short, 0));
        }

        protected string toCommonString(string key)
        {
            string str = key;
            if (str == null)
            {
                return key;
            }
            return str;
        }
    }
}

