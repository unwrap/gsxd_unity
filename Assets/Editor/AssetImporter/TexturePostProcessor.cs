using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class TexturePostProcessor : AssetPostprocessor
{
    public static void TextureDitherHandler2(Texture2D texture)
    {
        var texw = texture.width;
        var texh = texture.height;

        var pixels = texture.GetPixels();
        var offs = 0;

        var k1Per31 = 1.0f / 31.0f;

        var k1Per32 = 1.0f / 32.0f;
        var k5Per32 = 5.0f / 32.0f;
        var k11Per32 = 11.0f / 32.0f;
        var k15Per32 = 15.0f / 32.0f;

        var k1Per63 = 1.0f / 63.0f;

        var k3Per64 = 3.0f / 64.0f;
        var k11Per64 = 11.0f / 64.0f;
        var k21Per64 = 21.0f / 64.0f;
        var k29Per64 = 29.0f / 64.0f;

        var k_r = 32; //R&B压缩到5位，所以取2的5次方
        var k_g = 64; //G压缩到6位，所以取2的6次方

        for (var y = 0; y < texh; y++)
        {
            for (var x = 0; x < texw; x++)
            {
                float r = pixels[offs].r;
                float g = pixels[offs].g;
                float b = pixels[offs].b;

                var r2 = Mathf.Clamp01(Mathf.Floor(r * k_r) * k1Per31);
                var g2 = Mathf.Clamp01(Mathf.Floor(g * k_g) * k1Per63);
                var b2 = Mathf.Clamp01(Mathf.Floor(b * k_r) * k1Per31);

                var re = r - r2;
                var ge = g - g2;
                var be = b - b2;

                var n1 = offs + 1;
                var n2 = offs + texw - 1;
                var n3 = offs + texw;
                var n4 = offs + texw + 1;

                if (x < texw - 1)
                {
                    pixels[n1].r += re * k15Per32;
                    pixels[n1].g += ge * k29Per64;
                    pixels[n1].b += be * k15Per32;
                }

                if (y < texh - 1)
                {
                    pixels[n3].r += re * k11Per32;
                    pixels[n3].g += ge * k21Per64;
                    pixels[n3].b += be * k11Per32;

                    if (x > 0)
                    {
                        pixels[n2].r += re * k5Per32;
                        pixels[n2].g += ge * k11Per64;
                        pixels[n2].b += be * k5Per32;
                    }

                    if (x < texw - 1)
                    {
                        pixels[n4].r += re * k1Per32;
                        pixels[n4].g += ge * k3Per64;
                        pixels[n4].b += be * k1Per32;
                    }
                }

                pixels[offs].r = r2;
                pixels[offs].g = g2;
                pixels[offs].b = b2;

                offs++;
            }
        }
        texture.SetPixels(pixels);
    }

    public static void TextureDitherHandler(Texture2D texture)
    {
        var texw = texture.width;
        var texh = texture.height;

        var pixels = texture.GetPixels();
        var offs = 0;

        var k1Per15 = 1.0f / 15.0f;
        var k1Per16 = 1.0f / 16.0f;
        var k3Per16 = 3.0f / 16.0f;
        var k5Per16 = 5.0f / 16.0f;
        var k7Per16 = 7.0f / 16.0f;

        for (var y = 0; y < texh; y++)
        {
            for (var x = 0; x < texw; x++)
            {
                float a = pixels[offs].a;
                float r = pixels[offs].r;
                float g = pixels[offs].g;
                float b = pixels[offs].b;

                var a2 = Mathf.Clamp01(Mathf.Floor(a * 16) * k1Per15);
                var r2 = Mathf.Clamp01(Mathf.Floor(r * 16) * k1Per15);
                var g2 = Mathf.Clamp01(Mathf.Floor(g * 16) * k1Per15);
                var b2 = Mathf.Clamp01(Mathf.Floor(b * 16) * k1Per15);

                var ae = a - a2;
                var re = r - r2;
                var ge = g - g2;
                var be = b - b2;

                pixels[offs].a = a2;
                pixels[offs].r = r2;
                pixels[offs].g = g2;
                pixels[offs].b = b2;

                var n1 = offs + 1;   // (x+1,y)
                var n2 = offs + texw - 1; // (x-1 , y+1)
                var n3 = offs + texw;  // (x, y+1)
                var n4 = offs + texw + 1; // (x+1 , y+1)

                if (x < texw - 1)
                {
                    pixels[n1].a += ae * k7Per16;
                    pixels[n1].r += re * k7Per16;
                    pixels[n1].g += ge * k7Per16;
                    pixels[n1].b += be * k7Per16;
                }

                if (y < texh - 1)
                {
                    pixels[n3].a += ae * k5Per16;
                    pixels[n3].r += re * k5Per16;
                    pixels[n3].g += ge * k5Per16;
                    pixels[n3].b += be * k5Per16;

                    if (x > 0)
                    {
                        pixels[n2].a += ae * k3Per16;
                        pixels[n2].r += re * k3Per16;
                        pixels[n2].g += ge * k3Per16;
                        pixels[n2].b += be * k3Per16;
                    }
                    if (x < texw - 1)
                    {
                        pixels[n4].a += ae * k1Per16;
                        pixels[n4].r += re * k1Per16;
                        pixels[n4].g += ge * k1Per16;
                        pixels[n4].b += be * k1Per16;
                    }
                }
                offs++;
            }
        }
        texture.SetPixels(pixels);
    }

    private List<string> ditherTextures = new List<string>
    {
    };

    private bool NeedDither(string path)
    {
        if (ditherTextures.Contains(path))
        {
            return true;
        }
        if (path.StartsWith("Assets/RawResources/Atlas"))
        {
            if (path.Contains("rgba32"))
            {
                return false;
            }
            return true;
        }
        if (path.StartsWith("Assets/RawResources/Scene"))
        {
            return true;
        }
        return false;
    }

    void OnPreprocessTexture()
    {
        TextureImporter ti = assetImporter as TextureImporter;
        if (ti != null)
        {
            if (NeedDither(assetPath))
            {
                ti.textureFormat = TextureImporterFormat.RGBA32;
            }
        }
    }

    void OnPostprocessTexture(Texture2D texture)
    {
        TextureImporter ti = assetImporter as TextureImporter;
        if (ti != null)
        {
            if (NeedDither(assetPath))
            {
                ti.mipmapEnabled = false;
                TexturePostProcessor.TextureDitherHandler(texture);
                EditorUtility.CompressTexture(texture, TextureFormat.RGBA4444, UnityEditor.TextureCompressionQuality.Best);
            }
        }
    }
}
