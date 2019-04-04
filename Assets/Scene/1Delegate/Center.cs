using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Center  {

    private static Center ins;

    public static Center Ins
    {
        get
        {
            if (ins == null)
                ins = new Center();
            return ins;
        }
    }


    public Dictionary<int, Action> dicAction1 = new Dictionary<int, Action>();
    public Dictionary<int, Action<string>> dicAction2 = new Dictionary<int, Action<string>>();
    public Dictionary<int, Action<int,byte[]>> dicAction3 = new Dictionary<int, Action<int, byte[]>>();

    public void RegisterAction1(int id,Action ac)
    {
        dicAction1.Add(id, ac);

        ac();
    }

    public void RegisterAction2(int id, Action<string> ac)
    {
        dicAction2.Add(id, ac);

        ac("111111");
    }
    public void RegisterAction3(int id, Action<int, byte[]> ac)
    {
        dicAction3.Add(id, ac);

        byte[] bytes = new byte[1];
        bytes[0] = 1;
        ac(1,bytes);
    }
}
