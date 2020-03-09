using UnityEngine;
using System.Collections;
using UnityEngine.Audio;

public class SoundManagerSettings : ScriptableObject
{
    public bool AutoPause = true;

    public float MusicVolumeCorrection = 1f;
    public float SoundVolumeCorrection = 1f;

    public float MusicFadeTime = 2f;

    public AudioMixerGroup MusicAudioMixerGroup;
    public AudioMixerGroup SoundAudioMixerGroup;

    public AudioClip[] PreloadedLoadedClips;

    private float _volumeMusic;
    private float _volumeSound;

    private bool _mutedMusic;
    private bool _mutedSound;

    public void SaveSettings()
    {
        PlayerPrefs.SetFloat("Oz_SM_MusicVolume", _volumeMusic);
        PlayerPrefs.SetFloat("Oz_SM_SoundVolume", _volumeSound);

        PlayerPrefs.SetInt("Oz_SM_MusicMute", _mutedMusic ? 1 : 0);
        PlayerPrefs.SetInt("Oz_SM_SoundMute", _mutedSound ? 1 : 0);
    }

    public void LoadSettings()
    {
        _volumeMusic = PlayerPrefs.GetFloat("Oz_SM_MusicVolume", 0.5f);
        _volumeSound = PlayerPrefs.GetFloat("Oz_SM_SoundVolume", 0.5f);

        _mutedMusic = PlayerPrefs.GetInt("Oz_SM_MusicMute", 0) == 1;
        _mutedSound = PlayerPrefs.GetInt("Oz_SM_SoundMute", 0) == 1;
    }

    public void SetMusicVolume(float volume)
    {
        _volumeMusic = volume;
        SaveSettings();
    }

    public float GetMusicVolume()
    {
        return _volumeMusic;
    }

    public void SetSoundVolume(float volume)
    {
        _volumeSound = volume;
        SaveSettings();
    }

    public float GetSoundVolume()
    {
        return _volumeSound;
    }

    public void SetMusicMuted(bool mute)
    {
        _mutedMusic = mute;
        SaveSettings();
    }

    public bool GetMusicMuted()
    {
        return _mutedMusic;
    }

    public void SetSoundMuted(bool mute)
    {
        _mutedSound = mute;
        SaveSettings();
    }

    public bool GetSoundMuted()
    {
        return _mutedSound;
    }


    public float GetSoundVolumeCorrected()
    {
        return _volumeSound * SoundVolumeCorrection;
    }

    public float GetMusicVolumeCorrected()
    {
        return _volumeMusic * MusicVolumeCorrection;
    }
}
