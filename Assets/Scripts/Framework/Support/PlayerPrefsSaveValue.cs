using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[XLua.LuaCallCSharp]
public static class PlayerPrefsSaveValue {

    public static void SetString(string key, string value)
    {
        PlayerPrefs.SetString(key, value);
        Debug.Log(string.Format("PlayerPrefs.SetString , key : {0}  value : {1}", key, value));
//        Debug.Log(string.Format("PlayerPrefs.SetString , key : {0}  value : {1}", key, GetString(key)));
    }

    public static string GetString(string key)
    {
        return PlayerPrefs.GetString(key);
    }

    public static void SetFloat(string key, float value)
    {
        PlayerPrefs.SetFloat(key, value);
    }

    public static float GetFloat(string key)
    {
        return PlayerPrefs.GetFloat(key);
    }

    public static void SetInt(string key, int value)
    {
        PlayerPrefs.SetFloat(key, value);
    }

    public static float GetInt(string key)
    {
        return PlayerPrefs.GetFloat(key);
    }

    public static void Test()
    {
        Debug.Log(string.Format("PlayerPrefs.Test"));
    }

    public static void Test2(string v1)
    {
        Debug.Log( v1);
    }
}
