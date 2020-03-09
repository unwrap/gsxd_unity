using UnityEngine;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System;

public static class CryptographHelper
{
    private static string Base64(this string source)
    {
        byte[] bytes = Encoding.UTF8.GetBytes(source);
        return Convert.ToBase64String(bytes, 0, bytes.Length);
    }

    private static byte[] FormatByte(this string strVal, Encoding encoding)
    {
        return encoding.GetBytes(strVal.Base64().Substring(0, 0x10).ToUpper());
    }

    public static string UnAesStr(this string source, string keyVal, string ivVal)
    {
        string str;
        Encoding encoding = Encoding.UTF8;
        byte[] rgbKey = keyVal.FormatByte(encoding);
        byte[] rgbIV = ivVal.FormatByte(encoding);
        byte[] buffer = Convert.FromBase64String(source);
        Rijndael rijndael = Rijndael.Create();
        using (MemoryStream stream = new MemoryStream())
        {
            using (CryptoStream stream2 = new CryptoStream(stream, rijndael.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Write))
            {
                stream2.Write(buffer, 0, buffer.Length);
                stream2.FlushFinalBlock();
                str = encoding.GetString(stream.ToArray());
            }
        }
        rijndael.Clear();
        return str;
    }

    public static string CryptString(string source)
    {
        byte[] hash = Encoding.UTF8.GetBytes(source);
        string outStr = System.Convert.ToBase64String(hash);
        outStr = outStr.Replace("=", "");
        outStr = outStr.Replace(@"/", "-");
        return outStr;
    }

    public static byte[] Encrypt(byte[] plainBytes, byte[] Key, byte[] IV)
    {
        byte[] encrypted;
        // Create an RijndaelManaged object
        // with the specified key and IV.
        using (RijndaelManaged rijAlg = new RijndaelManaged())
        {
            rijAlg.Key = Key;
            rijAlg.IV = IV;

            // Create a decrytor to perform the stream transform.
            ICryptoTransform encryptor = rijAlg.CreateEncryptor(rijAlg.Key, rijAlg.IV);

            // Create the streams used for encryption.
            using (MemoryStream msEncrypt = new MemoryStream())
            {
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                {
                    csEncrypt.Write(plainBytes, 0, plainBytes.Length);
                    csEncrypt.FlushFinalBlock();
                    encrypted = msEncrypt.ToArray();
                }
            }
        }

        // Return the encrypted bytes from the memory stream.
        return encrypted;
    }

    public static byte[] Decrypt(byte[] encryptedBytes, byte[] Key, byte[] IV)
    {
        // Create an RijndaelManaged object
        // with the specified key and IV.
        byte[] original = null;

        using (RijndaelManaged rijAlg = new RijndaelManaged())
        {
            rijAlg.Key = Key;
            rijAlg.IV = IV;

            // Create a decrytor to perform the stream transform.
            ICryptoTransform decryptor = rijAlg.CreateDecryptor(rijAlg.Key, rijAlg.IV);

            // Create the streams used for decryption.
            using (MemoryStream msDecrypt = new MemoryStream(encryptedBytes))
            {
                using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                {
                    using (MemoryStream originalMemory = new MemoryStream())
                    {
                        byte[] Buffer = new byte[1024];
                        int readBytes = 0;
                        while ((readBytes = csDecrypt.Read(Buffer, 0, Buffer.Length)) > 0)
                        {
                            originalMemory.Write(Buffer, 0, readBytes);
                        }

                        original = originalMemory.ToArray();
                    }
                }
            }
        }
        return original;
    }
}
