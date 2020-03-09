// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:32719,y:32712,varname:node_4013,prsc:2|diff-8072-OUT,emission-8072-OUT,clip-3908-A,voffset-8223-OUT;n:type:ShaderForge.SFN_Color,id:1798,x:31986,y:32555,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3908,x:31229,y:32728,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5366,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:fb7e809722580dc45b93fe4711520722,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:8072,x:32252,y:32660,varname:node_8072,prsc:2|A-1798-RGB,B-3908-RGB;n:type:ShaderForge.SFN_Tex2dAsset,id:1297,x:30860,y:33062,ptovrint:False,ptlb:Vector Texture,ptin:_VectorTexture,varname:node_8650,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8834,x:31158,y:32948,varname:node_3600,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-3425-UVOUT,TEX-1297-TEX;n:type:ShaderForge.SFN_Panner,id:1396,x:30899,y:32833,varname:node_1396,prsc:2,spu:-0.15,spv:0|UVIN-6528-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:6528,x:30298,y:32785,varname:node_6528,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:3425,x:30932,y:32638,varname:node_3425,prsc:2,spu:-0.07,spv:0.05|UVIN-5175-OUT;n:type:ShaderForge.SFN_Multiply,id:5175,x:30746,y:32621,varname:node_5175,prsc:2|A-6528-UVOUT,B-1754-OUT;n:type:ShaderForge.SFN_Vector1,id:1754,x:30595,y:32691,varname:node_1754,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:7023,x:31158,y:33103,varname:node_6172,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-1396-UVOUT,TEX-1297-TEX;n:type:ShaderForge.SFN_Add,id:8380,x:31533,y:33100,varname:node_8380,prsc:2|A-8834-RGB,B-9328-OUT;n:type:ShaderForge.SFN_Tex2d,id:2398,x:31219,y:33515,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_650,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c2b5b60d1c083ea419ffdbb8319442db,ntxv:0,isnm:False|UVIN-6528-UVOUT;n:type:ShaderForge.SFN_Vector4Property,id:2341,x:31596,y:32849,ptovrint:False,ptlb:Vector Offset,ptin:_VectorOffset,varname:node_1307,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:8223,x:32277,y:33161,varname:node_8223,prsc:2|A-2398-RGB,B-9864-OUT;n:type:ShaderForge.SFN_Add,id:9864,x:32024,y:32986,varname:node_9864,prsc:2|A-2341-XYZ,B-2710-OUT;n:type:ShaderForge.SFN_Multiply,id:2710,x:31902,y:33183,varname:node_2710,prsc:2|A-7388-OUT,B-8380-OUT;n:type:ShaderForge.SFN_Slider,id:1009,x:31406,y:33378,ptovrint:False,ptlb:Distort Power,ptin:_DistortPower,varname:node_5926,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:9328,x:31364,y:33199,varname:node_9328,prsc:2|A-7023-RGB,B-4430-OUT;n:type:ShaderForge.SFN_Slider,id:4430,x:31006,y:33366,ptovrint:False,ptlb:Small Distort Value,ptin:_SmallDistortValue,varname:node_8634,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:7388,x:31742,y:33287,varname:node_7388,prsc:2,frmn:0,frmx:1,tomn:0,tomx:2|IN-1009-OUT;proporder:1297-2398-2341-1009-4430-1798-3908;pass:END;sub:END;*/

Shader "MK4/Mobile/Banner" {
    Properties {
        _VectorTexture ("Vector Texture", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _VectorOffset ("Vector Offset", Vector) = (0,0,0,0)
        _DistortPower ("Distort Power", Range(0, 1)) = 0.5
        _SmallDistortValue ("Small Distort Value", Range(0, 1)) = 0
        _Color ("Color", Color) = (1,1,1,1)
        _Texture ("Texture", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _Mask_var = tex2Dlod(_Mask,float4(TRANSFORM_TEX(o.uv0, _Mask),0.0,0));
                float4 node_7986 = _Time + _TimeEditor;
                float2 node_3425 = ((o.uv0*0.3)+node_7986.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_3425, _VectorTexture),0.0,0));
                float2 node_1396 = (o.uv0+node_7986.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_1396, _VectorTexture),0.0,0));
                v.vertex.xyz += (_Mask_var.rgb*(_VectorOffset.rgb+((_DistortPower*2.0+0.0)*(node_3600.rgb+(node_6172.rgb*_SmallDistortValue)))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                clip(_Texture_var.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - 0;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 node_8072 = (_Color.rgb*_Texture_var.rgb);
                float3 diffuseColor = node_8072;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = node_8072;
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float2 uv2 : TEXCOORD3;
                float4 posWorld : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float4 _Mask_var = tex2Dlod(_Mask,float4(TRANSFORM_TEX(o.uv0, _Mask),0.0,0));
                float4 node_4537 = _Time + _TimeEditor;
                float2 node_3425 = ((o.uv0*0.3)+node_4537.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_3425, _VectorTexture),0.0,0));
                float2 node_1396 = (o.uv0+node_4537.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_1396, _VectorTexture),0.0,0));
                v.vertex.xyz += (_Mask_var.rgb*(_VectorOffset.rgb+((_DistortPower*2.0+0.0)*(node_3600.rgb+(node_6172.rgb*_SmallDistortValue)))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                clip(_Texture_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float4 _Mask_var = tex2Dlod(_Mask,float4(TRANSFORM_TEX(o.uv0, _Mask),0.0,0));
                float4 node_9692 = _Time + _TimeEditor;
                float2 node_3425 = ((o.uv0*0.3)+node_9692.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_3425, _VectorTexture),0.0,0));
                float2 node_1396 = (o.uv0+node_9692.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_1396, _VectorTexture),0.0,0));
                v.vertex.xyz += (_Mask_var.rgb*(_VectorOffset.rgb+((_DistortPower*2.0+0.0)*(node_3600.rgb+(node_6172.rgb*_SmallDistortValue)))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float3 node_8072 = (_Color.rgb*_Texture_var.rgb);
                o.Emission = node_8072;
                
                float3 diffColor = node_8072;
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
