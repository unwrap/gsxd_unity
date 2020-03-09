// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.25 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.25;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:34093,y:33029,varname:node_2865,prsc:2|diff-7010-OUT,spec-1339-OUT,gloss-3389-OUT,normal-3904-OUT,difocc-9-OUT,spcocc-9-OUT;n:type:ShaderForge.SFN_Multiply,id:6343,x:32283,y:32565,varname:node_6343,prsc:2|A-7736-RGB,B-6665-RGB;n:type:ShaderForge.SFN_Color,id:6665,x:32016,y:32579,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:31562,y:32414,ptovrint:True,ptlb:Base Color,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6392-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5964,x:32096,y:33141,ptovrint:True,ptlb:Normal Map,ptin:_BumpMap,varname:_BumpMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:5859,x:31352,y:33130,ptovrint:False,ptlb:Concrete,ptin:_Concrete,varname:node_5859,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:1,isnm:False|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5403,x:31352,y:32950,ptovrint:False,ptlb:Metal,ptin:_Metal,varname:node_5403,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:1,isnm:False|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:4841,x:31352,y:32775,ptovrint:False,ptlb:Glass,ptin:_Glass,varname:node_4841,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:1,isnm:False|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:6392,x:30928,y:32466,varname:node_6392,prsc:2,uv:0;n:type:ShaderForge.SFN_TexCoord,id:8113,x:30883,y:32994,varname:node_8113,prsc:2,uv:1;n:type:ShaderForge.SFN_Tex2d,id:2615,x:31352,y:32598,ptovrint:False,ptlb:Masks (RGB) AO (A),ptin:_MasksRGBAOA,varname:node_2615,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Lerp,id:1346,x:31556,y:32879,varname:node_1346,prsc:2|A-5859-R,B-5403-R,T-2615-R;n:type:ShaderForge.SFN_Lerp,id:2806,x:31766,y:32708,varname:node_2806,prsc:2|A-1346-OUT,B-4841-R,T-2615-G;n:type:ShaderForge.SFN_Lerp,id:9692,x:31556,y:33018,varname:node_9692,prsc:2|A-5859-A,B-5403-A,T-2615-R;n:type:ShaderForge.SFN_Lerp,id:9005,x:31766,y:32834,varname:node_9005,prsc:2|A-9692-OUT,B-4841-A,T-2615-G;n:type:ShaderForge.SFN_Tex2d,id:5210,x:31359,y:33475,ptovrint:False,ptlb:Metal Normal,ptin:_MetalNormal,varname:node_5210,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:651,x:31359,y:33650,ptovrint:False,ptlb:Concrete Normal,ptin:_ConcreteNormal,varname:node_651,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Lerp,id:2608,x:31660,y:33353,varname:node_2608,prsc:2|A-651-RGB,B-5210-RGB,T-2615-R;n:type:ShaderForge.SFN_Lerp,id:5277,x:31868,y:33259,varname:node_5277,prsc:2|A-2608-OUT,B-8331-RGB,T-2615-G;n:type:ShaderForge.SFN_Tex2d,id:8331,x:31359,y:33307,ptovrint:False,ptlb:Glass Normal,ptin:_GlassNormal,varname:node_8331,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_NormalBlend,id:3904,x:32314,y:33280,varname:node_3904,prsc:2|BSE-5964-RGB,DTL-5277-OUT;n:type:ShaderForge.SFN_Slider,id:960,x:31990,y:32972,ptovrint:False,ptlb:AO ,ptin:_AO,varname:node_8610,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_RemapRange,id:3675,x:32366,y:33010,varname:node_3675,prsc:2,frmn:0,frmx:1,tomn:0,tomx:2|IN-960-OUT;n:type:ShaderForge.SFN_Lerp,id:4746,x:31868,y:33448,varname:node_4746,prsc:2|A-3447-OUT,B-4841-G,T-2615-G;n:type:ShaderForge.SFN_Lerp,id:3447,x:31660,y:33523,varname:node_3447,prsc:2|A-5859-G,B-5403-G,T-2615-R;n:type:ShaderForge.SFN_Multiply,id:123,x:32500,y:32670,varname:node_123,prsc:2|A-4746-OUT,B-6343-OUT;n:type:ShaderForge.SFN_Tex2d,id:4754,x:32500,y:32480,ptovrint:False,ptlb:Dirt,ptin:_Dirt,varname:node_4754,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8113-UVOUT;n:type:ShaderForge.SFN_Multiply,id:633,x:32762,y:32558,varname:node_633,prsc:2|A-4754-RGB,B-123-OUT;n:type:ShaderForge.SFN_Lerp,id:2810,x:32726,y:32000,varname:node_2810,prsc:2|A-2615-A,B-3887-OUT,T-4950-OUT;n:type:ShaderForge.SFN_Vector3,id:3887,x:32510,y:31953,varname:node_3887,prsc:2,v1:1,v2:1,v3:1;n:type:ShaderForge.SFN_OneMinus,id:4950,x:32520,y:32034,varname:node_4950,prsc:2|IN-2615-G;n:type:ShaderForge.SFN_Multiply,id:1339,x:32630,y:32786,varname:node_1339,prsc:2|A-5662-OUT,B-2806-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2631,x:32857,y:32152,varname:node_2631,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-2810-OUT;n:type:ShaderForge.SFN_Power,id:5662,x:32869,y:32318,varname:node_5662,prsc:2|VAL-2631-OUT,EXP-3509-OUT;n:type:ShaderForge.SFN_Vector1,id:3509,x:32742,y:32367,varname:node_3509,prsc:2,v1:0.7;n:type:ShaderForge.SFN_Slider,id:5745,x:30728,y:31885,ptovrint:False,ptlb:Leaks scale,ptin:_Leaksscale,varname:node_1555,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_RemapRange,id:2107,x:31089,y:31901,varname:node_2107,prsc:2,frmn:0,frmx:1,tomn:0.05,tomx:0.5|IN-5745-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:1057,x:30935,y:31622,varname:node_1057,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5594,x:31332,y:31593,varname:node_5594,prsc:2|A-1057-X,B-2107-OUT;n:type:ShaderForge.SFN_Multiply,id:828,x:31332,y:31708,varname:node_828,prsc:2|A-1057-Y,B-2107-OUT;n:type:ShaderForge.SFN_Multiply,id:494,x:31332,y:31827,varname:node_494,prsc:2|A-1057-Z,B-2107-OUT;n:type:ShaderForge.SFN_Append,id:4126,x:31715,y:31829,varname:node_4126,prsc:2|A-5594-OUT,B-828-OUT;n:type:ShaderForge.SFN_Append,id:7145,x:31715,y:31571,varname:node_7145,prsc:2|A-494-OUT,B-828-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:5167,x:31879,y:31718,ptovrint:False,ptlb:Leaks,ptin:_Leaks,varname:node_7599,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:77,x:32103,y:31562,varname:node_1538,prsc:2,ntxv:0,isnm:False|UVIN-7145-OUT,TEX-5167-TEX;n:type:ShaderForge.SFN_Tex2d,id:7266,x:32118,y:31815,varname:node_8935,prsc:2,ntxv:0,isnm:False|UVIN-4126-OUT,TEX-5167-TEX;n:type:ShaderForge.SFN_NormalVector,id:8711,x:31418,y:32009,prsc:2,pt:True;n:type:ShaderForge.SFN_Abs,id:721,x:31664,y:31972,varname:node_721,prsc:2|IN-8711-OUT;n:type:ShaderForge.SFN_Multiply,id:7850,x:31918,y:32068,varname:node_7850,prsc:2|A-721-OUT,B-721-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:1028,x:32468,y:31735,varname:node_1028,prsc:2,chbt:0|M-7850-OUT,R-77-RGB,G-7800-OUT,B-7266-RGB;n:type:ShaderForge.SFN_Vector3,id:7800,x:32103,y:31467,varname:node_7800,prsc:2,v1:1,v2:1,v3:1;n:type:ShaderForge.SFN_Multiply,id:6861,x:33109,y:32496,varname:node_6861,prsc:2|A-1028-OUT,B-633-OUT;n:type:ShaderForge.SFN_Power,id:1268,x:33079,y:31865,varname:node_1268,prsc:2|VAL-2615-A,EXP-8467-OUT;n:type:ShaderForge.SFN_Vector1,id:8467,x:32897,y:31899,varname:node_8467,prsc:2,v1:15;n:type:ShaderForge.SFN_Subtract,id:4731,x:33317,y:31991,varname:node_4731,prsc:2|A-1268-OUT,B-8510-OUT;n:type:ShaderForge.SFN_Add,id:8782,x:33507,y:31967,varname:node_8782,prsc:2|A-4731-OUT,B-3110-RGB;n:type:ShaderForge.SFN_Multiply,id:7010,x:33453,y:32318,varname:node_7010,prsc:2|A-8975-OUT,B-6861-OUT;n:type:ShaderForge.SFN_Clamp01,id:8975,x:33510,y:32121,varname:node_8975,prsc:2|IN-8782-OUT;n:type:ShaderForge.SFN_Color,id:3110,x:33162,y:31610,ptovrint:False,ptlb:Additional AO,ptin:_AdditionalAO,varname:node_3110,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.290279,c2:0.3631555,c3:0.4338235,c4:0;n:type:ShaderForge.SFN_Slider,id:9796,x:32922,y:32047,ptovrint:False,ptlb:Additional AO Power,ptin:_AdditionalAOPower,varname:node_9796,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3,max:1;n:type:ShaderForge.SFN_RemapRange,id:8510,x:33208,y:32128,varname:node_8510,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:0|IN-9796-OUT;n:type:ShaderForge.SFN_Clamp01,id:9,x:32848,y:32957,varname:node_9,prsc:2|IN-3845-OUT;n:type:ShaderForge.SFN_Power,id:3845,x:32569,y:32959,varname:node_3845,prsc:2|VAL-2615-A,EXP-3675-OUT;n:type:ShaderForge.SFN_OneMinus,id:300,x:32909,y:32695,varname:node_300,prsc:2|IN-4754-R;n:type:ShaderForge.SFN_Subtract,id:4272,x:33056,y:32732,varname:node_4272,prsc:2|A-300-OUT,B-6829-OUT;n:type:ShaderForge.SFN_Vector1,id:6829,x:32909,y:32833,varname:node_6829,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Add,id:8133,x:33067,y:32877,varname:node_8133,prsc:2|A-4272-OUT,B-9005-OUT;n:type:ShaderForge.SFN_OneMinus,id:4094,x:33303,y:32589,varname:node_4094,prsc:2|IN-1028-OUT;n:type:ShaderForge.SFN_Add,id:3389,x:33384,y:32753,varname:node_3389,prsc:2|A-186-OUT,B-8133-OUT;n:type:ShaderForge.SFN_ComponentMask,id:186,x:33475,y:32560,varname:node_186,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-4094-OUT;proporder:7736-6665-5964-2615-960-9796-3110-5859-651-5403-5210-4841-8331-4754-5167-5745;pass:END;sub:END;*/

Shader "MK4/MK4_Building_Toon" {
    Properties {
        _MainTex ("Base Color", 2D) = "white" {}
        _Color ("Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _MasksRGBAOA ("Masks (RGB) AO (A)", 2D) = "white" {}
        _AO ("AO ", Range(0, 1)) = 0.2
        _AdditionalAOPower ("Additional AO Power", Range(0, 1)) = 0.3
        _AdditionalAO ("Additional AO", Color) = (0.290279,0.3631555,0.4338235,0)
        _Concrete ("Concrete", 2D) = "gray" {}
        _ConcreteNormal ("Concrete Normal", 2D) = "bump" {}
        _Metal ("Metal", 2D) = "gray" {}
        _MetalNormal ("Metal Normal", 2D) = "bump" {}
        _Glass ("Glass", 2D) = "gray" {}
        _GlassNormal ("Glass Normal", 2D) = "bump" {}
        _Dirt ("Dirt", 2D) = "white" {}
        _Leaks ("Leaks", 2D) = "white" {}
        _Leaksscale ("Leaks scale", Range(0, 1)) = 0.2
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
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform sampler2D _Concrete; uniform float4 _Concrete_ST;
            uniform sampler2D _Metal; uniform float4 _Metal_ST;
            uniform sampler2D _Glass; uniform float4 _Glass_ST;
            uniform sampler2D _MasksRGBAOA; uniform float4 _MasksRGBAOA_ST;
            uniform sampler2D _MetalNormal; uniform float4 _MetalNormal_ST;
            uniform sampler2D _ConcreteNormal; uniform float4 _ConcreteNormal_ST;
            uniform sampler2D _GlassNormal; uniform float4 _GlassNormal_ST;
            uniform float _AO;
            uniform sampler2D _Dirt; uniform float4 _Dirt_ST;
            uniform float _Leaksscale;
            uniform sampler2D _Leaks; uniform float4 _Leaks_ST;
            uniform float4 _AdditionalAO;
            uniform float _AdditionalAOPower;
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
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 _ConcreteNormal_var = UnpackNormal(tex2D(_ConcreteNormal,TRANSFORM_TEX(i.uv1, _ConcreteNormal)));
                float3 _MetalNormal_var = UnpackNormal(tex2D(_MetalNormal,TRANSFORM_TEX(i.uv1, _MetalNormal)));
                float4 _MasksRGBAOA_var = tex2D(_MasksRGBAOA,TRANSFORM_TEX(i.uv1, _MasksRGBAOA));
                float3 _GlassNormal_var = UnpackNormal(tex2D(_GlassNormal,TRANSFORM_TEX(i.uv1, _GlassNormal)));
                float3 node_3904_nrm_base = _BumpMap_var.rgb + float3(0,0,1);
                float3 node_3904_nrm_detail = lerp(lerp(_ConcreteNormal_var.rgb,_MetalNormal_var.rgb,_MasksRGBAOA_var.r),_GlassNormal_var.rgb,_MasksRGBAOA_var.g) * float3(-1,-1,1);
                float3 node_3904_nrm_combined = node_3904_nrm_base*dot(node_3904_nrm_base, node_3904_nrm_detail)/node_3904_nrm_base.z - node_3904_nrm_detail;
                float3 node_3904 = node_3904_nrm_combined;
                float3 normalLocal = node_3904;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float3 node_721 = abs(normalDirection);
                float3 node_7850 = (node_721*node_721);
                float node_2107 = (_Leaksscale*0.45+0.05);
                float node_828 = (i.posWorld.g*node_2107);
                float2 node_7145 = float2((i.posWorld.b*node_2107),node_828);
                float4 node_1538 = tex2D(_Leaks,node_7145);
                float2 node_4126 = float2((i.posWorld.r*node_2107),node_828);
                float4 node_8935 = tex2D(_Leaks,node_4126);
                float3 node_1028 = (node_7850.r*node_1538.rgb + node_7850.g*float3(1,1,1) + node_7850.b*node_8935.rgb);
                float4 _Dirt_var = tex2D(_Dirt,TRANSFORM_TEX(i.uv1, _Dirt));
                float4 _Concrete_var = tex2D(_Concrete,TRANSFORM_TEX(i.uv1, _Concrete));
                float4 _Metal_var = tex2D(_Metal,TRANSFORM_TEX(i.uv1, _Metal));
                float4 _Glass_var = tex2D(_Glass,TRANSFORM_TEX(i.uv1, _Glass));
                float gloss = ((1.0 - node_1028).r+(((1.0 - _Dirt_var.r)-0.2)+lerp(lerp(_Concrete_var.a,_Metal_var.a,_MasksRGBAOA_var.r),_Glass_var.a,_MasksRGBAOA_var.g)));
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
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = (saturate(((pow(_MasksRGBAOA_var.a,15.0)-(_AdditionalAOPower*1.0+-1.0))+_AdditionalAO.rgb))*(node_1028*(_Dirt_var.rgb*(lerp(lerp(_Concrete_var.g,_Metal_var.g,_MasksRGBAOA_var.r),_Glass_var.g,_MasksRGBAOA_var.g)*(_MainTex_var.rgb*_Color.rgb))))); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, (pow(lerp(float3(_MasksRGBAOA_var.a,_MasksRGBAOA_var.a,_MasksRGBAOA_var.a),float3(1,1,1),(1.0 - _MasksRGBAOA_var.g)).r,0.7)*lerp(lerp(_Concrete_var.r,_Metal_var.r,_MasksRGBAOA_var.r),_Glass_var.r,_MasksRGBAOA_var.g)), specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
/////// Diffuse:
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float node_9 = saturate(pow(_MasksRGBAOA_var.a,(_AO*2.0+0.0)));
                indirectDiffuse *= node_9; // Diffuse AO
/// Final Color:
                outDiffuse = half4( diffuseColor, node_9 );
                outSpecSmoothness = half4( specularColor, gloss );
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4(0,0,0,1);
                outEmission.rgb += indirectSpecular * node_9;
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
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform sampler2D _Concrete; uniform float4 _Concrete_ST;
            uniform sampler2D _Metal; uniform float4 _Metal_ST;
            uniform sampler2D _Glass; uniform float4 _Glass_ST;
            uniform sampler2D _MasksRGBAOA; uniform float4 _MasksRGBAOA_ST;
            uniform sampler2D _MetalNormal; uniform float4 _MetalNormal_ST;
            uniform sampler2D _ConcreteNormal; uniform float4 _ConcreteNormal_ST;
            uniform sampler2D _GlassNormal; uniform float4 _GlassNormal_ST;
            uniform float _AO;
            uniform sampler2D _Dirt; uniform float4 _Dirt_ST;
            uniform float _Leaksscale;
            uniform sampler2D _Leaks; uniform float4 _Leaks_ST;
            uniform float4 _AdditionalAO;
            uniform float _AdditionalAOPower;
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
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 _ConcreteNormal_var = UnpackNormal(tex2D(_ConcreteNormal,TRANSFORM_TEX(i.uv1, _ConcreteNormal)));
                float3 _MetalNormal_var = UnpackNormal(tex2D(_MetalNormal,TRANSFORM_TEX(i.uv1, _MetalNormal)));
                float4 _MasksRGBAOA_var = tex2D(_MasksRGBAOA,TRANSFORM_TEX(i.uv1, _MasksRGBAOA));
                float3 _GlassNormal_var = UnpackNormal(tex2D(_GlassNormal,TRANSFORM_TEX(i.uv1, _GlassNormal)));
                float3 node_3904_nrm_base = _BumpMap_var.rgb + float3(0,0,1);
                float3 node_3904_nrm_detail = lerp(lerp(_ConcreteNormal_var.rgb,_MetalNormal_var.rgb,_MasksRGBAOA_var.r),_GlassNormal_var.rgb,_MasksRGBAOA_var.g) * float3(-1,-1,1);
                float3 node_3904_nrm_combined = node_3904_nrm_base*dot(node_3904_nrm_base, node_3904_nrm_detail)/node_3904_nrm_base.z - node_3904_nrm_detail;
                float3 node_3904 = node_3904_nrm_combined;
                float3 normalLocal = node_3904;
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
                float3 node_721 = abs(normalDirection);
                float3 node_7850 = (node_721*node_721);
                float node_2107 = (_Leaksscale*0.45+0.05);
                float node_828 = (i.posWorld.g*node_2107);
                float2 node_7145 = float2((i.posWorld.b*node_2107),node_828);
                float4 node_1538 = tex2D(_Leaks,node_7145);
                float2 node_4126 = float2((i.posWorld.r*node_2107),node_828);
                float4 node_8935 = tex2D(_Leaks,node_4126);
                float3 node_1028 = (node_7850.r*node_1538.rgb + node_7850.g*float3(1,1,1) + node_7850.b*node_8935.rgb);
                float4 _Dirt_var = tex2D(_Dirt,TRANSFORM_TEX(i.uv1, _Dirt));
                float4 _Concrete_var = tex2D(_Concrete,TRANSFORM_TEX(i.uv1, _Concrete));
                float4 _Metal_var = tex2D(_Metal,TRANSFORM_TEX(i.uv1, _Metal));
                float4 _Glass_var = tex2D(_Glass,TRANSFORM_TEX(i.uv1, _Glass));
                float gloss = ((1.0 - node_1028).r+(((1.0 - _Dirt_var.r)-0.2)+lerp(lerp(_Concrete_var.a,_Metal_var.a,_MasksRGBAOA_var.r),_Glass_var.a,_MasksRGBAOA_var.g)));
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
                float node_9 = saturate(pow(_MasksRGBAOA_var.a,(_AO*2.0+0.0)));
                float3 specularAO = node_9;
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = (saturate(((pow(_MasksRGBAOA_var.a,15.0)-(_AdditionalAOPower*1.0+-1.0))+_AdditionalAO.rgb))*(node_1028*(_Dirt_var.rgb*(lerp(lerp(_Concrete_var.g,_Metal_var.g,_MasksRGBAOA_var.r),_Glass_var.g,_MasksRGBAOA_var.g)*(_MainTex_var.rgb*_Color.rgb))))); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, (pow(lerp(float3(_MasksRGBAOA_var.a,_MasksRGBAOA_var.a,_MasksRGBAOA_var.a),float3(1,1,1),(1.0 - _MasksRGBAOA_var.g)).r,0.7)*lerp(lerp(_Concrete_var.r,_Metal_var.r,_MasksRGBAOA_var.r),_Glass_var.r,_MasksRGBAOA_var.g)), specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
                float3 directSpecular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular) * specularAO;
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                indirectDiffuse *= node_9; // Diffuse AO
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
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform sampler2D _Concrete; uniform float4 _Concrete_ST;
            uniform sampler2D _Metal; uniform float4 _Metal_ST;
            uniform sampler2D _Glass; uniform float4 _Glass_ST;
            uniform sampler2D _MasksRGBAOA; uniform float4 _MasksRGBAOA_ST;
            uniform sampler2D _MetalNormal; uniform float4 _MetalNormal_ST;
            uniform sampler2D _ConcreteNormal; uniform float4 _ConcreteNormal_ST;
            uniform sampler2D _GlassNormal; uniform float4 _GlassNormal_ST;
            uniform sampler2D _Dirt; uniform float4 _Dirt_ST;
            uniform float _Leaksscale;
            uniform sampler2D _Leaks; uniform float4 _Leaks_ST;
            uniform float4 _AdditionalAO;
            uniform float _AdditionalAOPower;
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
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 _ConcreteNormal_var = UnpackNormal(tex2D(_ConcreteNormal,TRANSFORM_TEX(i.uv1, _ConcreteNormal)));
                float3 _MetalNormal_var = UnpackNormal(tex2D(_MetalNormal,TRANSFORM_TEX(i.uv1, _MetalNormal)));
                float4 _MasksRGBAOA_var = tex2D(_MasksRGBAOA,TRANSFORM_TEX(i.uv1, _MasksRGBAOA));
                float3 _GlassNormal_var = UnpackNormal(tex2D(_GlassNormal,TRANSFORM_TEX(i.uv1, _GlassNormal)));
                float3 node_3904_nrm_base = _BumpMap_var.rgb + float3(0,0,1);
                float3 node_3904_nrm_detail = lerp(lerp(_ConcreteNormal_var.rgb,_MetalNormal_var.rgb,_MasksRGBAOA_var.r),_GlassNormal_var.rgb,_MasksRGBAOA_var.g) * float3(-1,-1,1);
                float3 node_3904_nrm_combined = node_3904_nrm_base*dot(node_3904_nrm_base, node_3904_nrm_detail)/node_3904_nrm_base.z - node_3904_nrm_detail;
                float3 node_3904 = node_3904_nrm_combined;
                float3 normalLocal = node_3904;
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
                float3 node_721 = abs(normalDirection);
                float3 node_7850 = (node_721*node_721);
                float node_2107 = (_Leaksscale*0.45+0.05);
                float node_828 = (i.posWorld.g*node_2107);
                float2 node_7145 = float2((i.posWorld.b*node_2107),node_828);
                float4 node_1538 = tex2D(_Leaks,node_7145);
                float2 node_4126 = float2((i.posWorld.r*node_2107),node_828);
                float4 node_8935 = tex2D(_Leaks,node_4126);
                float3 node_1028 = (node_7850.r*node_1538.rgb + node_7850.g*float3(1,1,1) + node_7850.b*node_8935.rgb);
                float4 _Dirt_var = tex2D(_Dirt,TRANSFORM_TEX(i.uv1, _Dirt));
                float4 _Concrete_var = tex2D(_Concrete,TRANSFORM_TEX(i.uv1, _Concrete));
                float4 _Metal_var = tex2D(_Metal,TRANSFORM_TEX(i.uv1, _Metal));
                float4 _Glass_var = tex2D(_Glass,TRANSFORM_TEX(i.uv1, _Glass));
                float gloss = ((1.0 - node_1028).r+(((1.0 - _Dirt_var.r)-0.2)+lerp(lerp(_Concrete_var.a,_Metal_var.a,_MasksRGBAOA_var.r),_Glass_var.a,_MasksRGBAOA_var.g)));
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffuseColor = (saturate(((pow(_MasksRGBAOA_var.a,15.0)-(_AdditionalAOPower*1.0+-1.0))+_AdditionalAO.rgb))*(node_1028*(_Dirt_var.rgb*(lerp(lerp(_Concrete_var.g,_Metal_var.g,_MasksRGBAOA_var.r),_Glass_var.g,_MasksRGBAOA_var.g)*(_MainTex_var.rgb*_Color.rgb))))); // Need this for specular when using metallic
                float specularMonochrome;
                float3 specularColor;
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, (pow(lerp(float3(_MasksRGBAOA_var.a,_MasksRGBAOA_var.a,_MasksRGBAOA_var.a),float3(1,1,1),(1.0 - _MasksRGBAOA_var.g)).r,0.7)*lerp(lerp(_Concrete_var.r,_Metal_var.r,_MasksRGBAOA_var.r),_Glass_var.r,_MasksRGBAOA_var.g)), specularColor, specularMonochrome );
                specularMonochrome = 1-specularMonochrome;
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
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
            uniform float4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _Concrete; uniform float4 _Concrete_ST;
            uniform sampler2D _Metal; uniform float4 _Metal_ST;
            uniform sampler2D _Glass; uniform float4 _Glass_ST;
            uniform sampler2D _MasksRGBAOA; uniform float4 _MasksRGBAOA_ST;
            uniform sampler2D _Dirt; uniform float4 _Dirt_ST;
            uniform float _Leaksscale;
            uniform sampler2D _Leaks; uniform float4 _Leaks_ST;
            uniform float4 _AdditionalAO;
            uniform float _AdditionalAOPower;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 _MasksRGBAOA_var = tex2D(_MasksRGBAOA,TRANSFORM_TEX(i.uv1, _MasksRGBAOA));
                float3 node_721 = abs(normalDirection);
                float3 node_7850 = (node_721*node_721);
                float node_2107 = (_Leaksscale*0.45+0.05);
                float node_828 = (i.posWorld.g*node_2107);
                float2 node_7145 = float2((i.posWorld.b*node_2107),node_828);
                float4 node_1538 = tex2D(_Leaks,node_7145);
                float2 node_4126 = float2((i.posWorld.r*node_2107),node_828);
                float4 node_8935 = tex2D(_Leaks,node_4126);
                float3 node_1028 = (node_7850.r*node_1538.rgb + node_7850.g*float3(1,1,1) + node_7850.b*node_8935.rgb);
                float4 _Dirt_var = tex2D(_Dirt,TRANSFORM_TEX(i.uv1, _Dirt));
                float4 _Concrete_var = tex2D(_Concrete,TRANSFORM_TEX(i.uv1, _Concrete));
                float4 _Metal_var = tex2D(_Metal,TRANSFORM_TEX(i.uv1, _Metal));
                float4 _Glass_var = tex2D(_Glass,TRANSFORM_TEX(i.uv1, _Glass));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 diffColor = (saturate(((pow(_MasksRGBAOA_var.a,15.0)-(_AdditionalAOPower*1.0+-1.0))+_AdditionalAO.rgb))*(node_1028*(_Dirt_var.rgb*(lerp(lerp(_Concrete_var.g,_Metal_var.g,_MasksRGBAOA_var.r),_Glass_var.g,_MasksRGBAOA_var.g)*(_MainTex_var.rgb*_Color.rgb)))));
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, (pow(lerp(float3(_MasksRGBAOA_var.a,_MasksRGBAOA_var.a,_MasksRGBAOA_var.a),float3(1,1,1),(1.0 - _MasksRGBAOA_var.g)).r,0.7)*lerp(lerp(_Concrete_var.r,_Metal_var.r,_MasksRGBAOA_var.r),_Glass_var.r,_MasksRGBAOA_var.g)), specColor, specularMonochrome );
                float roughness = 1.0 - ((1.0 - node_1028).r+(((1.0 - _Dirt_var.r)-0.2)+lerp(lerp(_Concrete_var.a,_Metal_var.a,_MasksRGBAOA_var.r),_Glass_var.a,_MasksRGBAOA_var.g)));
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
