// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:2865,x:32772,y:32736,varname:node_2865,prsc:2|diff-5547-OUT,spec-7717-OUT,gloss-9228-OUT,normal-239-OUT,alpha-175-OUT;n:type:ShaderForge.SFN_Slider,id:7717,x:32292,y:32960,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:node_358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:9228,x:32292,y:33062,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:_Metallic_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_NormalBlend,id:5002,x:32083,y:32494,varname:node_5002,prsc:2|BSE-6485-RGB,DTL-5253-RGB;n:type:ShaderForge.SFN_Normalize,id:239,x:32497,y:32595,varname:node_239,prsc:2|IN-7223-OUT;n:type:ShaderForge.SFN_Vector3,id:8791,x:32105,y:32732,varname:node_8791,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Slider,id:9809,x:32016,y:32874,ptovrint:False,ptlb:Normal Power,ptin:_NormalPower,varname:node_5381,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Lerp,id:7223,x:32316,y:32595,varname:node_7223,prsc:2|A-8791-OUT,B-5002-OUT,T-9809-OUT;n:type:ShaderForge.SFN_Multiply,id:5547,x:32353,y:33494,varname:node_5547,prsc:2|A-7306-RGB,B-4708-OUT;n:type:ShaderForge.SFN_Color,id:7306,x:32113,y:33494,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_9091,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2179931,c2:0.3617558,c3:0.4632353,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6485,x:31722,y:32454,ptovrint:False,ptlb:Normal Map1,ptin:_NormalMap1,varname:node_1842,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:469e586d7b8e93740b61b77ddbba7cd8,ntxv:3,isnm:True|UVIN-32-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5253,x:31722,y:32699,ptovrint:False,ptlb:Normal Map2,ptin:_NormalMap2,varname:node_3922,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3e73256bf73d13f46970d253bf32ce89,ntxv:3,isnm:False|UVIN-2135-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:7147,x:31084,y:32774,varname:node_7147,prsc:2,uv:0;n:type:ShaderForge.SFN_Panner,id:32,x:31372,y:32672,varname:node_32,prsc:2,spu:0,spv:0.3|UVIN-7147-UVOUT;n:type:ShaderForge.SFN_Panner,id:2135,x:31372,y:32895,varname:node_2135,prsc:2,spu:0,spv:0.6|UVIN-7147-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5461,x:31645,y:32969,ptovrint:False,ptlb:Waterfall1,ptin:_Waterfall1,varname:node_5461,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bb7679e4a90251745b0d74243ddae4b5,ntxv:0,isnm:False|UVIN-32-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:8042,x:31645,y:33159,ptovrint:False,ptlb:Waterfall2,ptin:_Waterfall2,varname:node_8042,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:79942d02ef6ebad46bc22ff74454d50b,ntxv:0,isnm:False|UVIN-2135-UVOUT;n:type:ShaderForge.SFN_Lerp,id:4708,x:31905,y:33006,varname:node_4708,prsc:2|A-8042-RGB,B-5461-RGB,T-5461-A;n:type:ShaderForge.SFN_Add,id:5286,x:31909,y:33269,varname:node_5286,prsc:2|A-5461-A,B-8042-A;n:type:ShaderForge.SFN_VertexColor,id:5805,x:31909,y:33393,varname:node_5805,prsc:2;n:type:ShaderForge.SFN_Multiply,id:175,x:32360,y:33177,varname:node_175,prsc:2|A-5805-G,B-5286-OUT;proporder:9809-6485-5253-7717-9228-7306-5461-8042;pass:END;sub:END;*/

Shader "Shader Forge/Waterfall" {
    Properties {
        _NormalPower ("Normal Power", Range(0, 1)) = 0.5
        _NormalMap1 ("Normal Map1", 2D) = "bump" {}
        _NormalMap2 ("Normal Map2", 2D) = "bump" {}
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0.8
        _Color ("Color", Color) = (0.2179931,0.3617558,0.4632353,1)
        _Waterfall1 ("Waterfall1", 2D) = "white" {}
        _Waterfall2 ("Waterfall2", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#ifndef UNITY_PASS_FORWARDBASE
            #define UNITY_PASS_FORWARDBASE
			#endif
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform float _NormalPower;
            uniform float4 _Color;
            uniform sampler2D _NormalMap1; uniform float4 _NormalMap1_ST;
            uniform sampler2D _NormalMap2; uniform float4 _NormalMap2_ST;
            uniform sampler2D _Waterfall1; uniform float4 _Waterfall1_ST;
            uniform sampler2D _Waterfall2; uniform float4 _Waterfall2_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
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
                float4 vertexColor : COLOR;
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
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
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_4958 = _Time + _TimeEditor;
                float2 node_32 = (i.uv0+node_4958.g*float2(0,0.3));
                float3 _NormalMap1_var = UnpackNormal(tex2D(_NormalMap1,TRANSFORM_TEX(node_32, _NormalMap1)));
                float2 node_2135 = (i.uv0+node_4958.g*float2(0,0.6));
                float4 _NormalMap2_var = tex2D(_NormalMap2,TRANSFORM_TEX(node_2135, _NormalMap2));
                float3 node_5002_nrm_base = _NormalMap1_var.rgb + float3(0,0,1);
                float3 node_5002_nrm_detail = _NormalMap2_var.rgb * float3(-1,-1,1);
                float3 node_5002_nrm_combined = node_5002_nrm_base*dot(node_5002_nrm_base, node_5002_nrm_detail)/node_5002_nrm_base.z - node_5002_nrm_detail;
                float3 node_5002 = node_5002_nrm_combined;
                float3 normalLocal = normalize(lerp(float3(0,0,1),node_5002,_NormalPower));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
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
				#endif
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 _Waterfall2_var = tex2D(_Waterfall2,TRANSFORM_TEX(node_2135, _Waterfall2));
                float4 _Waterfall1_var = tex2D(_Waterfall1,TRANSFORM_TEX(node_32, _Waterfall1));
                float3 diffuseColor = (_Color.rgb*lerp(_Waterfall2_var.rgb,_Waterfall1_var.rgb,_Waterfall1_var.a)); // Need this for specular when using metallic
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
                return fixed4(finalColor,(i.vertexColor.g*(_Waterfall1_var.a+_Waterfall2_var.a)));
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
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
            #pragma multi_compile_fwdadd
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Metallic;
            uniform float _Gloss;
            uniform float _NormalPower;
            uniform float4 _Color;
            uniform sampler2D _NormalMap1; uniform float4 _NormalMap1_ST;
            uniform sampler2D _NormalMap2; uniform float4 _NormalMap2_ST;
            uniform sampler2D _Waterfall1; uniform float4 _Waterfall1_ST;
            uniform sampler2D _Waterfall2; uniform float4 _Waterfall2_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
                float4 vertexColor : COLOR;
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
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(7,8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
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
                float4 node_2703 = _Time + _TimeEditor;
                float2 node_32 = (i.uv0+node_2703.g*float2(0,0.3));
                float3 _NormalMap1_var = UnpackNormal(tex2D(_NormalMap1,TRANSFORM_TEX(node_32, _NormalMap1)));
                float2 node_2135 = (i.uv0+node_2703.g*float2(0,0.6));
                float4 _NormalMap2_var = tex2D(_NormalMap2,TRANSFORM_TEX(node_2135, _NormalMap2));
                float3 node_5002_nrm_base = _NormalMap1_var.rgb + float3(0,0,1);
                float3 node_5002_nrm_detail = _NormalMap2_var.rgb * float3(-1,-1,1);
                float3 node_5002_nrm_combined = node_5002_nrm_base*dot(node_5002_nrm_base, node_5002_nrm_detail)/node_5002_nrm_base.z - node_5002_nrm_detail;
                float3 node_5002 = node_5002_nrm_combined;
                float3 normalLocal = normalize(lerp(float3(0,0,1),node_5002,_NormalPower));
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
                float4 _Waterfall2_var = tex2D(_Waterfall2,TRANSFORM_TEX(node_2135, _Waterfall2));
                float4 _Waterfall1_var = tex2D(_Waterfall1,TRANSFORM_TEX(node_32, _Waterfall1));
                float3 diffuseColor = (_Color.rgb*lerp(_Waterfall2_var.rgb,_Waterfall1_var.rgb,_Waterfall1_var.a)); // Need this for specular when using metallic
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
                return fixed4(finalColor * (i.vertexColor.g*(_Waterfall1_var.a+_Waterfall2_var.a)),0);
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
            uniform float4 _Color;
            uniform sampler2D _Waterfall1; uniform float4 _Waterfall1_ST;
            uniform sampler2D _Waterfall2; uniform float4 _Waterfall2_ST;
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
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 node_3142 = _Time + _TimeEditor;
                float2 node_2135 = (i.uv0+node_3142.g*float2(0,0.6));
                float4 _Waterfall2_var = tex2D(_Waterfall2,TRANSFORM_TEX(node_2135, _Waterfall2));
                float2 node_32 = (i.uv0+node_3142.g*float2(0,0.3));
                float4 _Waterfall1_var = tex2D(_Waterfall1,TRANSFORM_TEX(node_32, _Waterfall1));
                float3 diffColor = (_Color.rgb*lerp(_Waterfall2_var.rgb,_Waterfall1_var.rgb,_Waterfall1_var.a));
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
