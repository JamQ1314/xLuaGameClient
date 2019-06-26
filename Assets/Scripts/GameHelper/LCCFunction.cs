using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[XLua.LuaCallCSharp]
public class LCCFunction  {

    public static byte[] ImageToBytes(Texture2D tex)
    {
        return tex.EncodeToPNG();
    }

    public static byte[] LuaTest(Texture2D tex)
    {
        GameObject go = GameObject.Find("headIco");
        go.name = "1111111111111111111111111";
        var sp = Sprite.Create(tex, new Rect(0, 0, tex.width, tex.height), 0.5f * Vector2.one);
        go.GetComponent<UnityEngine.UI.Image>().sprite = sp;
        return null;
    }
}
