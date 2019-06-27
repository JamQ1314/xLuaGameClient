using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public enum NSocketType
{
    Login,
    Game,
    Chat,
}


public struct TCP_Info
{
    public uint Buffer_Size;
    public uint Check_ID;
}
public struct TCP_Commend
{
    public uint Main_ID;
    public uint Sub_ID;
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode, Pack = 1)]
public class TCP_Head
{
    public TCP_Info Info;
    public TCP_Commend Cmd;
}


public class NetDefine
{
    public const int SOCKET_TCP_BUFFER = 4096*3;

    public static byte[] StrToBytes(string str)
    {
        //宽字节
        return System.Text.Encoding.Unicode.GetBytes(str);
    }

    public static string BytesToStr(byte[] bytes)
    {
        //宽字节
        return System.Text.Encoding.Unicode.GetString(bytes);
    }

    public static byte[] StruToBytes(object stru)
    {
        int nSize = Marshal.SizeOf(stru);
        IntPtr ptr = Marshal.AllocHGlobal(nSize);//申请内存空间 ptr指针
        try
        {
            Marshal.StructureToPtr(stru, ptr, false);
            byte[] bytes = new byte[nSize];
            Marshal.Copy(ptr, bytes, 0, nSize);
            return bytes;
        }
        catch (Exception e)
        {
            Debug.LogError(string.Format("结构 {0} 转字节流失败：" + e));
            return null;
        }
        finally
        {
            Marshal.FreeHGlobal(ptr);   //释放内存
        }
    }

    public static T BytesToStru<T>(byte[] bytes)
    {
        int nSize = Marshal.SizeOf(typeof(T));
        IntPtr ptr = Marshal.AllocHGlobal(nSize);
        try
        {
            Marshal.Copy(bytes, 0, ptr, nSize);
            return (T)Marshal.PtrToStructure(ptr, typeof(T));
        }
        catch (Exception e)
        {
            Debug.LogError(string.Format("结构 {0} 转字节流失败：" + e));
            return default(T);
        }
        finally
        {
            Marshal.FreeHGlobal(ptr);
        }
    }
}

