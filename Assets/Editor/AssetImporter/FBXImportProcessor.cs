using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;

public class FBXImportProcessor : AssetPostprocessor
{
    public void OnPreprocessModel()
    {
        ModelImporter model = (ModelImporter)assetImporter;
        model.importMaterials = false;
        //model.importAnimation = false;
        //model.animationType = ModelImporterAnimationType.None;
        model.isReadable = false;

        string assetPath = model.assetPath;
        if(assetPath.StartsWith("Assets/RawResources/Scene/CartoonStyle_Fantasy_Pack"))
        {
            model.globalScale = 0.4f;
        }

        // for skeleton animations.
        GameObject g = AssetDatabase.LoadAssetAtPath<GameObject>(model.assetPath);
        if (g == null)
        {
            return;
        }
        List<AnimationClip> animationClipList = new List<AnimationClip>(AnimationUtility.GetAnimationClips(g));
        if (animationClipList.Count == 0)
        {
            AnimationClip[] objectList = UnityEngine.Object.FindObjectsOfType(typeof(AnimationClip)) as AnimationClip[];
            animationClipList.AddRange(objectList);
        }

        foreach (AnimationClip theAnimation in animationClipList)
        {
            try
            {
                //去除scale曲线
                foreach (EditorCurveBinding theCurveBinding in AnimationUtility.GetCurveBindings(theAnimation))
                {
                    string name = theCurveBinding.propertyName.ToLower();
                    if (name.Contains("scale"))
                    {
                        AnimationUtility.SetEditorCurve(theAnimation, theCurveBinding, null);
                    }
                }

                //浮点数精度压缩到f3
                AnimationClipCurveData[] curves = { };
                curves = AnimationUtility.GetAllCurves(theAnimation);
                Keyframe key;
                Keyframe[] keyFrames;
                for (int ii = 0; ii < curves.Length; ++ii)
                {
                    AnimationClipCurveData curveDate = curves[ii];
                    if (curveDate.curve == null || curveDate.curve.keys == null)
                    {
                        //Debug.LogWarning(string.Format("AnimationClipCurveData {0} don't have curve; Animation name {1} ", curveDate, animationPath));
                        continue;
                    }
                    keyFrames = curveDate.curve.keys;
                    for (int i = 0; i < keyFrames.Length; i++)
                    {
                        key = keyFrames[i];
                        key.value = float.Parse(key.value.ToString("f3"));
                        key.inTangent = float.Parse(key.inTangent.ToString("f3"));
                        key.outTangent = float.Parse(key.outTangent.ToString("f3"));
                        keyFrames[i] = key;
                    }
                    curveDate.curve.keys = keyFrames;
                    theAnimation.SetCurve(curveDate.path, curveDate.type, curveDate.propertyName, curveDate.curve);
                }
            }
            catch (System.Exception e)
            {
                Debug.LogError(string.Format("CompressAnimationClip Failed !!! animationPath : {0} error: {1}", assetPath, e));
            }
        }
    }
}
