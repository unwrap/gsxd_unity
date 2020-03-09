// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:2,cusa:False,bamd:0,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:0,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3554,x:33003,y:32987,varname:node_3554,prsc:2|emission-7568-OUT;n:type:ShaderForge.SFN_Color,id:8306,x:31772,y:32693,ptovrint:False,ptlb:Sky Color,ptin:_SkyColor,varname:node_8306,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.02553246,c2:0.03709318,c3:0.1827586,c4:1;n:type:ShaderForge.SFN_ViewVector,id:2265,x:31161,y:32799,varname:node_2265,prsc:2;n:type:ShaderForge.SFN_Dot,id:7606,x:31418,y:32953,varname:node_7606,prsc:2,dt:1|A-2265-OUT,B-3211-OUT;n:type:ShaderForge.SFN_Vector3,id:3211,x:31161,y:32997,varname:node_3211,prsc:2,v1:0,v2:-1,v3:0;n:type:ShaderForge.SFN_Color,id:3839,x:31772,y:32848,ptovrint:False,ptlb:Ground Color,ptin:_GroundColor,varname:_GroundColor_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.06617647,c2:0.5468207,c3:1,c4:1;n:type:ShaderForge.SFN_Power,id:4050,x:31772,y:32995,varname:node_4050,prsc:2|VAL-6125-OUT,EXP-8344-OUT;n:type:ShaderForge.SFN_OneMinus,id:6125,x:31587,y:32953,varname:node_6125,prsc:2|IN-7606-OUT;n:type:ShaderForge.SFN_Lerp,id:2737,x:31999,y:32869,cmnt:Sky,varname:node_2737,prsc:2|A-8306-RGB,B-3839-RGB,T-4050-OUT;n:type:ShaderForge.SFN_LightVector,id:3559,x:30723,y:33040,cmnt:Auto-adapts to your directional light,varname:node_3559,prsc:2;n:type:ShaderForge.SFN_Dot,id:1472,x:31082,y:33150,cmnt:Linear falloff to sun angle,varname:node_1472,prsc:2,dt:1|A-8269-OUT,B-8750-OUT;n:type:ShaderForge.SFN_ViewVector,id:8750,x:30895,y:33160,varname:node_8750,prsc:2;n:type:ShaderForge.SFN_Add,id:7568,x:32559,y:33022,cmnt:Sky plus Sun,varname:node_7568,prsc:2|A-7330-OUT,B-5855-OUT;n:type:ShaderForge.SFN_Negate,id:8269,x:30895,y:33040,varname:node_8269,prsc:2|IN-3559-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:3001,x:31383,y:33282,cmnt:Modify radius of falloff,varname:node_3001,prsc:2|IN-1472-OUT,IMIN-1476-OUT,IMAX-1574-OUT,OMIN-9430-OUT,OMAX-6262-OUT;n:type:ShaderForge.SFN_Slider,id:2435,x:30320,y:33466,ptovrint:False,ptlb:Sun Radius B,ptin:_SunRadiusB,varname:node_2435,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:0.1;n:type:ShaderForge.SFN_Slider,id:3144,x:30320,y:33360,ptovrint:False,ptlb:Sun Radius A,ptin:_SunRadiusA,varname:_SunOuterRadius_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.1;n:type:ShaderForge.SFN_Vector1,id:9430,x:31082,y:33610,varname:node_9430,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:6262,x:31082,y:33668,varname:node_6262,prsc:2,v1:0;n:type:ShaderForge.SFN_Clamp01,id:7022,x:31556,y:33282,varname:node_7022,prsc:2|IN-3001-OUT;n:type:ShaderForge.SFN_OneMinus,id:1574,x:31082,y:33464,varname:node_1574,prsc:2|IN-8889-OUT;n:type:ShaderForge.SFN_OneMinus,id:1476,x:31082,y:33315,varname:node_1476,prsc:2|IN-3432-OUT;n:type:ShaderForge.SFN_Multiply,id:8889,x:30893,y:33464,varname:node_8889,prsc:2|A-9367-OUT,B-9367-OUT;n:type:ShaderForge.SFN_Multiply,id:3432,x:30893,y:33315,varname:node_3432,prsc:2|A-7933-OUT,B-7933-OUT;n:type:ShaderForge.SFN_Max,id:9367,x:30681,y:33464,varname:node_9367,prsc:2|A-3144-OUT,B-2435-OUT;n:type:ShaderForge.SFN_Min,id:7933,x:30681,y:33315,varname:node_7933,prsc:2|A-3144-OUT,B-2435-OUT;n:type:ShaderForge.SFN_Power,id:754,x:31772,y:33336,varname:node_754,prsc:2|VAL-7022-OUT,EXP-5929-OUT;n:type:ShaderForge.SFN_Vector1,id:5929,x:31556,y:33412,varname:node_5929,prsc:2,v1:5;n:type:ShaderForge.SFN_Multiply,id:5855,x:31957,y:33257,cmnt:Sun,varname:node_5855,prsc:2|A-2359-RGB,B-754-OUT,C-7055-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7055,x:31772,y:33484,ptovrint:False,ptlb:Sun Intensity,ptin:_SunIntensity,varname:node_7055,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_LightColor,id:2359,x:31772,y:33210,cmnt:Get color from directional light,varname:node_2359,prsc:2;n:type:ShaderForge.SFN_Dot,id:2800,x:31673,y:32365,varname:node_2800,prsc:2,dt:3|A-2265-OUT,B-3211-OUT;n:type:ShaderForge.SFN_OneMinus,id:1679,x:31863,y:32416,varname:node_1679,prsc:2|IN-2800-OUT;n:type:ShaderForge.SFN_Power,id:4074,x:32038,y:32448,varname:node_4074,prsc:2|VAL-1679-OUT,EXP-186-OUT;n:type:ShaderForge.SFN_Lerp,id:5812,x:32175,y:32786,varname:node_5812,prsc:2|A-2737-OUT,B-5260-RGB,T-4074-OUT;n:type:ShaderForge.SFN_Color,id:5260,x:31944,y:32683,ptovrint:False,ptlb:Horizon,ptin:_Horizon,varname:node_5260,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6838235,c2:0.9738336,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:186,x:31498,y:32535,ptovrint:False,ptlb:Horizon2 Size,ptin:_Horizon2Size,varname:node_186,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.755868,max:8;n:type:ShaderForge.SFN_Slider,id:8344,x:31399,y:33162,ptovrint:False,ptlb:Horion1 Size,ptin:_Horion1Size,varname:node_8344,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:8,max:8;n:type:ShaderForge.SFN_RemapRange,id:9844,x:32233,y:32379,varname:node_9844,prsc:2,frmn:0,frmx:1.5,tomn:-1,tomx:1|IN-909-OUT;n:type:ShaderForge.SFN_RemapRange,id:4699,x:32412,y:32379,varname:node_4699,prsc:2,frmn:0,frmx:1,tomn:0.1,tomx:5|IN-9844-OUT;n:type:ShaderForge.SFN_ConstantClamp,id:4508,x:32590,y:32423,varname:node_4508,prsc:2,min:0,max:1|IN-4699-OUT;n:type:ShaderForge.SFN_Color,id:6512,x:32336,y:32620,ptovrint:False,ptlb:Sky up,ptin:_Skyup,varname:node_6512,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.1332658,c3:0.2647059,c4:1;n:type:ShaderForge.SFN_Lerp,id:7330,x:32535,y:32792,varname:node_7330,prsc:2|A-5812-OUT,B-6512-RGB,T-4508-OUT;n:type:ShaderForge.SFN_Dot,id:909,x:31698,y:32212,varname:node_909,prsc:2,dt:4|A-2265-OUT,B-3211-OUT;proporder:8306-3839-2435-3144-7055-5260-186-8344-6512;pass:END;sub:END;*/

Shader "MK4/Mobile/Sky" {
    Properties {
        _SkyColor ("Sky Color", Color) = (0.02553246,0.03709318,0.1827586,1)
        _GroundColor ("Ground Color", Color) = (0.06617647,0.5468207,1,1)
        _SunRadiusB ("Sun Radius B", Range(0, 0.1)) = 0.1
        _SunRadiusA ("Sun Radius A", Range(0, 0.1)) = 0
        _SunIntensity ("Sun Intensity", Float ) = 2
        _Horizon ("Horizon", Color) = (0.6838235,0.9738336,1,1)
        _Horizon2Size ("Horizon2 Size", Range(0, 8)) = 1.755868
        _Horion1Size ("Horion1 Size", Range(0, 8)) = 8
        _Skyup ("Sky up", Color) = (0,0.1332658,0.2647059,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Background"
            "RenderType"="Opaque"
            "PreviewType"="Skybox"
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
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers gles3 xbox360 xboxone ps3 ps4 psp2 
            #pragma target 2.0
            uniform float4 _LightColor0;
            uniform float4 _SkyColor;
            uniform float4 _GroundColor;
            uniform float _SunRadiusB;
            uniform float _SunRadiusA;
            uniform float _SunIntensity;
            uniform float4 _Horizon;
            uniform float _Horizon2Size;
            uniform float _Horion1Size;
            uniform float4 _Skyup;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
////// Emissive:
                float3 node_3211 = float3(0,-1,0);
                float node_7933 = min(_SunRadiusA,_SunRadiusB);
                float node_1476 = (1.0 - (node_7933*node_7933));
                float node_9367 = max(_SunRadiusA,_SunRadiusB);
                float node_9430 = 1.0;
                float3 emissive = (lerp(lerp(lerp(_SkyColor.rgb,_GroundColor.rgb,pow((1.0 - max(0,dot(viewDirection,node_3211))),_Horion1Size)),_Horizon.rgb,pow((1.0 - abs(dot(viewDirection,node_3211))),_Horizon2Size)),_Skyup.rgb,clamp(((0.5*dot(viewDirection,node_3211)+0.5*1.333333+-1.0)*4.9+0.1),0,1))+(_LightColor0.rgb*pow(saturate((node_9430 + ( (max(0,dot((-1*lightDirection),viewDirection)) - node_1476) * (0.0 - node_9430) ) / ((1.0 - (node_9367*node_9367)) - node_1476))),5.0)*_SunIntensity));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
