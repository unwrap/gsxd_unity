// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:32719,y:32712,varname:node_4013,prsc:2|diff-4191-OUT,emission-4191-OUT;n:type:ShaderForge.SFN_Multiply,id:9891,x:30945,y:32257,varname:node_9891,prsc:2|A-35-OUT,B-5577-OUT;n:type:ShaderForge.SFN_Vector1,id:5577,x:30743,y:32318,varname:node_5577,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Append,id:6560,x:30255,y:32465,varname:node_6560,prsc:2|A-6145-X,B-6145-Z;n:type:ShaderForge.SFN_FragmentPosition,id:6145,x:30077,y:32465,varname:node_6145,prsc:2;n:type:ShaderForge.SFN_Panner,id:1997,x:31148,y:32257,varname:node_1997,prsc:2,spu:0.05,spv:0.05|UVIN-9891-OUT;n:type:ShaderForge.SFN_Panner,id:2248,x:31148,y:32444,varname:node_2248,prsc:2,spu:-0.04,spv:-0.06|UVIN-2785-OUT;n:type:ShaderForge.SFN_Multiply,id:2785,x:30945,y:32444,varname:node_2785,prsc:2|A-35-OUT,B-2278-OUT;n:type:ShaderForge.SFN_Vector1,id:2278,x:30743,y:32495,varname:node_2278,prsc:2,v1:0.25;n:type:ShaderForge.SFN_Vector1,id:5005,x:30743,y:32675,varname:node_5005,prsc:2,v1:0.18;n:type:ShaderForge.SFN_Vector1,id:9801,x:30743,y:32878,varname:node_9801,prsc:2,v1:0.14;n:type:ShaderForge.SFN_Multiply,id:7768,x:30945,y:32627,varname:node_7768,prsc:2|A-35-OUT,B-5005-OUT;n:type:ShaderForge.SFN_Multiply,id:143,x:30945,y:32828,varname:node_143,prsc:2|A-35-OUT,B-9801-OUT;n:type:ShaderForge.SFN_Panner,id:268,x:31148,y:32627,varname:node_268,prsc:2,spu:0.04,spv:-0.06|UVIN-7768-OUT;n:type:ShaderForge.SFN_Panner,id:1726,x:31162,y:32818,varname:node_1726,prsc:2,spu:-0.06,spv:0.03|UVIN-143-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:1414,x:31127,y:32093,ptovrint:False,ptlb:Caustics,ptin:_Caustics,varname:node_937,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:30a79a332bea58041a6a2aac2ae8c969,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:2879,x:31424,y:32279,varname:node_8257,prsc:2,tex:30a79a332bea58041a6a2aac2ae8c969,ntxv:0,isnm:False|UVIN-1997-UVOUT,TEX-1414-TEX;n:type:ShaderForge.SFN_Tex2d,id:505,x:31424,y:32462,varname:node_5596,prsc:2,tex:30a79a332bea58041a6a2aac2ae8c969,ntxv:0,isnm:False|UVIN-2248-UVOUT,TEX-1414-TEX;n:type:ShaderForge.SFN_Tex2d,id:6275,x:31436,y:32662,varname:node_6093,prsc:2,tex:30a79a332bea58041a6a2aac2ae8c969,ntxv:0,isnm:False|UVIN-268-UVOUT,TEX-1414-TEX;n:type:ShaderForge.SFN_Tex2d,id:9747,x:31436,y:32829,varname:node_8399,prsc:2,tex:30a79a332bea58041a6a2aac2ae8c969,ntxv:0,isnm:False|UVIN-1726-UVOUT,TEX-1414-TEX;n:type:ShaderForge.SFN_Multiply,id:35,x:30515,y:32543,varname:node_35,prsc:2|A-6560-OUT,B-7848-OUT;n:type:ShaderForge.SFN_Slider,id:3119,x:29998,y:32730,ptovrint:False,ptlb:Wave Scale,ptin:_WaveScale,varname:node_874,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:9458,x:32107,y:32727,varname:node_9458,prsc:2|A-6609-RGB,B-6484-OUT;n:type:ShaderForge.SFN_Color,id:6609,x:31815,y:32733,ptovrint:False,ptlb:Caustic Color,ptin:_CausticColor,varname:node_9091,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_RemapRange,id:7848,x:30355,y:32678,varname:node_7848,prsc:2,frmn:0,frmx:1,tomn:0.1,tomx:2|IN-3119-OUT;n:type:ShaderForge.SFN_Add,id:7099,x:31670,y:32238,varname:node_7099,prsc:2|A-2879-RGB,B-505-RGB;n:type:ShaderForge.SFN_Add,id:2832,x:31950,y:32390,varname:node_2832,prsc:2|A-7099-OUT,B-2758-OUT;n:type:ShaderForge.SFN_Add,id:2758,x:31658,y:32600,varname:node_2758,prsc:2|A-6275-RGB,B-9747-RGB;n:type:ShaderForge.SFN_Add,id:3384,x:32343,y:32777,varname:node_3384,prsc:2|A-9458-OUT,B-6087-RGB;n:type:ShaderForge.SFN_Color,id:6087,x:32107,y:32893,ptovrint:False,ptlb:Water Color,ptin:_WaterColor,varname:node_1148,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.05471455,c2:0.4963757,c3:0.6764706,c4:1;n:type:ShaderForge.SFN_Clamp01,id:4191,x:32515,y:32777,varname:node_4191,prsc:2|IN-3384-OUT;n:type:ShaderForge.SFN_Clamp01,id:6484,x:32129,y:32473,varname:node_6484,prsc:2|IN-2832-OUT;proporder:1414-6609-6087-3119;pass:END;sub:END;*/

Shader "MK4/Mobile/Water" {
    Properties {
        _Caustics ("Caustics", 2D) = "black" {}
        _CausticColor ("Caustic Color", Color) = (1,1,1,1)
        _WaterColor ("Water Color", Color) = (0.05471455,0.4963757,0.6764706,1)
        _WaveScale ("Wave Scale", Range(0, 1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            uniform float4 _TimeEditor;
            uniform sampler2D _Caustics; uniform float4 _Caustics_ST;
            uniform float _WaveScale;
            uniform float4 _CausticColor;
            uniform float4 _WaterColor;
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
                UNITY_FOG_COORDS(8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
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
                float4 node_8239 = _Time + _TimeEditor;
                float2 node_35 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_1997 = ((node_35*0.2)+node_8239.g*float2(0.05,0.05));
                float4 node_8257 = tex2D(_Caustics,TRANSFORM_TEX(node_1997, _Caustics));
                float2 node_2248 = ((node_35*0.25)+node_8239.g*float2(-0.04,-0.06));
                float4 node_5596 = tex2D(_Caustics,TRANSFORM_TEX(node_2248, _Caustics));
                float2 node_268 = ((node_35*0.18)+node_8239.g*float2(0.04,-0.06));
                float4 node_6093 = tex2D(_Caustics,TRANSFORM_TEX(node_268, _Caustics));
                float2 node_1726 = ((node_35*0.14)+node_8239.g*float2(-0.06,0.03));
                float4 node_8399 = tex2D(_Caustics,TRANSFORM_TEX(node_1726, _Caustics));
                float3 node_4191 = saturate(((_CausticColor.rgb*saturate(((node_8257.rgb+node_5596.rgb)+(node_6093.rgb+node_8399.rgb))))+_WaterColor.rgb));
                float3 diffuseColor = node_4191;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = node_4191;
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
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
            uniform float4 _TimeEditor;
            uniform sampler2D _Caustics; uniform float4 _Caustics_ST;
            uniform float _WaveScale;
            uniform float4 _CausticColor;
            uniform float4 _WaterColor;
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
                
                float4 node_8871 = _Time + _TimeEditor;
                float2 node_35 = (float2(i.posWorld.r,i.posWorld.b)*(_WaveScale*1.9+0.1));
                float2 node_1997 = ((node_35*0.2)+node_8871.g*float2(0.05,0.05));
                float4 node_8257 = tex2D(_Caustics,TRANSFORM_TEX(node_1997, _Caustics));
                float2 node_2248 = ((node_35*0.25)+node_8871.g*float2(-0.04,-0.06));
                float4 node_5596 = tex2D(_Caustics,TRANSFORM_TEX(node_2248, _Caustics));
                float2 node_268 = ((node_35*0.18)+node_8871.g*float2(0.04,-0.06));
                float4 node_6093 = tex2D(_Caustics,TRANSFORM_TEX(node_268, _Caustics));
                float2 node_1726 = ((node_35*0.14)+node_8871.g*float2(-0.06,0.03));
                float4 node_8399 = tex2D(_Caustics,TRANSFORM_TEX(node_1726, _Caustics));
                float3 node_4191 = saturate(((_CausticColor.rgb*saturate(((node_8257.rgb+node_5596.rgb)+(node_6093.rgb+node_8399.rgb))))+_WaterColor.rgb));
                o.Emission = node_4191;
                
                float3 diffColor = node_4191;
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
