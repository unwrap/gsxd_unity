// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:33502,y:32764,varname:node_4013,prsc:2|diff-4108-OUT,spec-2264-OUT,gloss-3734-OUT,normal-3440-OUT,clip-5366-A,voffset-5743-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32834,y:32510,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:5366,x:32077,y:32683,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5366,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:fb7e809722580dc45b93fe4711520722,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4108,x:33100,y:32615,varname:node_4108,prsc:2|A-1304-RGB,B-5366-RGB;n:type:ShaderForge.SFN_Tex2dAsset,id:8650,x:31708,y:33017,ptovrint:False,ptlb:Vector Texture,ptin:_VectorTexture,varname:node_8650,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:3600,x:32006,y:32903,varname:node_3600,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-7813-UVOUT,TEX-8650-TEX;n:type:ShaderForge.SFN_Panner,id:7896,x:31747,y:32788,varname:node_7896,prsc:2,spu:-0.15,spv:0|UVIN-6257-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:6257,x:31146,y:32740,varname:node_6257,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:7813,x:31747,y:32576,varname:node_7813,prsc:2,spu:-0.07,spv:0.05|UVIN-9431-OUT;n:type:ShaderForge.SFN_Multiply,id:9431,x:31594,y:32576,varname:node_9431,prsc:2|A-6257-UVOUT,B-1134-OUT;n:type:ShaderForge.SFN_Vector1,id:1134,x:31443,y:32646,varname:node_1134,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:6172,x:32006,y:33058,varname:node_6172,prsc:2,tex:8b97c3e80593993429f690283e78ff16,ntxv:0,isnm:False|UVIN-7896-UVOUT,TEX-8650-TEX;n:type:ShaderForge.SFN_Add,id:1920,x:32381,y:33055,varname:node_1920,prsc:2|A-3600-RGB,B-9593-OUT;n:type:ShaderForge.SFN_Tex2d,id:650,x:32067,y:33470,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_650,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c2b5b60d1c083ea419ffdbb8319442db,ntxv:0,isnm:False|UVIN-6257-UVOUT;n:type:ShaderForge.SFN_Vector4Property,id:1307,x:32451,y:32740,ptovrint:False,ptlb:Vector Offset,ptin:_VectorOffset,varname:node_1307,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Multiply,id:5743,x:33125,y:33116,varname:node_5743,prsc:2|A-650-RGB,B-1934-OUT;n:type:ShaderForge.SFN_Add,id:1934,x:32872,y:32941,varname:node_1934,prsc:2|A-1307-XYZ,B-6084-OUT;n:type:ShaderForge.SFN_Multiply,id:6084,x:32750,y:33138,varname:node_6084,prsc:2|A-705-OUT,B-1920-OUT;n:type:ShaderForge.SFN_Slider,id:5926,x:32254,y:33333,ptovrint:False,ptlb:Distort Power,ptin:_DistortPower,varname:node_5926,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:9593,x:32212,y:33154,varname:node_9593,prsc:2|A-6172-RGB,B-8634-OUT;n:type:ShaderForge.SFN_Slider,id:8634,x:31854,y:33321,ptovrint:False,ptlb:Small Distort Value,ptin:_SmallDistortValue,varname:node_8634,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:705,x:32590,y:33242,varname:node_705,prsc:2,frmn:0,frmx:1,tomn:0,tomx:2|IN-5926-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:2180,x:31658,y:33722,ptovrint:False,ptlb:Normal Map,ptin:_NormalMap,varname:node_2180,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:3937,x:31971,y:33655,varname:node_3937,prsc:2,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:0,isnm:False|UVIN-7813-UVOUT,TEX-2180-TEX;n:type:ShaderForge.SFN_Tex2d,id:8686,x:31958,y:33841,varname:node_8686,prsc:2,tex:5946b8bfb534413468ffae10f0f47d30,ntxv:0,isnm:False|UVIN-7896-UVOUT,TEX-2180-TEX;n:type:ShaderForge.SFN_NormalBlend,id:3440,x:33125,y:32977,varname:node_3440,prsc:2|BSE-3937-RGB,DTL-8686-RGB;n:type:ShaderForge.SFN_Slider,id:2264,x:32992,y:32813,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_2264,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:3734,x:32992,y:32891,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_3734,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;proporder:1304-5366-2264-3734-8650-650-1307-5926-8634-2180;pass:END;sub:END;*/

Shader "MK4/Banner" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _Texture ("Texture", 2D) = "white" {}
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0
        _VectorTexture ("Vector Texture", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _VectorOffset ("Vector Offset", Vector) = (0,0,0,0)
        _DistortPower ("Distort Power", Range(0, 1)) = 0.5
        _SmallDistortValue ("Small Distort Value", Range(0, 1)) = 0
        _NormalMap ("Normal Map", 2D) = "bump" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_DEFERRED
            #define UNITY_PASS_DEFERRED
			#endif
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
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
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
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
                float4 node_6483 = _Time + _TimeEditor;
                float2 node_7813 = ((o.uv0*0.3)+node_6483.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7813, _VectorTexture),0.0,0));
                float2 node_7896 = (o.uv0+node_6483.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7896, _VectorTexture),0.0,0));
                v.vertex.xyz += (_Mask_var.rgb*(_VectorOffset.rgb+((_DistortPower*2.0+0.0)*(node_3600.rgb+(node_6172.rgb*_SmallDistortValue)))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            void frag(
                VertexOutput i,
                out half4 outDiffuse : SV_Target0,
                out half4 outSpecSmoothness : SV_Target1,
                out half4 outNormal : SV_Target2,
                out half4 outEmission : SV_Target3 )
            {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_6483 = _Time + _TimeEditor;
                float2 node_7813 = ((i.uv0*0.3)+node_6483.g*float2(-0.07,0.05));
                float3 node_3937 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7813, _NormalMap)));
                float2 node_7896 = (i.uv0+node_6483.g*float2(-0.15,0));
                float3 node_8686 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7896, _NormalMap)));
                float3 node_3440_nrm_base = node_3937.rgb + float3(0,0,1);
                float3 node_3440_nrm_detail = node_8686.rgb * float3(-1,-1,1);
                float3 node_3440_nrm_combined = node_3440_nrm_base*dot(node_3440_nrm_base, node_3440_nrm_detail)/node_3440_nrm_base.z - node_3440_nrm_detail;
                float3 node_3440 = node_3440_nrm_combined;
                float3 normalLocal = node_3440;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                clip(_Texture_var.a - 0.5);
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
/////// GI Data:
                UnityLight light; // Dummy light
                light.color = 0;
                light.dir = half3(0,1,0);
                light.ndotl = max(0,dot(normalDirection,light.dir));
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = 1;
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
////// Specular:
                float3 diffuseColor = (_Color.rgb*_Texture_var.rgb); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, _Metallic, specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
/// Final Color:
                outDiffuse = half4( diffuseColor, 1 );
                outSpecSmoothness = half4( specularColor, gloss );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4(0,0,0,1);
                outEmission.rgb += indirectSpecular * 1;
                outEmission.rgb += indirectDiffuse * diffuseColor;
                #ifndef UNITY_HDR_ON
                    outEmission.rgb = exp2(-outEmission.rgb);
                #endif
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_FORWARDBASE
            #define UNITY_PASS_FORWARDBASE
			#endif
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
                float4 node_939 = _Time + _TimeEditor;
                float2 node_7813 = ((o.uv0*0.3)+node_939.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7813, _VectorTexture),0.0,0));
                float2 node_7896 = (o.uv0+node_939.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7896, _VectorTexture),0.0,0));
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
                float4 node_939 = _Time + _TimeEditor;
                float2 node_7813 = ((i.uv0*0.3)+node_939.g*float2(-0.07,0.05));
                float3 node_3937 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7813, _NormalMap)));
                float2 node_7896 = (i.uv0+node_939.g*float2(-0.15,0));
                float3 node_8686 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7896, _NormalMap)));
                float3 node_3440_nrm_base = node_3937.rgb + float3(0,0,1);
                float3 node_3440_nrm_detail = node_8686.rgb * float3(-1,-1,1);
                float3 node_3440_nrm_combined = node_3440_nrm_base*dot(node_3440_nrm_base, node_3440_nrm_detail)/node_3440_nrm_base.z - node_3440_nrm_detail;
                float3 node_3440 = node_3440_nrm_combined;
                float3 normalLocal = node_3440;
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
				#if UNITY_SPECCUBE_BOX_PROJECTION
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
				#endif
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
			#ifndef UNITY_PASS_FORWARDADD
            #define UNITY_PASS_FORWARDADD
			#endif
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
                float4 node_7944 = _Time + _TimeEditor;
                float2 node_7813 = ((o.uv0*0.3)+node_7944.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7813, _VectorTexture),0.0,0));
                float2 node_7896 = (o.uv0+node_7944.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7896, _VectorTexture),0.0,0));
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
                float4 node_7944 = _Time + _TimeEditor;
                float2 node_7813 = ((i.uv0*0.3)+node_7944.g*float2(-0.07,0.05));
                float3 node_3937 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7813, _NormalMap)));
                float2 node_7896 = (i.uv0+node_7944.g*float2(-0.15,0));
                float3 node_8686 = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_7896, _NormalMap)));
                float3 node_3440_nrm_base = node_3937.rgb + float3(0,0,1);
                float3 node_3440_nrm_detail = node_8686.rgb * float3(-1,-1,1);
                float3 node_3440_nrm_combined = node_3440_nrm_base*dot(node_3440_nrm_base, node_3440_nrm_detail)/node_3440_nrm_base.z - node_3440_nrm_detail;
                float3 node_3440 = node_3440_nrm_combined;
                float3 normalLocal = node_3440;
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
			#ifndef UNITY_PASS_SHADOWCASTER
            #define UNITY_PASS_SHADOWCASTER
			#endif
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
                float4 node_7678 = _Time + _TimeEditor;
                float2 node_7813 = ((o.uv0*0.3)+node_7678.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7813, _VectorTexture),0.0,0));
                float2 node_7896 = (o.uv0+node_7678.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7896, _VectorTexture),0.0,0));
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
                float4 node_5558 = _Time + _TimeEditor;
                float2 node_7813 = ((o.uv0*0.3)+node_5558.g*float2(-0.07,0.05));
                float4 node_3600 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7813, _VectorTexture),0.0,0));
                float2 node_7896 = (o.uv0+node_5558.g*float2(-0.15,0));
                float4 node_6172 = tex2Dlod(_VectorTexture,float4(TRANSFORM_TEX(node_7896, _VectorTexture),0.0,0));
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
