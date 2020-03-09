using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;

public class AudioPostProcessor : AssetPostprocessor
{
    private const string music_path = "Assets/RawResources/Audio/Music/";
    private const string sound_path = "Assets/RawResources/Audio/Sounds/";

    void OnPostprocessAudio(AudioClip clip)
    {
        if (assetPath.StartsWith(music_path))
        {
            string abName = new DirectoryInfo(Path.GetFileNameWithoutExtension(assetPath)).Name.ToLower();
            assetImporter.assetBundleName = "music/" + abName + ".u3d";

            AudioImporter audio = assetImporter as AudioImporter;
            if (audio != null)
            {
                AudioImporterSampleSettings audioSettings = new AudioImporterSampleSettings();
                audioSettings.loadType = AudioClipLoadType.Streaming;
                audioSettings.compressionFormat = AudioCompressionFormat.Vorbis;
                audioSettings.quality = 0.1f;
                audioSettings.sampleRateSetting = AudioSampleRateSetting.OverrideSampleRate;
                audioSettings.sampleRateOverride = 11025;

                audio.defaultSampleSettings = audioSettings;
            }
        }

        if (assetPath.StartsWith(sound_path))
        {
            string abName = new DirectoryInfo(Path.GetFileNameWithoutExtension(assetPath)).Name.ToLower();
            assetImporter.assetBundleName = "sounds/" + abName + ".u3d";
        }
    }
}
