using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[XLua.LuaCallCSharp]
public class NetworkManager : ManagerBase
{
    private Dictionary<int, NSocket> ConnSockets;

    private Dictionary<int, Action<int, byte[]>> dictNetMsgHandlers = new Dictionary<int, Action<int, byte[]>>();

    private Stack<NetInfo> stackNetInfos = new Stack<NetInfo>();

    private void Update()
    {
        if (stackNetInfos.Count != 0)
        {
            var info = stackNetInfos.Pop();
            HandlerNetInfo(info);
        }
    }

    private void OnDestroy()
    {
        foreach (var conn in ConnSockets.Values)
        {
            conn.Close();
        }
    }

    public override void Init()
    {
        base.Init();
        ConnSockets = new Dictionary<int, NSocket>();
    }
    
    
    public void Connect(int socketID, string host, int port)
    {
        NSocket nSocket = null;
        if (ConnSockets.ContainsKey(socketID))
            nSocket = ConnSockets[socketID];
        else
        {
            nSocket = new NSocket(socketID);
            ConnSockets.Add(socketID, nSocket);
        }
        nSocket.ConnAsync(host, port);
    }

    public void SendInt(int socketID, int main_id, int sub_id, int data)
    {
        Send(socketID, main_id, sub_id, BitConverter.GetBytes(data));
    }

    public void SendString(int socketID, int main_id, int sub_id, string data)
    {
        Send(socketID, main_id, sub_id, System.Text.Encoding.Default.GetBytes(data));
    }
    public void Send(int socketID,int main_id, int sub_id, byte[] data, Action<Hashtable> callback = null, Hashtable hashtable = null)
    {
        if (!ConnSockets.ContainsKey(socketID))
            return;
        NSocket nSocket =  ConnSockets[socketID];
        nSocket.SendAsync((ushort)main_id, (ushort)sub_id, data, callback, hashtable);
    }

    public void Close(int socketID)
    {
        if (ConnSockets.ContainsKey(socketID))
        {
            NSocket nSocket = ConnSockets[socketID];
            nSocket.Close();
        }
    }


    public void RegisterHandler(int main_id, Action<int, byte[]> handler)
    {
        if (dictNetMsgHandlers.ContainsKey(main_id))
        {
            Debug.LogError("消息处理器已存在 MainID：" + main_id);
            return;
        }

        dictNetMsgHandlers.Add(main_id, handler);
    }

    class NetInfo
    {
        public int MainID;
        public int SubID;
        public byte[] Buff;

        public NetInfo(int main_id, int sub_id, byte[] buff)
        {
            MainID = main_id;
            SubID = sub_id;
            Buff = buff;
        }
    }
    public void AddNetMessage(int main_id, int sub_id, byte[] buff)
    {
        var info = new NetInfo(main_id, sub_id, buff);
        stackNetInfos.Push(info);
    }

    private void HandlerNetInfo(NetInfo info)
    {
        if (!dictNetMsgHandlers.ContainsKey(info.MainID))
        {
            Debug.LogError("消息处理器不存在 MainID：" + info.MainID);
            return;
        }
        var handler = dictNetMsgHandlers[info.MainID];
        handler(info.SubID, info.Buff);
    }
    public void HandleNetMesssage(int main_id, int sub_id, byte[] buff)
    {
        if (!dictNetMsgHandlers.ContainsKey(main_id))
        {
            Debug.LogError("消息处理器不存在 MainID：" + main_id);
            return;
        }
        var handler = dictNetMsgHandlers[main_id];
        handler(sub_id, buff);
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
