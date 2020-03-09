// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:35993,y:32233,varname:node_4013,prsc:2|diff-9584-RGB,spec-9489-OUT,gloss-5606-OUT,normal-8790-OUT,emission-5591-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:9718,x:34157,y:32796,ptovrint:False,ptlb:Caustics,ptin:_Caustics,varname:node_9718,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:6617,x:34620,y:32666,varname:node_6617,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-1224-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:5110,x:34602,y:32835,varname:node_5110,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-2577-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Panner,id:1224,x:33970,y:32664,varname:node_1224,prsc:2,spu:-0.015,spv:0.015|UVIN-2219-OUT;n:type:ShaderForge.SFN_Panner,id:2577,x:33970,y:32862,varname:node_2577,prsc:2,spu:0.015,spv:-0.015|UVIN-5282-OUT;n:type:ShaderForge.SFN_Vector1,id:387,x:33529,y:33095,varname:node_387,prsc:2,v1:0.7;n:type:ShaderForge.SFN_Multiply,id:4308,x:33775,y:33023,varname:node_4308,prsc:2|A-2219-OUT,B-387-OUT;n:type:ShaderForge.SFN_Multiply,id:360,x:33762,y:33228,varname:node_360,prsc:2|A-2219-OUT,B-4521-OUT;n:type:ShaderForge.SFN_Tex2d,id:2270,x:34602,y:32990,varname:node_2270,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-3255-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:8449,x:34602,y:33127,varname:node_8449,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-4113-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Panner,id:3255,x:33970,y:33042,varname:node_3255,prsc:2,spu:0.015,spv:0.015|UVIN-4308-OUT;n:type:ShaderForge.SFN_Vector1,id:4521,x:33514,y:33262,varname:node_4521,prsc:2,v1:1.2;n:type:ShaderForge.SFN_Panner,id:4113,x:33976,y:33252,varname:node_4113,prsc:2,spu:-0.015,spv:-0.015|UVIN-360-OUT;n:type:ShaderForge.SFN_Multiply,id:5282,x:33775,y:32842,varname:node_5282,prsc:2|A-2219-OUT,B-5504-OUT;n:type:ShaderForge.SFN_Vector1,id:5504,x:33529,y:32983,varname:node_5504,prsc:2,v1:0.85;n:type:ShaderForge.SFN_Add,id:8689,x:34953,y:32822,varname:node_8689,prsc:2|A-6617-R,B-5110-R;n:type:ShaderForge.SFN_Add,id:206,x:34953,y:33023,varname:node_206,prsc:2|A-8449-R,B-8449-G;n:type:ShaderForge.SFN_FragmentPosition,id:4192,x:32903,y:32512,varname:node_4192,prsc:2;n:type:ShaderForge.SFN_Append,id:6407,x:33199,y:32730,varname:node_6407,prsc:2|A-4192-X,B-4192-Z;n:type:ShaderForge.SFN_Multiply,id:2219,x:33411,y:32790,varname:node_2219,prsc:2|A-6407-OUT,B-9962-OUT;n:type:ShaderForge.SFN_Vector1,id:9962,x:33263,y:32954,varname:node_9962,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Add,id:6187,x:35242,y:32871,varname:node_6187,prsc:2|A-8689-OUT,B-206-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:7183,x:34302,y:33528,ptovrint:False,ptlb:Normal1,ptin:_Normal1,varname:node_7183,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d60dabca6ca21c94dbf8c389df6fb5ee,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:6478,x:34581,y:33308,varname:node_6478,prsc:2,tex:d60dabca6ca21c94dbf8c389df6fb5ee,ntxv:0,isnm:False|UVIN-1224-UVOUT,TEX-7183-TEX;n:type:ShaderForge.SFN_Tex2d,id:7840,x:34581,y:33473,varname:node_7840,prsc:2,tex:d60dabca6ca21c94dbf8c389df6fb5ee,ntxv:0,isnm:False|UVIN-2577-UVOUT,TEX-7183-TEX;n:type:ShaderForge.SFN_Tex2d,id:2011,x:34581,y:33641,varname:node_2011,prsc:2,tex:d60dabca6ca21c94dbf8c389df6fb5ee,ntxv:0,isnm:False|UVIN-3255-UVOUT,TEX-7183-TEX;n:type:ShaderForge.SFN_Tex2d,id:7298,x:34581,y:33819,varname:node_7298,prsc:2,tex:d60dabca6ca21c94dbf8c389df6fb5ee,ntxv:0,isnm:False|UVIN-4113-UVOUT,TEX-7183-TEX;n:type:ShaderForge.SFN_NormalBlend,id:526,x:34943,y:33723,varname:node_526,prsc:2|BSE-2011-RGB,DTL-7298-RGB;n:type:ShaderForge.SFN_NormalBlend,id:9296,x:35199,y:33522,varname:node_9296,prsc:2|BSE-6709-OUT,DTL-526-OUT;n:type:ShaderForge.SFN_NormalBlend,id:6709,x:34942,y:33384,varname:node_6709,prsc:2|BSE-6478-RGB,DTL-7840-RGB;n:type:ShaderForge.SFN_Append,id:4699,x:33487,y:32087,varname:node_4699,prsc:2|A-4192-Z,B-4192-Y;n:type:ShaderForge.SFN_Append,id:7401,x:33288,y:32281,varname:node_7401,prsc:2|A-4192-X,B-4192-Y;n:type:ShaderForge.SFN_Panner,id:2584,x:34011,y:31867,varname:node_2584,prsc:2,spu:0.01,spv:-0.06|UVIN-4699-OUT;n:type:ShaderForge.SFN_Panner,id:4762,x:34057,y:32313,varname:node_4762,prsc:2,spu:0.01,spv:-0.06|UVIN-3950-OUT;n:type:ShaderForge.SFN_Tex2d,id:3378,x:34542,y:31807,varname:node_3378,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-2584-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:7282,x:34527,y:31951,varname:node_7282,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-3543-OUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:3608,x:34538,y:32246,varname:node_3608,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-4762-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:7181,x:34539,y:32418,varname:node_7181,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-1433-OUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Panner,id:4608,x:34011,y:32013,varname:node_4608,prsc:2,spu:-0.01,spv:-0.1|UVIN-4699-OUT;n:type:ShaderForge.SFN_Panner,id:2731,x:34057,y:32458,varname:node_2731,prsc:2,spu:-0.01,spv:-0.1|UVIN-3950-OUT;n:type:ShaderForge.SFN_Add,id:5149,x:34751,y:31923,varname:node_5149,prsc:2|A-3378-B,B-7282-A;n:type:ShaderForge.SFN_Add,id:1029,x:34782,y:32333,varname:node_1029,prsc:2|A-3608-B,B-7181-A;n:type:ShaderForge.SFN_NormalVector,id:5794,x:33896,y:31544,prsc:2,pt:True;n:type:ShaderForge.SFN_Abs,id:8650,x:34107,y:31575,varname:node_8650,prsc:2|IN-5794-OUT;n:type:ShaderForge.SFN_Multiply,id:6318,x:34410,y:31561,varname:node_6318,prsc:2|A-8650-OUT,B-8650-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:5169,x:35283,y:32124,varname:node_5169,prsc:2,chbt:0|M-6318-OUT,R-9238-OUT,G-6187-OUT,B-1463-OUT;n:type:ShaderForge.SFN_Multiply,id:3543,x:34233,y:31933,varname:node_3543,prsc:2|A-4608-UVOUT,B-5185-OUT;n:type:ShaderForge.SFN_Multiply,id:1433,x:34281,y:32446,varname:node_1433,prsc:2|A-2731-UVOUT,B-5185-OUT;n:type:ShaderForge.SFN_Vector1,id:5185,x:33724,y:32430,varname:node_5185,prsc:2,v1:0.7;n:type:ShaderForge.SFN_Add,id:3950,x:33452,y:32319,varname:node_3950,prsc:2|A-7401-OUT,B-9439-OUT;n:type:ShaderForge.SFN_Vector1,id:9439,x:33275,y:32449,varname:node_9439,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Lerp,id:5591,x:35647,y:32116,varname:node_5591,prsc:2|A-190-RGB,B-4942-RGB,T-5169-OUT;n:type:ShaderForge.SFN_Color,id:190,x:35164,y:31846,ptovrint:False,ptlb:Waters,ptin:_Waters,varname:node_190,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4452854,c2:0.5999135,c3:0.8529412,c4:1;n:type:ShaderForge.SFN_Color,id:4942,x:35343,y:31964,ptovrint:False,ptlb:Boobles,ptin:_Boobles,varname:node_4942,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7132353,c2:0.9525355,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:9489,x:35305,y:32291,ptovrint:False,ptlb:Specular,ptin:_Specular,varname:node_9489,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:5606,x:35305,y:32379,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_5606,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:9238,x:34970,y:31856,varname:node_9238,prsc:2|A-2497-G,B-5149-OUT;n:type:ShaderForge.SFN_Add,id:1463,x:34990,y:32266,varname:node_1463,prsc:2|A-3056-G,B-1029-OUT;n:type:ShaderForge.SFN_Tex2d,id:3056,x:34539,y:32103,varname:node_3056,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-665-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Tex2d,id:2497,x:34542,y:31664,varname:node_2497,prsc:2,tex:7df355da0863db146a7e3933c504bb01,ntxv:0,isnm:False|UVIN-1529-UVOUT,TEX-9718-TEX;n:type:ShaderForge.SFN_Panner,id:1529,x:34011,y:31730,varname:node_1529,prsc:2,spu:0,spv:-0.2|UVIN-4699-OUT;n:type:ShaderForge.SFN_Panner,id:665,x:34057,y:32173,varname:node_665,prsc:2,spu:0,spv:-0.2|UVIN-3950-OUT;n:type:ShaderForge.SFN_Color,id:9584,x:35679,y:32429,ptovrint:False,ptlb:Base Color,ptin:_BaseColor,varname:node_9584,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_NormalVector,id:7174,x:34796,y:33177,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:6597,x:34971,y:33177,varname:node_6597,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-7174-OUT;n:type:ShaderForge.SFN_Clamp01,id:740,x:35151,y:33187,varname:node_740,prsc:2|IN-6597-OUT;n:type:ShaderForge.SFN_Round,id:5365,x:35314,y:33187,varname:node_5365,prsc:2|IN-740-OUT;n:type:ShaderForge.SFN_Lerp,id:8790,x:35593,y:33302,varname:node_8790,prsc:2|A-2658-OUT,B-9296-OUT,T-5365-OUT;n:type:ShaderForge.SFN_Vector3,id:2658,x:35247,y:33373,varname:node_2658,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Vector3,id:6321,x:34957,y:32149,varname:node_6321,prsc:2,v1:0,v2:0,v3:0;proporder:9718-7183-190-4942-9489-5606-9584;pass:END;sub:END;*/

Shader "MK4/Tiles_Water" {
    Properties {
        _Caustics ("Caustics", 2D) = "white" {}
        _Normal1 ("Normal1", 2D) = "bump" {}
        _Waters ("Waters", Color) = (0.4452854,0.5999135,0.8529412,1)
        _Boobles ("Boobles", Color) = (0.7132353,0.9525355,1,1)
        _Specular ("Specular", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0
        _BaseColor ("Base Color", Color) = (0.5,0.5,0.5,1)
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _Caustics; uniform float4 _Caustics_ST;
            uniform sampler2D _Normal1; uniform float4 _Normal1_ST;
            uniform float4 _Waters;
            uniform float4 _Boobles;
            uniform float _Specular;
            uniform float _Gloss;
            uniform float4 _BaseColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                float4 node_1350 = _Time + _TimeEditor;
                float2 node_2219 = (float2(i.posWorld.r,i.posWorld.b)*0.2);
                float2 node_1224 = (node_2219+node_1350.g*float2(-0.015,0.015));
                float3 node_6478 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_1224, _Normal1)));
                float2 node_2577 = ((node_2219*0.85)+node_1350.g*float2(0.015,-0.015));
                float3 node_7840 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_2577, _Normal1)));
                float3 node_6709_nrm_base = node_6478.rgb + float3(0,0,1);
                float3 node_6709_nrm_detail = node_7840.rgb * float3(-1,-1,1);
                float3 node_6709_nrm_combined = node_6709_nrm_base*dot(node_6709_nrm_base, node_6709_nrm_detail)/node_6709_nrm_base.z - node_6709_nrm_detail;
                float3 node_6709 = node_6709_nrm_combined;
                float2 node_3255 = ((node_2219*0.7)+node_1350.g*float2(0.015,0.015));
                float3 node_2011 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_3255, _Normal1)));
                float2 node_4113 = ((node_2219*1.2)+node_1350.g*float2(-0.015,-0.015));
                float3 node_7298 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_4113, _Normal1)));
                float3 node_526_nrm_base = node_2011.rgb + float3(0,0,1);
                float3 node_526_nrm_detail = node_7298.rgb * float3(-1,-1,1);
                float3 node_526_nrm_combined = node_526_nrm_base*dot(node_526_nrm_base, node_526_nrm_detail)/node_526_nrm_base.z - node_526_nrm_detail;
                float3 node_526 = node_526_nrm_combined;
                float3 node_9296_nrm_base = node_6709 + float3(0,0,1);
                float3 node_9296_nrm_detail = node_526 * float3(-1,-1,1);
                float3 node_9296_nrm_combined = node_9296_nrm_base*dot(node_9296_nrm_base, node_9296_nrm_detail)/node_9296_nrm_base.z - node_9296_nrm_detail;
                float3 node_9296 = node_9296_nrm_combined;
                float3 normalLocal = lerp(float3(0,0,1),node_9296,round(saturate(i.normalDir.g)));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float3 diffuseColor = _BaseColor.rgb;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 node_8650 = abs(normalDirection);
                float3 node_6318 = (node_8650*node_8650);
                float2 node_4699 = float2(i.posWorld.b,i.posWorld.g);
                float2 node_1529 = (node_4699+node_1350.g*float2(0,-0.2));
                float4 node_2497 = tex2D(_Caustics,TRANSFORM_TEX(node_1529, _Caustics));
                float2 node_2584 = (node_4699+node_1350.g*float2(0.01,-0.06));
                float4 node_3378 = tex2D(_Caustics,TRANSFORM_TEX(node_2584, _Caustics));
                float node_5185 = 0.7;
                float2 node_3543 = ((node_4699+node_1350.g*float2(-0.01,-0.1))*node_5185);
                float4 node_7282 = tex2D(_Caustics,TRANSFORM_TEX(node_3543, _Caustics));
                float4 node_6617 = tex2D(_Caustics,TRANSFORM_TEX(node_1224, _Caustics));
                float4 node_5110 = tex2D(_Caustics,TRANSFORM_TEX(node_2577, _Caustics));
                float4 node_8449 = tex2D(_Caustics,TRANSFORM_TEX(node_4113, _Caustics));
                float2 node_3950 = (float2(i.posWorld.r,i.posWorld.g)+0.5);
                float2 node_665 = (node_3950+node_1350.g*float2(0,-0.2));
                float4 node_3056 = tex2D(_Caustics,TRANSFORM_TEX(node_665, _Caustics));
                float2 node_4762 = (node_3950+node_1350.g*float2(0.01,-0.06));
                float4 node_3608 = tex2D(_Caustics,TRANSFORM_TEX(node_4762, _Caustics));
                float2 node_1433 = ((node_3950+node_1350.g*float2(-0.01,-0.1))*node_5185);
                float4 node_7181 = tex2D(_Caustics,TRANSFORM_TEX(node_1433, _Caustics));
                float3 emissive = lerp(_Waters.rgb,_Boobles.rgb,(node_6318.r*(node_2497.g+(node_3378.b+node_7282.a)) + node_6318.g*((node_6617.r+node_5110.r)+(node_8449.r+node_8449.g)) + node_6318.b*(node_3056.g+(node_3608.b+node_7181.a))));
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _Caustics; uniform float4 _Caustics_ST;
            uniform sampler2D _Normal1; uniform float4 _Normal1_ST;
            uniform float4 _Waters;
            uniform float4 _Boobles;
            uniform float _Specular;
            uniform float _Gloss;
            uniform float4 _BaseColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                float4 node_1178 = _Time + _TimeEditor;
                float2 node_2219 = (float2(i.posWorld.r,i.posWorld.b)*0.2);
                float2 node_1224 = (node_2219+node_1178.g*float2(-0.015,0.015));
                float3 node_6478 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_1224, _Normal1)));
                float2 node_2577 = ((node_2219*0.85)+node_1178.g*float2(0.015,-0.015));
                float3 node_7840 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_2577, _Normal1)));
                float3 node_6709_nrm_base = node_6478.rgb + float3(0,0,1);
                float3 node_6709_nrm_detail = node_7840.rgb * float3(-1,-1,1);
                float3 node_6709_nrm_combined = node_6709_nrm_base*dot(node_6709_nrm_base, node_6709_nrm_detail)/node_6709_nrm_base.z - node_6709_nrm_detail;
                float3 node_6709 = node_6709_nrm_combined;
                float2 node_3255 = ((node_2219*0.7)+node_1178.g*float2(0.015,0.015));
                float3 node_2011 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_3255, _Normal1)));
                float2 node_4113 = ((node_2219*1.2)+node_1178.g*float2(-0.015,-0.015));
                float3 node_7298 = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_4113, _Normal1)));
                float3 node_526_nrm_base = node_2011.rgb + float3(0,0,1);
                float3 node_526_nrm_detail = node_7298.rgb * float3(-1,-1,1);
                float3 node_526_nrm_combined = node_526_nrm_base*dot(node_526_nrm_base, node_526_nrm_detail)/node_526_nrm_base.z - node_526_nrm_detail;
                float3 node_526 = node_526_nrm_combined;
                float3 node_9296_nrm_base = node_6709 + float3(0,0,1);
                float3 node_9296_nrm_detail = node_526 * float3(-1,-1,1);
                float3 node_9296_nrm_combined = node_9296_nrm_base*dot(node_9296_nrm_base, node_9296_nrm_detail)/node_9296_nrm_base.z - node_9296_nrm_detail;
                float3 node_9296 = node_9296_nrm_combined;
                float3 normalLocal = lerp(float3(0,0,1),node_9296,round(saturate(i.normalDir.g)));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float3 specularColor = float3(_Specular,_Specular,_Specular);
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 diffuseColor = _BaseColor.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
