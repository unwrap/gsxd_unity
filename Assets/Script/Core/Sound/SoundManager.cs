using System.Collections.Generic;
using System.Collections;
using UnityEngine;
using UnityEngine.Audio;

[SLua.CustomLuaClass]
public class SoundManager : MonoBehaviour
{
    private SoundManagerSettings _settings;

    List<SMSound> _sounds = new List<SMSound>();

    struct PreloadedClip
    {
        public AudioClip clip;
        public int level;
    }

    Dictionary<string, PreloadedClip> _preloadedClips = new Dictionary<string, PreloadedClip>(16);

    SMMusic _music;
    string _currentMusicName;

    private SMSound mChatSound;

    List<SMMusicFadingOut> _musicFadingsOut = new List<SMMusicFadingOut>();

    private bool _loadingInProgress;


    #region Public functions

    public static void PlayMusic(string name)
    {
        if (Instance != null)
        {
            Instance.PlayMusicInternal(name);
        }
    }

    public static void PauseMusic()
    {
        if(Instance != null)
        {
            Instance.PauseMusicInternal();
        }
    }

    public static void UnPauseMusic()
    {
        if(Instance != null)
        {
            Instance.UnPauseMusicInternal();
        }
    }

    public static void StopMusic()
    {
        if (Instance != null)
        {
            Instance.StopMusicInternal();
        }
    }

    public static SMSound PlaySound(AudioClip clip)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundClipInternal(clip, true);
        }
        return null;
    }

    public static SMSound PlaySoundUI(AudioClip clip)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundClipInternal(clip, false);
        }
        return null;
    }

    public static SMSound PlaySound(string assetBundleName, string name)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundInternal(assetBundleName, name, true);
        }
        return null;
    }

    public static SMSound PlaySoundUI(string assetBundleName, string name)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundInternal(assetBundleName, name, false);
        }
        return null;
    }

    public static SMSound PlaySound(string name)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundInternal("sounds/" + name.ToLower() + ".u3d", name, true);
        }
        return null;
    }

    public static SMSound PlaySoundUI(string name)
    {
        if (Instance != null)
        {
            return Instance.PlaySoundInternal("sounds/" + name.ToLower() + ".u3d", name, false);
        }
        return null;
    }

    // Deprecated. Will be changed in future version
    public static void PlaySoundWithDelay(string assetBundleName, string name, float delay, bool pausable = true)
    {
        if (Instance != null)
        {
            Instance.PlaySoundWithDelayInternal(assetBundleName, name, delay, pausable);
        }
    }

    public static void LoadSound(string assetBundleName, string name)
    {
        if (Instance != null)
        {
            Instance.LoadSoundInternal(assetBundleName, name);
        }
    }

    public static void UnloadSound(string name, bool force = false)
    {
        if (!IsValid()) // Unload can be called from OnDestroy or OnDisable
            return;
        if (Instance != null)
        {
            Instance.UnloadSoundInternal(name, force);
        }
    }

    public static void Pause()
    {
        if (Instance == null)
        {
            return;
        }
        if (Instance._settings.AutoPause)
        {
            return;
        }

        AudioListener.pause = true;
    }

    public static void UnPause()
    {
        if (Instance == null)
        {
            return;
        }
        if (Instance._settings.AutoPause)
        {
            return;
        }
        AudioListener.pause = false;
    }

    public static void StopAllPausableSounds()
    {
        if (Instance != null)
        {
            Instance.StopAllPausableSoundsInternal();
        }
    }

    // Volume [0 - 1]
    public static void SetMusicVolume(float volume)
    {
        if (Instance != null)
        {
            Instance._settings.SetMusicVolume(volume);
            Instance.ApplyMusicVolume();
        }
    }

    // Volume [0 - 1]
    public static float GetMusicVolume()
    {
        if(Instance == null)
        {
            return 0.0f;
        }
        return Instance._settings.GetMusicVolume();
    }

    public static void SetMusicMuted(bool mute)
    {
        if(Instance == null)
        {
            return;
        }
        Instance._settings.SetMusicMuted(mute);
        Instance.ApplyMusicMuted();
    }

    public static bool GetMusicMuted()
    {
        if(Instance == null)
        {
            return false;
        }
        return Instance._settings.GetMusicMuted();
    }

    // Volume [0 - 1]
    public static void SetSoundVolume(float volume)
    {
        if(Instance == null)
        {
            return;
        }
        Instance._settings.SetSoundVolume(volume);
        Instance.ApplySoundVolume();
    }

    // Volume [0 - 1]
    public static float GetSoundVolume()
    {
        if(Instance == null)
        {
            return 0.0f;
        }
        return Instance._settings.GetSoundVolume();
    }

    public static void SetSoundMuted(bool mute)
    {
        if(Instance == null)
        {
            return;
        }
        Instance._settings.SetSoundMuted(mute);
        Instance.ApplySoundMuted();
    }

    public static bool GetSoundMuted()
    {
        if(Instance == null)
        {
            return false;
        }
        return Instance._settings.GetSoundMuted();
    }

    // Check for valid if use SoundManager in OnDestroy()
    public static bool IsValid()
    {
        return !applicationIsQuitting;
    }

    #endregion

    #region Sound Handler methods
    public SoundManagerSettings GetSettings()
    {
        return _settings;
    }

    public void Stop(SMSound smSound)
    {
        StopSoundInternal(smSound);
    }
    #endregion

    #region Internal Classes
    public class SMMusic
    {
        private string _name;
        public AudioSource Source;

        public float Timer;
        public float FadingTime;
        public float TargetVolume;
        public bool FadingIn;
    }

    public class SMMusicFadingOut
    {
        private string _name;
        public AudioSource Source;

        public float Timer;
        public float FadingTime;
        public float StartVolume;
    }
    #endregion

    #region Singleton
    private static SoundManager _instance;
    private static bool _inited;

    public static SoundManager Instance
    {
        get
        {
            if (applicationIsQuitting)
            {
                Debug.LogWarning("[Singleton] Instance '" + typeof(SoundManager) +
                    "' already destroyed on application quit." +
                    " Won't create again - returning null.");
                return null;
            }

            if (_inited)
                return _instance;

            return new GameObject("SoundManager (singleton)").AddComponent<SoundManager>();
        }
    }

    private static bool applicationIsQuitting = false;

    /// <summary>
    /// When Unity quits, it destroys objects in a random order.
    /// In principle, a Singleton is only destroyed when application quits.
    /// If any script calls Instance after it have been destroyed, 
    ///   it will create a buggy ghost object that will stay on the Editor scene
    ///   even after stopping playing the Application. Really bad!
    /// So, this was made to be sure we're not creating that buggy ghost object.
    /// </summary>
    public void OnDestroy()
    {
        applicationIsQuitting = true;
    }
    #endregion

    #region Settings


    #endregion // Settings

    #region Music

    private void PlayMusicInternal(string musicName)
    {
        if (string.IsNullOrEmpty(musicName))
        {
            Debug.Log("Music empty or null");
            return;
        }

        if (_currentMusicName == musicName)
        {
            //Debug.Log("Music already playing: " + musicName);
            return;
        }

        if (!string.IsNullOrEmpty(_currentMusicName))
        {
            AssetBundleManager.UnloadAssetBundle("music/" + _currentMusicName + ".u3d", true);
        }

        StopMusicInternal();

        _currentMusicName = musicName;

        AudioClip musicClip = LoadClipFromBundle( "music/"+ musicName + ".u3d", musicName);// LoadClip("Music/" + musicName);

        GameObject music = new GameObject("Music: " + musicName);
        AudioSource musicSource = music.AddMissingComponent<AudioSource>();

        music.transform.SetParent(transform);

        musicSource.outputAudioMixerGroup = _settings.MusicAudioMixerGroup;

        musicSource.loop = true;
        musicSource.priority = 0;
        musicSource.playOnAwake = false;
        musicSource.mute = _settings.GetMusicMuted();
        musicSource.ignoreListenerPause = true;
        musicSource.clip = musicClip;
        musicSource.Play();

        musicSource.volume = 0;

        _music = new SMMusic();
        _music.Source = musicSource;
        _music.FadingIn = true;
        _music.TargetVolume = _settings.GetMusicVolumeCorrected();
        _music.Timer = 0;
        _music.FadingTime = _settings.MusicFadeTime;
    }

    private void PauseMusicInternal()
    {
        if(_music != null)
        {
            _music.Source.Pause();
        }
    }

    private void UnPauseMusicInternal()
    {
        if(_music != null)
        {
            _music.Source.UnPause();
        }
    }

    void StopMusicInternal()
    {
        _currentMusicName = "";
        if (_music != null)
        {
            StartFadingOutMusic();
            _music = null;
        }
    }

    #endregion // Music

    #region Sound

    SMSound PlaySoundInternal(string assetBundleName, string soundName, bool pausable)
    {
        SMSound sound = new SMSound();
        sound.assetBundleName = assetBundleName;
        sound.Name = soundName;
        sound.SelfVolume = 1;

        if (string.IsNullOrEmpty(soundName))
        {
            Debug.Log("Sound null or empty");
            sound.IsValid = false;
            return sound;
        }

        int sameCountGuard = 0;
        foreach (SMSound smSound in _sounds)
        {
            if (smSound.Name == soundName)
                sameCountGuard++;
        }

        if (sameCountGuard > 8)
        {
            Debug.Log("Too much duplicates for sound: " + soundName);
            sound.IsValid = false;
            return sound;
        }

        if (_sounds.Count > 16)
        {
            Debug.Log("Too much sounds");
            sound.IsValid = false;
            return sound;
        }

        GameObject soundGameObject = ObjectPool.Spawn();// new GameObject("Sound: " + soundName);
        soundGameObject.name = "Sound: " + soundName;
        AudioSource soundSource = soundGameObject.AddMissingComponent<AudioSource>();
        soundGameObject.transform.parent = transform;

        sound.Source = soundSource;
        sound.IsValid = true;

        soundSource.outputAudioMixerGroup = _settings.SoundAudioMixerGroup;
        soundSource.priority = 128;
        soundSource.playOnAwake = false;
        soundSource.mute = _settings.GetSoundMuted();
        soundSource.volume = _settings.GetSoundVolumeCorrected();
        soundSource.ignoreListenerPause = !pausable;

        _sounds.Add(sound);

        PreloadedClip preloadedClip;
        if (_preloadedClips.TryGetValue(soundName, out preloadedClip))
        {
            soundSource.clip = preloadedClip.clip;
            soundSource.Play();
        }
        else
        {
            sound.LoadingCoroutine = PlaySoundInternalAfterLoad(sound, soundName, assetBundleName);
            StartCoroutine(sound.LoadingCoroutine);
        }

        return sound;
    }

    SMSound PlaySoundClipInternal(AudioClip clip, bool pausable)
    {
        SMSound sound = new SMSound();
        sound.Name = clip.name;
        sound.SelfVolume = 1;

        if (_sounds.Count > 16)
        {
            Debug.Log("Too much sounds");
            sound.IsValid = false;
            return sound;
        }

        GameObject soundGameObject = ObjectPool.Spawn();// new GameObject("Sound: " + sound.Name);
        soundGameObject.name = "Sound: " + sound.Name;
        AudioSource soundSource = soundGameObject.AddMissingComponent<AudioSource>();
        soundGameObject.transform.parent = transform;

        sound.Source = soundSource;
        sound.IsValid = true;

        soundSource.clip = clip;
        soundSource.outputAudioMixerGroup = _settings.SoundAudioMixerGroup;
        soundSource.priority = 128;
        soundSource.playOnAwake = false;
        soundSource.mute = _settings.GetSoundMuted();
        soundSource.volume = _settings.GetSoundVolumeCorrected();
        soundSource.ignoreListenerPause = !pausable;
        soundSource.Play();

        _sounds.Add(sound);

        return sound;
    }

    private float[] ToFloatArray(byte[] byteArray)
    {
        int len = byteArray.Length / 4;
        float[] floatArray = new float[len];
        for (int i = 0; i < byteArray.Length; i += 4)
        {
            if( (i+4) < byteArray.Length )
            {
                floatArray[i / 4] = System.BitConverter.ToSingle(byteArray, i);
            }
        }
        return floatArray;
    }

    IEnumerator PlaySoundInternalAfterLoad(SMSound smSound, string soundName, string bundleName)
    {
        smSound.IsLoading = true;

        // Need to wait others sounds to be loaded to avoid Android LoadingPersistentStorage lags
        while (_loadingInProgress)
        {
            yield return null;
        }

        _loadingInProgress = true;
        smSound.IsPossessedLoading = true;
        AudioClip soundClip = null;

        soundClip = LoadClipFromBundle(bundleName, soundName);
        /*
        if (bundle == null)
        {
            ResourceRequest request = LoadClipAsync("Sounds/" + soundName);
            while (!request.isDone)
                yield return null;
            soundClip = (AudioClip)request.asset;
        }
        else
        {
            AssetBundleRequest request = LoadClipFromBundleAsync(bundle, soundName);
            while (!request.isDone)
                yield return null;
            soundClip = (AudioClip)request.asset;
        }
        */
        smSound.IsPossessedLoading = false;
        _loadingInProgress = false;

        if (null == soundClip)
        {
            Debug.Log("Sound not loaded: " + soundName);
        }

        smSound.IsLoading = false;
        smSound.Source.clip = soundClip;
        smSound.Source.Play();
    }

    void PlaySoundWithDelayInternal(string assetBundleName, string soundName, float delay, bool pausable)
    {
        StartCoroutine(PlaySoundWithDelayCoroutine(assetBundleName, soundName, delay, pausable));
    }

    void StopAllPausableSoundsInternal()
    {
        foreach (SMSound sound in _sounds)
        {
            if (!sound.Source.ignoreListenerPause)
            {
                StopSoundInternal(sound);
            }
        }
    }

    void StopSoundInternal(SMSound sound)
    {
        if (sound.IsLoading)
        {
            StopCoroutine(sound.LoadingCoroutine);
            if (sound.IsPossessedLoading)
                _loadingInProgress = false;

            sound.IsLoading = false;
        }
        else
            sound.Source.Stop();
    }

    private void LoadSoundInternal(string assetBundleName, string soundName)
    {
        AudioClip clip = LoadClipFromBundle(assetBundleName, soundName);
        if (clip != null)
        {
            if (!clip.preloadAudioData)
                clip.LoadAudioData();

            PreloadedClip preloadedClip;
            if (_preloadedClips.TryGetValue(soundName, out preloadedClip))
            {
                preloadedClip.clip = clip;
                preloadedClip.level += 1;
            }
            else
            {
                preloadedClip.clip = clip;
                preloadedClip.level = 1;
                _preloadedClips.Add(soundName, preloadedClip);
            }
        }
    }

    private void UnloadSoundInternal(string soundName, bool force)
    {
        PreloadedClip preloadedClip;
        if (_preloadedClips.TryGetValue(soundName, out preloadedClip))
        {
            if (preloadedClip.level > 1 && !force)
            {
                preloadedClip.level -= 1;
            }
            else
            {
                _preloadedClips.Remove(soundName);
                if (!preloadedClip.clip.preloadAudioData)
                    preloadedClip.clip.UnloadAudioData();
            }
        }
    }

    #endregion // Sound

    #region Internal

    void Awake()
    {
        // Only one instance of SoundManager at a time!
        if (_inited)
        {
            Destroy(gameObject);
            return;
        }
        _inited = true;
        _instance = this;
        DontDestroyOnLoad(gameObject);

        //AudioListener listerner = this.gameObject.AddMissingComponent<AudioListener>();

        _settings = Resources.Load<SoundManagerSettings>("SoundManagerSettings");
        if (_settings == null)
        {
            Debug.LogWarning("SoundManagerSettings not founded resources. Using default settings");
            _settings = ScriptableObject.CreateInstance<SoundManagerSettings>();
        }

        _settings.LoadSettings();

        foreach (AudioClip permanentLoadedClip in _settings.PreloadedLoadedClips)
        {
            PreloadedClip preloadedClip;
            preloadedClip.clip = permanentLoadedClip;
            preloadedClip.level = 1;
            _preloadedClips.Add(permanentLoadedClip.name, preloadedClip);
        }

        LoadSound("sounds/button1.u3d", "button1");

        ApplySoundVolume();
        ApplyMusicVolume();

        ApplySoundMuted();
        ApplyMusicMuted();
    }

    void Update()
    {
        if(this.mChatSound != null)
        {
            if(IsSoundFinished(this.mChatSound))
            {
                this.mChatSound.IsValid = false;
                ObjectPool.Recycle(this.mChatSound.Source.gameObject);
                this.mChatSound = null;
            }
        }

        // Destory only one sound per frame
        SMSound soundToDelete = null;

        for(int i = 0; i < _sounds.Count; i++)
        {
            SMSound sound = _sounds[i];
            if (IsSoundFinished(sound))
            {
                soundToDelete = sound;
                break;
            }
        }

        if (soundToDelete != null)
        {
            soundToDelete.IsValid = false;
            _sounds.Remove(soundToDelete);
            //Destroy(soundToDelete.Source.gameObject);
            /*
            if(!string.IsNullOrEmpty(soundToDelete.assetBundleName))
            {
                AssetBundleManager.UnloadAssetBundle(soundToDelete.assetBundleName, false);
            }
            */
            ObjectPool.Recycle(soundToDelete.Source.gameObject);
        }

        if (_settings.AutoPause)
        {
            bool curPause = Time.timeScale < 0.1f;
            if (curPause != AudioListener.pause)
            {
                AudioListener.pause = curPause;
            }
        }

        for (int i = 0; i < _musicFadingsOut.Count; i++)
        {
            SMMusicFadingOut music = _musicFadingsOut[i];
            if (music.Source == null)
            {
                _musicFadingsOut.RemoveAt(i);
                i--;
            }
            else
            {
                music.Timer += Time.unscaledDeltaTime;
                _musicFadingsOut[i] = music;
                if (music.Timer >= music.FadingTime)
                {
                    Destroy(music.Source.gameObject);
                    _musicFadingsOut.RemoveAt(i);
                    i--;
                }
                else
                {
                    float k = Mathf.Clamp01(music.Timer / music.FadingTime);
                    music.Source.volume = Mathf.Lerp(music.StartVolume, 0, k);
                }
            }
        }

        if (_music != null && _music.FadingIn)
        {
            _music.Timer += Time.unscaledDeltaTime;
            if (_music.Timer >= _music.FadingTime)
            {
                _music.Source.volume = _music.TargetVolume;
                _music.FadingIn = false;
            }
            else
            {
                float k = Mathf.Clamp01(_music.Timer / _music.FadingTime);
                _music.Source.volume = Mathf.Lerp(0, _music.TargetVolume, k);
            }
        }
    }

    void LateUpdate()
    {
        for(int i = 0; i < _sounds.Count; i++)
        {
            SMSound sound = _sounds[i];
            if (sound.IsAttachedToTransform && sound.Attach != null)
            {
                sound.Source.transform.position = sound.Attach.position;
            }
        }
    }
    void StartFadingOutMusic()
    {
        if (_music != null)
        {
            SMMusicFadingOut fader = new SMMusicFadingOut();
            fader.Source = _music.Source;
            fader.FadingTime = _settings.MusicFadeTime;
            fader.Timer = 0;
            fader.StartVolume = _music.Source.volume;
            _musicFadingsOut.Add(fader);
        }
    }

    private IEnumerator PlaySoundWithDelayCoroutine(string assetBundleName, string name, float delay, bool pausable)
    {
        float timer = delay;
        while (timer > 0)
        {
            timer -= pausable ? Time.deltaTime : Time.unscaledDeltaTime;
            yield return null;
        }

        PlaySoundInternal(assetBundleName, name, pausable);
    }

    private AudioClip LoadClipFromBundle(string assetBundleName, string assetName)
    {
        AudioClip clip = AssetBundleManager.LoadAsset(assetBundleName, assetName, typeof(AudioClip)) as AudioClip;
        return clip;
    }

    ResourceRequest LoadClipAsync(string name)
    {
        string path = "SoundManager/" + name;
        return Resources.LoadAsync<AudioClip>(path);
    }

    AssetBundleRequest LoadClipFromBundleAsync(AssetBundle bundle, string name)
    {
        return bundle.LoadAssetAsync<AudioClip>(name);
    }

    bool IsSoundFinished(SMSound sound)
    {
        if (sound.IsLoading)
            return false;

        if (sound.Source.isPlaying)
            return false;

        if (sound.Source.clip == null)
        {
            return true;
        }

        if (sound.Source.clip.loadState == AudioDataLoadState.Loading)
            return false;

        if (!sound.Source.ignoreListenerPause && AudioListener.pause)
            return false;

        return true;
    }

    void ApplySoundVolume()
    {
        foreach (SMSound sound in _sounds)
        {
            sound.Source.volume = _settings.GetSoundVolumeCorrected() * sound.SelfVolume;
        }
    }

    void ApplyMusicVolume()
    {
        if (_music != null)
        {
            _music.FadingIn = false;
            _music.TargetVolume = _settings.GetMusicVolumeCorrected();
            _music.Source.volume = _music.TargetVolume;
        }
    }

    void ApplySoundMuted()
    {
        foreach (SMSound sound in _sounds)
        {
            sound.Source.mute = _settings.GetSoundMuted();
        }
    }

    void ApplyMusicMuted()
    {
        if (_music != null)
        {
            _music.Source.mute = _settings.GetMusicMuted();
        }
    }

    #endregion // Internal
}
