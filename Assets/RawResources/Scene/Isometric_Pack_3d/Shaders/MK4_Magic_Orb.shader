// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:1,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-2309-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32117,y:32402,ptovrint:False,ptlb:Base Color,ptin:_BaseColor,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843139,c2:0.1709262,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Fresnel,id:6428,x:31978,y:32916,varname:node_6428,prsc:2|NRM-477-OUT,EXP-434-OUT;n:type:ShaderForge.SFN_OneMinus,id:1153,x:32187,y:33013,varname:node_1153,prsc:2|IN-6428-OUT;n:type:ShaderForge.SFN_NormalVector,id:477,x:31701,y:32890,prsc:2,pt:False;n:type:ShaderForge.SFN_Slider,id:7229,x:31435,y:33160,ptovrint:False,ptlb:Fresnel,ptin:_Fresnel,varname:node_7229,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Color,id:1559,x:32042,y:32577,ptovrint:False,ptlb:Glow Color,ptin:_GlowColor,varname:node_1559,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3014706,c2:0.56643,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:871,x:32289,y:32675,varname:node_871,prsc:2|A-1559-RGB,B-9769-OUT;n:type:ShaderForge.SFN_Slider,id:6819,x:31701,y:32757,ptovrint:False,ptlb:Glow Power,ptin:_GlowPower,varname:node_6819,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:9769,x:32089,y:32729,varname:node_9769,prsc:2,frmn:0,frmx:1,tomn:1,tomx:3|IN-6819-OUT;n:type:ShaderForge.SFN_Lerp,id:2309,x:32532,y:32592,varname:node_2309,prsc:2|A-7241-RGB,B-871-OUT,T-1946-OUT;n:type:ShaderForge.SFN_RemapRange,id:434,x:31819,y:33029,varname:node_434,prsc:2,frmn:0,frmx:1,tomn:6,tomx:0|IN-7229-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:1946,x:32361,y:32901,ptovrint:False,ptlb:Invert,ptin:_Invert,varname:node_1946,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-6428-OUT,B-1153-OUT;proporder:7241-7229-1559-6819-1946;pass:END;sub:END;*/

Shader "MK4/MK4_Magic_Orb" {
    Properties {
        _BaseColor ("Base Color", Color) = (0.07843139,0.1709262,0.7843137,1)
        _Fresnel ("Fresnel", Range(0, 1)) = 1
        _GlowColor ("Glow Color", Color) = (0.3014706,0.56643,1,1)
        _GlowPower ("Glow Power", Range(0, 1)) = 0
        [MaterialToggle] _Invert ("Invert", Float ) = 0
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
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile ___ UNITY_HDR_ON
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _BaseColor;
            uniform float _Fresnel;
            uniform float4 _GlowColor;
            uniform float _GlowPower;
            uniform fixed _Invert;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
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
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float node_6428 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),(_Fresnel*-6.0+6.0));
                float3 emissive = lerp(_BaseColor.rgb,(_GlowColor.rgb*(_GlowPower*2.0+1.0)),lerp( node_6428, (1.0 - node_6428), _Invert ));
                float3 finalColor = emissive;
                outDiffuse = half4( 0, 0, 0, 1 );
                outSpecSmoothness = half4(0,0,0,0);
                outNormal = half4( normalDirection * 0.5 + 0.5, 1 );
                outEmission = half4( lerp(_BaseColor.rgb,(_GlowColor.rgb*(_GlowPower*2.0+1.0)),lerp( node_6428, (1.0 - node_6428), _Invert )), 1 );
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
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _BaseColor;
            uniform float _Fresnel;
            uniform float4 _GlowColor;
            uniform float _GlowPower;
            uniform fixed _Invert;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float node_6428 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),(_Fresnel*-6.0+6.0));
                float3 emissive = lerp(_BaseColor.rgb,(_GlowColor.rgb*(_GlowPower*2.0+1.0)),lerp( node_6428, (1.0 - node_6428), _Invert ));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
