// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:32808,y:32771,varname:node_2865,prsc:2|diff-2173-OUT,spec-358-OUT,gloss-1813-OUT,normal-2229-OUT;n:type:ShaderForge.SFN_Slider,id:358,x:32228,y:32896,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:32228,y:32998,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:_Metallic_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_Multiply,id:9415,x:31124,y:32203,varname:node_9415,prsc:2|A-391-OUT,B-9640-OUT;n:type:ShaderForge.SFN_Vector1,id:9640,x:30935,y:32256,varname:node_9640,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Append,id:9070,x:30434,y:32411,varname:node_9070,prsc:2|A-2484-X,B-2484-Z;n:type:ShaderForge.SFN_FragmentPosition,id:2484,x:30256,y:32411,varname:node_2484,prsc:2;n:type:ShaderForge.SFN_Panner,id:7014,x:31327,y:32203,varname:node_7014,prsc:2,spu:0.05,spv:0.05|UVIN-9415-OUT;n:type:ShaderForge.SFN_Panner,id:3874,x:31327,y:32390,varname:node_3874,prsc:2,spu:-0.04,spv:-0.06|UVIN-3910-OUT;n:type:ShaderForge.SFN_Multiply,id:3910,x:31124,y:32390,varname:node_3910,prsc:2|A-391-OUT,B-3437-OUT;n:type:ShaderForge.SFN_Vector1,id:3437,x:30922,y:32441,varname:node_3437,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Vector1,id:2470,x:30922,y:32621,varname:node_2470,prsc:2,v1:0.18;n:type:ShaderForge.SFN_Vector1,id:6083,x:30922,y:32824,varname:node_6083,prsc:2,v1:0.14;n:type:ShaderForge.SFN_Multiply,id:3486,x:31124,y:32573,varname:node_3486,prsc:2|A-391-OUT,B-2470-OUT;n:type:ShaderForge.SFN_Multiply,id:7482,x:31124,y:32774,varname:node_7482,prsc:2|A-391-OUT,B-6083-OUT;n:type:ShaderForge.SFN_Panner,id:5486,x:31327,y:32573,varname:node_5486,prsc:2,spu:0.04,spv:-0.06|UVIN-3486-OUT;n:type:ShaderForge.SFN_Panner,id:3251,x:31341,y:32764,varname:node_3251,prsc:2,spu:-0.06,spv:0.03|UVIN-7482-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:937,x:31327,y:32038,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_937,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:11fc85105913c1742a82a9e2a8b1a148,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:8257,x:31603,y:32225,varname:node_8257,prsc:2,tex:11fc85105913c1742a82a9e2a8b1a148,ntxv:0,isnm:False|UVIN-7014-UVOUT,TEX-937-TEX;n:type:ShaderForge.SFN_Tex2d,id:5596,x:31603,y:32408,varname:node_5596,prsc:2,tex:11fc85105913c1742a82a9e2a8b1a148,ntxv:0,isnm:False|UVIN-3874-UVOUT,TEX-937-TEX;n:type:ShaderForge.SFN_NormalBlend,id:8333,x:31840,y:32320,varname:node_8333,prsc:2|BSE-8257-RGB,DTL-5596-RGB;n:type:ShaderForge.SFN_NormalBlend,id:9985,x:31837,y:32668,varname:node_9985,prsc:2|BSE-6093-RGB,DTL-8399-RGB;n:type:ShaderForge.SFN_NormalBlend,id:6596,x:32056,y:32507,varname:node_6596,prsc:2|BSE-8333-OUT,DTL-9985-OUT;n:type:ShaderForge.SFN_Tex2d,id:6093,x:31615,y:32608,varname:node_6093,prsc:2,tex:11fc85105913c1742a82a9e2a8b1a148,ntxv:0,isnm:False|UVIN-5486-UVOUT,TEX-937-TEX;n:type:ShaderForge.SFN_Tex2d,id:8399,x:31615,y:32775,varname:node_8399,prsc:2,tex:11fc85105913c1742a82a9e2a8b1a148,ntxv:0,isnm:False|UVIN-3251-UVOUT,TEX-937-TEX;n:type:ShaderForge.SFN_Normalize,id:2229,x:32418,y:32469,varname:node_2229,prsc:2|IN-3696-OUT;n:type:ShaderForge.SFN_Vector3,id:4556,x:32041,y:32668,varname:node_4556,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Slider,id:5381,x:31952,y:32810,ptovrint:False,ptlb:Normal Power,ptin:_NormalPower,varname:node_5381,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Lerp,id:3696,x:32263,y:32576,varname:node_3696,prsc:2|A-4556-OUT,B-6596-OUT,T-5381-OUT;n:type:ShaderForge.SFN_Multiply,id:391,x:30694,y:32489,varname:node_391,prsc:2|A-9070-OUT,B-7697-OUT;n:type:ShaderForge.SFN_Slider,id:874,x:30177,y:32676,ptovrint:False,ptlb:Wave Scale,ptin:_WaveScale,varname:node_874,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:2173,x:32295,y:33305,varname:node_2173,prsc:2|A-9091-RGB,B-4077-RGB;n:type:ShaderForge.SFN_Color,id:9091,x:32047,y:33214,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_9091,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2179931,c2:0.3617558,c3:0.4632353,c4:1;n:type:ShaderForge.SFN_Tex2dAsset,id:6675,x:31814,y:33402,ptovrint:False,ptlb:Base Color,ptin:_BaseColor,varname:node_6675,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4077,x:32047,y:33371,varname:node_4077,prsc:2,ntxv:0,isnm:False|UVIN-3251-UVOUT,TEX-6675-TEX;n:type:ShaderForge.SFN_RemapRange,id:7697,x:30534,y:32624,varname:node_7697,prsc:2,frmn:0,frmx:1,tomn:0.1,tomx:2|IN-874-OUT;proporder:358-1813-937-5381-9091-6675-874;pass:END;sub:END;*/

Shader "MK4/Water_Deferred" {
    Properties {
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0.8
        _Normal ("Normal", 2D) = "bump" {}
        _NormalPower ("Normal Power", Range(0, 1)) = 0.5
        _Color ("Color", Color) = (0.2179931,0.3617558,0.4632353,1)
        _BaseColor ("Base Color", 2D) = "white" {}
        _WaveScale ("Wave Scale", Range(0, 1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "DEFERRED"
            Tags {
                "LightMode"="Deferred"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_DEFERRED
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _NormalPower;
            uniform float _WaveScale;
            uniform float4 _Color;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD6;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                float4 node_5212 = _Time + _TimeEditor;
                float2 node_391 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_7014 = ((node_391*0.2)+node_5212.g*float2(0.05,0.05));
                float3 node_8257 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_7014, _Normal)));
                float2 node_3874 = ((node_391*0.25)+node_5212.g*float2(-0.04,-0.06));
                float3 node_5596 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3874, _Normal)));
                float3 node_8333_nrm_base = node_8257.rgb + float3(0,0,1);
                float3 node_8333_nrm_detail = node_5596.rgb * float3(-1,-1,1);
                float3 node_8333_nrm_combined = node_8333_nrm_base*dot(node_8333_nrm_base, node_8333_nrm_detail)/node_8333_nrm_base.z - node_8333_nrm_detail;
                float3 node_8333 = node_8333_nrm_combined;
                float2 node_5486 = ((node_391*0.18)+node_5212.g*float2(0.04,-0.06));
                float3 node_6093 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_5486, _Normal)));
                float2 node_3251 = ((node_391*0.14)+node_5212.g*float2(-0.06,0.03));
                float3 node_8399 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3251, _Normal)));
                float3 node_9985_nrm_base = node_6093.rgb + float3(0,0,1);
                float3 node_9985_nrm_detail = node_8399.rgb * float3(-1,-1,1);
                float3 node_9985_nrm_combined = node_9985_nrm_base*dot(node_9985_nrm_base, node_9985_nrm_detail)/node_9985_nrm_base.z - node_9985_nrm_detail;
                float3 node_9985 = node_9985_nrm_combined;
                float3 node_6596_nrm_base = node_8333 + float3(0,0,1);
                float3 node_6596_nrm_detail = node_9985 * float3(-1,-1,1);
                float3 node_6596_nrm_combined = node_6596_nrm_base*dot(node_6596_nrm_base, node_6596_nrm_detail)/node_6596_nrm_base.z - node_6596_nrm_detail;
                float3 node_6596 = node_6596_nrm_combined;
                float3 normalLocal = normalize(lerp(float3(0,0,1),node_6596,_NormalPower));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
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
                float4 node_4077 = tex2D(_BaseColor,TRANSFORM_TEX(node_3251, _BaseColor));
                float3 diffuseColor = (_Color.rgb*node_4077.rgb); // Need this for specular when using metallic
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _NormalPower;
            uniform float _WaveScale;
            uniform float4 _Color;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD8;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_6591 = _Time + _TimeEditor;
                float2 node_391 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_7014 = ((node_391*0.2)+node_6591.g*float2(0.05,0.05));
                float3 node_8257 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_7014, _Normal)));
                float2 node_3874 = ((node_391*0.25)+node_6591.g*float2(-0.04,-0.06));
                float3 node_5596 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3874, _Normal)));
                float3 node_8333_nrm_base = node_8257.rgb + float3(0,0,1);
                float3 node_8333_nrm_detail = node_5596.rgb * float3(-1,-1,1);
                float3 node_8333_nrm_combined = node_8333_nrm_base*dot(node_8333_nrm_base, node_8333_nrm_detail)/node_8333_nrm_base.z - node_8333_nrm_detail;
                float3 node_8333 = node_8333_nrm_combined;
                float2 node_5486 = ((node_391*0.18)+node_6591.g*float2(0.04,-0.06));
                float3 node_6093 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_5486, _Normal)));
                float2 node_3251 = ((node_391*0.14)+node_6591.g*float2(-0.06,0.03));
                float3 node_8399 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3251, _Normal)));
                float3 node_9985_nrm_base = node_6093.rgb + float3(0,0,1);
                float3 node_9985_nrm_detail = node_8399.rgb * float3(-1,-1,1);
                float3 node_9985_nrm_combined = node_9985_nrm_base*dot(node_9985_nrm_base, node_9985_nrm_detail)/node_9985_nrm_base.z - node_9985_nrm_detail;
                float3 node_9985 = node_9985_nrm_combined;
                float3 node_6596_nrm_base = node_8333 + float3(0,0,1);
                float3 node_6596_nrm_detail = node_9985 * float3(-1,-1,1);
                float3 node_6596_nrm_combined = node_6596_nrm_base*dot(node_6596_nrm_base, node_6596_nrm_detail)/node_6596_nrm_base.z - node_6596_nrm_detail;
                float3 node_6596 = node_6596_nrm_combined;
                float3 normalLocal = normalize(lerp(float3(0,0,1),node_6596,_NormalPower));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
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
                float4 node_4077 = tex2D(_BaseColor,TRANSFORM_TEX(node_3251, _BaseColor));
                float3 diffuseColor = (_Color.rgb*node_4077.rgb); // Need this for specular when using metallic
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
                return fixed4(finalColor,1);
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _NormalPower;
            uniform float _WaveScale;
            uniform float4 _Color;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_7197 = _Time + _TimeEditor;
                float2 node_391 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_7014 = ((node_391*0.2)+node_7197.g*float2(0.05,0.05));
                float3 node_8257 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_7014, _Normal)));
                float2 node_3874 = ((node_391*0.25)+node_7197.g*float2(-0.04,-0.06));
                float3 node_5596 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3874, _Normal)));
                float3 node_8333_nrm_base = node_8257.rgb + float3(0,0,1);
                float3 node_8333_nrm_detail = node_5596.rgb * float3(-1,-1,1);
                float3 node_8333_nrm_combined = node_8333_nrm_base*dot(node_8333_nrm_base, node_8333_nrm_detail)/node_8333_nrm_base.z - node_8333_nrm_detail;
                float3 node_8333 = node_8333_nrm_combined;
                float2 node_5486 = ((node_391*0.18)+node_7197.g*float2(0.04,-0.06));
                float3 node_6093 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_5486, _Normal)));
                float2 node_3251 = ((node_391*0.14)+node_7197.g*float2(-0.06,0.03));
                float3 node_8399 = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(node_3251, _Normal)));
                float3 node_9985_nrm_base = node_6093.rgb + float3(0,0,1);
                float3 node_9985_nrm_detail = node_8399.rgb * float3(-1,-1,1);
                float3 node_9985_nrm_combined = node_9985_nrm_base*dot(node_9985_nrm_base, node_9985_nrm_detail)/node_9985_nrm_base.z - node_9985_nrm_detail;
                float3 node_9985 = node_9985_nrm_combined;
                float3 node_6596_nrm_base = node_8333 + float3(0,0,1);
                float3 node_6596_nrm_detail = node_9985 * float3(-1,-1,1);
                float3 node_6596_nrm_combined = node_6596_nrm_base*dot(node_6596_nrm_base, node_6596_nrm_detail)/node_6596_nrm_base.z - node_6596_nrm_detail;
                float3 node_6596 = node_6596_nrm_combined;
                float3 normalLocal = normalize(lerp(float3(0,0,1),node_6596,_NormalPower));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
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
                float4 node_4077 = tex2D(_BaseColor,TRANSFORM_TEX(node_3251, _BaseColor));
                float3 diffuseColor = (_Color.rgb*node_4077.rgb); // Need this for specular when using metallic
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
                return fixed4(finalColor * 1,0);
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
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform float _WaveScale;
            uniform float4 _Color;
            uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 node_8563 = _Time + _TimeEditor;
                float2 node_391 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_3251 = ((node_391*0.14)+node_8563.g*float2(-0.06,0.03));
                float4 node_4077 = tex2D(_BaseColor,TRANSFORM_TEX(node_3251, _BaseColor));
                float3 diffColor = (_Color.rgb*node_4077.rgb);
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
