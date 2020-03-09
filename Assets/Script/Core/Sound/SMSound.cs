using System.Collections;
using UnityEngine;

[SLua.CustomLuaClass]
public class SMSound
{
    public string assetBundleName;
    public string Name;
    public AudioSource Source;
    public bool IsLoading;
    public IEnumerator LoadingCoroutine;
    public bool IsPossessedLoading;
    public float SelfVolume;
    public bool IsAttachedToTransform;
    public Transform Attach;
    public bool IsValid;

    public float GetVolume()
    {
        return SelfVolume;
    }

    public SMSound SetVolume(float volume)
    {
        SelfVolume = volume;
        if (IsValid)
            Source.volume = volume * SoundManager.Instance.GetSettings().GetSoundVolumeCorrected();
        return this;
    }

    public SMSound SetLooped(bool looped = true)
    {
        if (IsValid)
            Source.loop = looped;
        return this;
    }

    public SMSound SetPausable(bool pausable)
    {
        if (IsValid)
            Source.ignoreListenerPause = !pausable;
        return this;
    }

    public SMSound Set3D(bool is3D)
    {
        if (IsValid)
            Source.spatialBlend = is3D ? 1 : 0;
        return this;
    }

    public SMSound AttachToObject(Transform objectToAttach)
    {
        IsAttachedToTransform = true;
        Attach = objectToAttach;
        if (IsValid)
            Source.transform.position = objectToAttach.position;
        return this;
    }

    public SMSound SetPosition(Vector3 position)
    {
        if (IsValid)
            Source.transform.position = position;
        return this;
    }

    // SoundHandler not valid after this call
    public void Stop()
    {
        if (IsValid)
            SoundManager.Instance.Stop(this);
    }
}