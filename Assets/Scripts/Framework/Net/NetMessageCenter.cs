using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class NetMessageCenter  {

    protected static NetMessageCenter ins;
    public static NetMessageCenter Ins
    {
        get
        {
            if (ins == null)
                ins = new NetMessageCenter();
            return ins;
        }
    }

    private Dictionary<int, Action<int, byte[]>> dictNetMsgHandlers = new Dictionary<int, Action<int, byte[]>>();


    public void RegisterHandler(int main_id,Action<int,byte[]> handler)
    {
        if (dictNetMsgHandlers.ContainsKey(main_id))
        {
            Debug.LogError("消息处理器已存在 MainID：" + main_id);
            return;
        }

        dictNetMsgHandlers.Add(main_id, handler);
    }

    public void HandleNetMesssage(int main_id,int sub_id,byte[] buff)
    {
        if (!dictNetMsgHandlers.ContainsKey(main_id))
        {
            Debug.LogError("消息处理器不存在 MainID：" + main_id);
            return;
        }

        var handler = dictNetMsgHandlers[main_id];
        handler(sub_id, buff);
//        LogBytes(buff);
//
//        user.User temp = new user.User();
//        temp.name = "zxc";
//        temp.id = 10;
//        temp.sex = 0;
//        temp.gold = 1000;
//        var ms = new MemoryStream();
//        Serializer.Serialize<user.User>(ms, temp);
//        byte[] tempBytes = ms.ToArray();
//        LogBytes(tempBytes);
    }


    public void LogBytes(byte[] bytes)
    {
        string str = "";
        for (int i = 0; i < bytes.Length; i++)
        {
            str += bytes[i] + " ";
        }

        Debug.Log(str);
    }
}
