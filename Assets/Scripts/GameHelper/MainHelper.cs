using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[XLua.LuaCallCSharp]
public class MainHelper  {

    public static void EditHead(Action<byte[]> onLoad)
    {
#if UNITY_EDITOR
        var path = OpenSystemFolder.OpenFile();
        CoroutineRunner co = GameObject.FindObjectOfType<CoroutineRunner>();
        co.StartCoroutine(IeGetHeadIco(path, onLoad));
        
#elif UNITY_ANDROID

#elif UNITY_IOS

#endif
    }


    private static IEnumerator IeGetHeadIco(string path, Action<byte[]> onLoad)
    {
        WWW w = new WWW("file:///" + path);
        yield return w;
        Texture2D tex2d = w.texture;
        GameObject gohead = GameObject.Find("headIco");
        if (gohead == null)
            yield break;
        Sprite _sp = Sprite.Create(tex2d, new Rect(0, 0, tex2d.width, tex2d.height), 0.5f * Vector2.one);
        gohead.GetComponent<UnityEngine.UI.Image>().sprite = _sp;
        var texBytes = tex2d.EncodeToPNG();
        Debug.Log("texBytes : " + texBytes.Length);
        var strBytes = System.Text.Encoding.Unicode.GetString(texBytes);
        Debug.Log("strBytes : " + strBytes.Length);

        onLoad(texBytes);
    }
}
