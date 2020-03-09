// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Projector' with 'unity_Projector'

Shader "Taecg/Projector/ProjectorShadow" 
{
	Properties 
	{
		_Color("Color",Color) = (0,0,0,1)
		_ShadowTex ("Shadow Texture", 2D) = "gray" {}
		_FalloffTex ("Falloff Texture",2D) = "white"{}
		_Intensity ("Intensity",Range(0,1))=0.5
	}

	SubShader 
	{
		Tags { "Queue"="AlphaTest+1" }

		Pass 
		{
			ZWrite Off
			ColorMask RGB
			Blend DstColor Zero
			Offset -1, -1

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#include "UnityCG.cginc"

			struct v2f 
			{
				float4 pos : SV_POSITION;
				float4 sproj : TEXCOORD0;
				UNITY_FOG_COORDS(1)
			};

			float4x4 unity_Projector;
			sampler2D _ShadowTex;
			sampler2D _FalloffTex;
			float _Intensity;
			fixed4 _Color;

			v2f vert(float4 vertex : POSITION)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(vertex);
				o.sproj = mul(unity_Projector, vertex);
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}

			float4 frag(v2f i):SV_TARGET
			{
				fixed4 _ShadowTex_var = tex2Dproj(_ShadowTex, UNITY_PROJ_COORD(i.sproj));
				fixed maskCol = tex2Dproj(_FalloffTex, UNITY_PROJ_COORD(i.sproj)).r;
				fixed4 col = 1 - _ShadowTex_var.r * maskCol * _Intensity * (1-_Color);

				UNITY_APPLY_FOG_COLOR(i.fogCoord, col, fixed4(1,1,1,1));

				return col;
			}

			ENDCG
		}
	} 
}
