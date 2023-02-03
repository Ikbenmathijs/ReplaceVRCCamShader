Shader "Unlit/ReplaceCamera"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Cull Off
            ZTest Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                float4 screenPosition : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _VRChatCameraMode;

            v2f vert (appdata v)
            {
                v2f o;
                o.position = UnityObjectToClipPos(v.vertex);
                o.screenPosition = ComputeScreenPos(o.position);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                if (_VRChatCameraMode == 0) discard;
                float2 textureCoordinate = i.screenPosition / i.screenPosition.w;
                fixed4 col = tex2D(_MainTex, textureCoordinate);
                return col;
            }
            ENDCG
        }
    }
}
