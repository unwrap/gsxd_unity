using System;
using System.Text;
using System.Security.Cryptography;

[SLua.CustomLuaClass]
public class RSAHelper
{
    RSACryptoServiceProvider provider_ = null;

    public RSAHelper()
    {
        provider_ = new RSACryptoServiceProvider();
    }

    public RSAHelper(int keysize)
    {
        provider_ = new RSACryptoServiceProvider(keysize);
    }

    public RSAHelper(RSACryptoServiceProvider r)
    {
        provider_ = r;
    }

    public string GetPrivateKey()
    {
        return provider_.ToXmlString(true);
    }

    public string GetPublicKey()
    {
        return provider_.ToXmlString(false);
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="private_key_xml"></param>
    /// examples: 
    /// <RSAKeyValue><Modulus>qB+oWuGHSOOzXDCxPm</Modulus></RSAKeyValue>
    public void SetPrivateKey(string private_key_xml)
    {
        provider_.FromXmlString(private_key_xml);
    }

    public void SetPublicKey(string public_key_xml)
    {
        provider_.FromXmlString(public_key_xml);
    }

    public string Decrypt(string raw, bool fOAEP)
    {
        if (provider_.PublicOnly)
            return "";

        byte[] cipher = null;
        try
        {
            byte[] bytes = Convert.FromBase64String(raw);
            cipher = provider_.Decrypt(bytes, fOAEP);
        }
        finally
        {

        }

        return cipher == null ? "" : Encoding.UTF8.GetString(cipher);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="raw"></param>
    /// <param name="fOAEP">通常是false</param>
    /// <returns>base64</returns>
    public string Encrypt(string raw, bool fOAEP)
    {
        byte[] cipher = null;
        try
        {
            byte[] bytes = Encoding.UTF8.GetBytes(raw);
            cipher = provider_.Encrypt(bytes, fOAEP);
        }
        finally
        {

        }

        return (cipher == null ? "" : Convert.ToBase64String(cipher));
    }

    public static RSAHelper Create()
    {
        return new RSAHelper();
    }

    public static RSAHelper Create(int keysize)
    {
        return new RSAHelper(keysize);
    }

    public static string DecryptToBase64(string private_key_xml, string raw, bool fOAEP)
    {
        RSAHelper rsa = new RSAHelper();
        rsa.SetPrivateKey(private_key_xml);
        return rsa.Decrypt(raw, fOAEP);
    }

    public static string EncryptToBase64(string public_key_xml, string raw, bool fOAEP)
    {
        RSAHelper rsa = new RSAHelper();
        rsa.SetPublicKey(public_key_xml);
        return rsa.Encrypt(raw, fOAEP);
    }
}