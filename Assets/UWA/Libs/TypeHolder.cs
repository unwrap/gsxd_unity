#pragma warning disable
using System.Collections.Generic;
using UnityEngine;
#if UNITY_5_5_OR_NEWER
using UnityEngine.Profiling;
#endif

namespace Assets.UWA
{
    public class TypeHolder {

        public static readonly TypeHolder Instance = new TypeHolder();
        private TypeHolder() { }

        // This code is used for holding types and methods, and will never be called. 
        public void Hold()
        {
            Resources.Load("");
            Resources.UnloadAsset(new Object());
            Resources.UnloadUnusedAssets();
            Resources.LoadAll("");

            GameObject go = null;
            AssetBundle ab = null;
            Animator at = null;
            Animation an = null;
            ParticleSystem ps = null;
            TextAsset ta = null;
            Mesh m = null;
            Shader s = null;
            Texture t = null;
            Texture2D t2 = null;
            RenderTexture rt = null;
            AnimationClip ac = null;
            AudioClip ac2 = null;
            SkinnedMeshRenderer r = null;
            Font f = null;

#if UNITY_2019_1_OR_NEWER
            Check(QualitySettings.skinWeights);
#else
            Check(QualitySettings.blendWeights);
#endif

#if UNITY_2018_3_OR_NEWER
            Profiler.SetAreaEnabled(ProfilerArea.CPU, false);
#endif

#if !UNITY_4_7 && !UNITY_4_6
            Cursor.lockState = CursorLockMode.None;
            Check(Cursor.lockState);
#endif

#if UNITY_5_3_OR_NEWER
            Check(SystemInfo.processorFrequency);
#endif

#if UNITY_4_6 || UNITY_4_7 || UNITY_5 
            t2.LoadImage(null);
#else
            ImageConversion.LoadImage(t2, null);
#endif

#if UNITY_5_6_OR_NEWER
            List<string> temp = new List<string>();
            Sampler.GetNames(temp);
            Sampler sampler = Sampler.Get("");
            Check(sampler.isValid);
            Check(sampler.name);
            Recorder recorder = Recorder.Get("");
            recorder.enabled = true;
            Check(recorder.isValid);
            Check(recorder.enabled);
            Check(recorder.sampleBlockCount);
            Check(recorder.elapsedNanoseconds);
#endif

            Profiler.BeginSample("", new Object());
            Profiler.BeginSample("");
            Profiler.EndSample();
            Profiler.GetRuntimeMemorySize(null);
            Profiler.GetTotalAllocatedMemory();
            Profiler.GetTotalReservedMemory();
            Profiler.GetTotalUnusedReservedMemory();
            Profiler.GetMonoUsedSize();
            Profiler.GetMonoHeapSize();
            Profiler.enableBinaryLog = true;
            Profiler.enabled = true;
            Profiler.logFile = "";
            Check(Profiler.usedHeapSize);
            Check(Profiler.enableBinaryLog);
            Check(Profiler.enabled);
            Check(Profiler.logFile);
            Check(Profiler.supported);
            Check(f.fontSize);
            Check(t2.mipmapCount);
        }

        void Check(object o) { }
    }
}
#pragma warning restore