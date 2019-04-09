using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[XLua.LuaCallCSharp]
public class GameAssetsContainer : MonoBehaviour {


    [SerializeField]
    private Sprite[] Textures;
    [SerializeField]
    private AudioClip[] Sounds;

    private Dictionary<string, Sprite> dictTextures = new Dictionary<string, Sprite>();
    private Dictionary<string, AudioClip> dictSounds = new Dictionary<string, AudioClip>();

    private void Awake()
    {
        if (Textures.Length > 0)
        {
            for (int i = 0; i < Textures.Length; i++)
            {
                dictTextures.Add(Textures[i].name, Textures[i]);
            }
        }

        if (Sounds.Length > 0)
        {
            for (int i = 0; i < Sounds.Length; i++)
            {
                dictSounds.Add(Sounds[i].name, Sounds[i]);
            }
        }
    }
    public Sprite GetTex(string texName)
    {
        if (dictTextures.ContainsKey(texName))
            return dictTextures[texName];
        else
            return null;
    }

    public AudioClip GetSound(string soundName)
    {
        if (dictSounds.ContainsKey(soundName))
            return dictSounds[soundName];
        else
            return null;
    }
}
