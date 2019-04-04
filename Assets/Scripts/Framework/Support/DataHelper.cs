using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[XLua.LuaCallCSharp]
public class DataHelper  {

    public static string IntToByets(int i)
    {
        return BitConverter.GetBytes(i).ToString();
    }

    public static int BytesToInt(byte[] bytes)
    {
        return BitConverter.ToInt32(bytes,0);
    }

    public static byte[] StrToBytes(string str)
    {
        return System.Text.Encoding.Default.GetBytes(str);
    }

    public static string BytesToStr(byte[] bytes)
    {
        return System.Text.Encoding.Default.GetString(bytes);
    }
}
