using System;
using System.Collections.Generic;
using UnityEngine;

namespace taecg.tools.mobileFastShadow
{
    [RequireComponent (typeof (Camera))]
    [RequireComponent (typeof (Projector))]
    [RequireComponent (typeof (ShadowShaderReplacement))]
    public class MobileFastShadow : MonoBehaviour
    {
        [Header ("v1.06")]
        // [Header("Follow Target")]
        public GameObject FollowTarget;

        [Header ("Shadow Layer")]
        [Tooltip (" It is used to identify which objects need to cast shadows.")]
        public LayerMask LayerCaster;
        [Tooltip ("It is used to identify which objects need to receive shadows.")]
        public LayerMask LayerIgnoreReceiver;

        public enum AntiAliasing
        {
            None = 1, Samples2 = 2, Samples4 = 4, Samples8 = 8,
        }

        [Header ("Shadow Detail (In Editor Mode)")]
        [Tooltip ("The size of the generated RenderTexture. ")]
        public Vector2 Size = new Vector2 (1024, 1024);
        [Tooltip ("Shaded sampling, if you want to make the edge as smooth as possible to choose a higher sample, the same performance will decline.")]
        public AntiAliasing RTAntiAliasing = AntiAliasing.None;
        public Color Color = Color.black;
        [Tooltip (" In order to prevent the shadow of the RenderTarget edge from stretching, it is necessary to use a kind of transition picture to deal with it so that it is more natural.")]
        public Texture2D FalloffTex;
        [Range (0, 1)]
        [Tooltip ("It is used to adjust the transparency of shadow.")]
        public float Intensity = 0.5f;

        [Header ("Shadow Direction (Runtime)")]
        [Tooltip ("To adjust the direction of the shadow.")]
        //public Vector3 Direction = new Vector3 (50, -30, 20);
        public Vector3 Direction = new Vector3(50, -210, -20);

        [Header ("Projection Orthographic Size (In Editor Mode)")]
        [Tooltip ("The bigger the value, the more objects will be shadowed. It can solve the problem of blurred shadows within the same screen, but the excessive value will also cause the quality of the shadow to drop, so find a suitable balance for you. In order to maximize efficiency, there is no support for adjusting Size of Projector and camera at runtime, and these two values will be initialized after running, so this value can be used to adjust initialization value.")]
        public float ProjectionSize = 10;

        private Camera shadowCam;
        private Transform shadowCamTrans;
        private Projector projector;

        private Material shadowMat;
        private RenderTexture shadowRT;

        void Awake ()
        {
            //指定跟随相机
            if (FollowTarget == null)
            {
                Debug.LogWarning ("Please specify the target to follow！");
            }

            //projector初始化
            projector = GetComponent<Projector> ();
            if (projector == null)
                Debug.LogError ("Projector Component Missing!!");
            projector.orthographic = true;
            projector.orthographicSize = ProjectionSize;
            projector.aspectRatio = Size.x / Size.y;
            Shader sd = AssetBundleManager.LoadAsset("shader.u3d", "ProjectorShadow", typeof(Shader)) as Shader;
            //Shader.Find ("Taecg/Projector/ProjectorShadow")
            shadowMat = new Material (sd);
            projector.material = shadowMat;
            shadowMat.SetColor ("_Color", Color);
            shadowMat.SetTexture ("_FalloffTex", FalloffTex);
            shadowMat.SetFloat ("_Intensity", Intensity);
            projector.ignoreLayers = LayerIgnoreReceiver;

            //camera初始化
            shadowCam = GetComponent<Camera> ();
            if (shadowCam == null)
                Debug.LogError ("Camera Component Missing!!");
            shadowCamTrans = shadowCam.transform;
            shadowCam.clearFlags = CameraClearFlags.SolidColor;
            shadowCam.backgroundColor = new Color (0, 0, 0, 0);
            shadowCam.orthographic = true;
            shadowCam.orthographicSize = ProjectionSize;
            shadowCam.depth = int.MinValue;
            shadowCam.cullingMask = LayerCaster;
            shadowRT = new RenderTexture ((int) Size.x, (int) Size.y, 0, RenderTextureFormat.R8);
            shadowRT.name = "ShadowRT";
            shadowRT.antiAliasing = (int) RTAntiAliasing;
            shadowRT.filterMode = FilterMode.Bilinear;
            shadowRT.wrapMode = TextureWrapMode.Clamp;
            shadowCam.targetTexture = shadowRT;
            shadowMat.SetTexture ("_ShadowTex", shadowRT);
        }

        //实时调节相关参数
        private void LateUpdate ()
        {
            if (FollowTarget == null) return;

            Vector3 pos = transform.forward;
            pos *= Direction.z;
            transform.position = FollowTarget.transform.position + pos;

            shadowCamTrans.rotation = Quaternion.Euler (Direction);
            //shadowCamTrans.SetPositionAndRotation(_pos,Quaternion.Euler(ShadowCamRotation));
        }
    }
}