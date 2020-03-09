using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace taecg.tools.mobileFastShadow
{
    [ExecuteInEditMode]
    public class ShadowShaderReplacement : MonoBehaviour
    {
        public Shader replacementShader;
        private Camera mCam;

        void OnEnable()
        {
            mCam = GetComponent<Camera>();
            if (replacementShader != null)
            {
                mCam.SetReplacementShader(replacementShader, "RenderType");
            }
        }
        void OnDisable()
        {
            mCam.ResetReplacementShader();
        }
    }
}