// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:32719,y:32712,varname:node_2865,prsc:2|diff-5672-OUT,spec-4966-OUT,gloss-3806-OUT,normal-8539-OUT,clip-3298-A,voffset-8048-OUT;n:type:ShaderForge.SFN_Color,id:2340,x:32100,y:32664,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3298,x:31343,y:32837,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5366,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:fb7e809722580dc45b93fe4711520722,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5672,x:32366,y:32769,varname:node_5672,prsc:2|A-2340-RGB,B-3298-RGB;n:type:ShaderForge.SFN_Tex2dAsset,id:1296,x:30974,y:33171,ptovrint:False,ptlb:Vector Texture,ptin:_VectorTexture,varname:node_8650,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4568,x:31272,y:33057,varname:node_3600,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-7425-UVOUT,TEX-1296-TEX;n:type:ShaderForge.SFN_Panner,id:8526,x:31013,y:32942,varname:node_8526,prsc:2,spu:-0.15,spv:0|UVIN-1818-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:1818,x:30412,y:32894,varname:node_1818,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:7425,x:31056,y:32744,varname:node_7425,prsc:2,spu:-0.07,spv:0.05|UVIN-3151-OUT;n:type:ShaderForge.SFN_Multiply,id:3151,x:30860,y:32730,varname:node_3151,prsc:2|A-1818-UVOUT,B-4146-OUT;n:type:ShaderForge.SFN_Vector1,id:4146,x:30709,y:32800,varname:node_4146,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:3047,x:31272,y:33212,varname:node_6172,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-8526-UVOUT,TEX-1296-TEX;n:type:ShaderForge.SFN_Add,id:7299,x:31647,y:33209,varname:node_7299,prsc:2|A-4568-RGB,B-8266-OUT;n:type:ShaderForge.SFN_Tex2d,id:1578,x:31333,y:33624,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_650,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c2b5b60d1c083ea419ffdbb8319442db,ntxv:0,isnm:False|UVIN-1818-UVOUT;n:type:ShaderForge.SFN_Vector4Property,id:2629,x:31717,y:32894,ptovrint:False,ptlb:Vector Offset,ptin:_VectorOffset,varname:node_1307,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:8048,x:32391,y:33270,varname:node_8048,prsc:2|A-1578-RGB,B-4052-OUT;n:type:ShaderForge.SFN_Add,id:4052,x:32138,y:33095,varname:node_4052,prsc:2|A-2629-XYZ,B-5217-OUT;n:type:ShaderForge.SFN_Multiply,id:5217,x:32016,y:33292,varname:node_5217,prsc:2|A-3576-OUT,B-7299-OUT;n:type:ShaderForge.SFN_Slider,id:9471,x:31520,y:33487,ptovrint:False,ptlb:Distort Power,ptin:_DistortPower,varname:node_5926,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:8266,x:31478,y:33308,varname:node_8266,prsc:2|A-3047-RGB,B-5453-OUT;n:type:ShaderForge.SFN_Slider,id:5453,x:31120,y:33475,ptovrint:False,ptlb:Small Distort Value,ptin:_SmallDistortValue,varname:node_8634,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:3576,x:31856,y:33396,varname:node_3576,prsc:2,frmn:0,frmx:1,tomn:0,tomx:2|IN-9471-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:6058,x:30924,y:33876,ptovrint:False,ptlb:Normal Map,ptin:_NormalMap,varname:node_2180,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:2867,x:31237,y:33809,varname:node_3937,prsc:2,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:0,isnm:False|UVIN-7425-UVOUT,TEX-6058-TEX;n:type:ShaderForge.SFN_Tex2d,id:2272,x:31224,y:33995,varname:node_8686,prsc:2,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:0,isnm:False|UVIN-8526-UVOUT,TEX-6058-TEX;n:type:ShaderForge.SFN_NormalBlend,id:8539,x:32391,y:33131,varname:node_8539,prsc:2|BSE-2867-RGB,DTL-2272-RGB;n:type:ShaderForge.SFN_Slider,id:4966,x:32258,y:32967,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_2264,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:3806,x:32258,y:33045,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_3734,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;proporder:2340-3298-4966-3806-6058-1296-1578-2629-9471-5453;pass:END;sub:END;*/

Shader "MK4/Banner_PBR" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _Texture ("Texture", 2D) = "white" {}
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _VectorTexture ("Vector Texture", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _VectorOffset ("Vector Offset", Vector) = (0,0,0,0)
        _DistortPower ("Distort Power", Range(0, 1)) = 0.5
        _SmallDistortValue ("Small Distort Value", Range(0, 1)) = 0
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
            #define _GLOSSYENV 1
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Metallic;
            uniform float _Gloss;
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
                float4 node_302 = _Time + _TimeEditor;
                float2 node_7425 = ((o.uv0*0.3)+node_302.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7425, _VectorTexture),0.0,0));
                float2 node_8526 = (o.uv0+node_302.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_8526, _VectorTexture),0.0,0));
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
                float4 node_302 = _Time + _TimeEditor;
                float2 node_7425 = ((i.uv0*0.3)+node_302.g*float2(-0.07,0.05));
                float3 node_3937 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7425, _NormalMap)));
                float2 node_8526 = (i.uv0+node_302.g*float2(-0.15,0));
                float3 node_8686 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_8526, _NormalMap)));
                float3 node_8539_nrm_base = node_3937.rgb + float3(0,0,1);
                float3 node_8539_nrm_detail = node_8686.rgb * float3(-1,-1,1);
                float3 node_8539_nrm_combined = node_8539_nrm_base*dot(node_8539_nrm_base, node_8539_nrm_detail)/node_8539_nrm_base.z - node_8539_nrm_detail;
                float3 node_8539 = node_8539_nrm_combined;
                float3 normalLocal = node_8539;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                clip(_Texture_var.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
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
                d.boxMax[0] = unity_SpecCube0_BoxMax;
                d.boxMin[0] = unity_SpecCube0_BoxMin;
                d.probePosition[0] = unity_SpecCube0_ProbePosition;
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.boxMax[1] = unity_SpecCube1_BoxMax;
                d.boxMin[1] = unity_SpecCube1_BoxMin;
                d.probePosition[1] = unity_SpecCube1_ProbePosition;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float3 diffuseColor = (_Color.rgb*_Texture_var.rgb); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _Metallic, specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4) );
                float3 directSpecular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Metallic;
            uniform float _Gloss;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 _Mask_var = tex2Dlod(_Mask,float4(TRANSFORM_TEX(o.uv0, _Mask),0.0,0));
                float4 node_3725 = _Time + _TimeEditor;
                float2 node_7425 = ((o.uv0*0.3)+node_3725.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7425, _VectorTexture),0.0,0));
                float2 node_8526 = (o.uv0+node_3725.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_8526, _VectorTexture),0.0,0));
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
                float4 node_3725 = _Time + _TimeEditor;
                float2 node_7425 = ((i.uv0*0.3)+node_3725.g*float2(-0.07,0.05));
                float3 node_3937 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7425, _NormalMap)));
                float2 node_8526 = (i.uv0+node_3725.g*float2(-0.15,0));
                float3 node_8686 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_8526, _NormalMap)));
                float3 node_8539_nrm_base = node_3937.rgb + float3(0,0,1);
                float3 node_8539_nrm_detail = node_8686.rgb * float3(-1,-1,1);
                float3 node_8539_nrm_combined = node_8539_nrm_base*dot(node_8539_nrm_base, node_8539_nrm_detail)/node_8539_nrm_base.z - node_8539_nrm_detail;
                float3 node_8539 = node_8539_nrm_combined;
                float3 normalLocal = node_8539;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                clip(_Texture_var.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float3 diffuseColor = (_Color.rgb*_Texture_var.rgb); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _Metallic, specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4) );
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
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
            #define _GLOSSYENV 1
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
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
                float4 node_4095 = _Time + _TimeEditor;
                float2 node_7425 = ((o.uv0*0.3)+node_4095.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7425, _VectorTexture),0.0,0));
                float2 node_8526 = (o.uv0+node_4095.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_8526, _VectorTexture),0.0,0));
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
            #define _GLOSSYENV 1
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            #pragma glsl
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform sampler2D _VectorTexture; uniform float4 _VectorTexture_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _VectorOffset;
            uniform float _DistortPower;
            uniform float _SmallDistortValue;
            uniform float _Metallic;
            uniform float _Gloss;
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
                float4 node_3402 = _Time + _TimeEditor;
                float2 node_7425 = ((o.uv0*0.3)+node_3402.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7425, _VectorTexture),0.0,0));
                float2 node_8526 = (o.uv0+node_3402.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_8526, _VectorTexture),0.0,0));
                v.vertex.xyz += (_Mask_var.rgb*(_VectorOffset.rgb+((_DistortPower*2.0+0.0)*(node_3600.rgb+(node_6172.rgb*_SmallDistortValue)))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float3 diffColor = (_Color.rgb*_Texture_var.rgb);
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, _Metallic, specColor, specularMonochrome );
                float roughness = 1.0 - _Gloss;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
