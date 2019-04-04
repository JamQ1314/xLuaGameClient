using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using System.Net;
using System.Net.Sockets;

public class NetworkInvokeHelper{
    static Mutex m_handlerListMutex = new Mutex();
    public static List<Action> m_handler_list = new List<Action>();

    //static Mutex m_handlerListMutex = new Mutex();
    //static List<Action> m_handler_list = new List<Action>();

    

    public static void post(Action act)//发送到主线程中执行，避免多线程操作
    {
        m_handlerListMutex.WaitOne();
        m_handler_list.Add(act);
        m_handlerListMutex.ReleaseMutex();
    }

    public static  void Update()
    {
        List<Action> handlerList = new List<Action>();
        m_handlerListMutex.WaitOne();
        for (int i = 0; i < m_handler_list.Count; ++i)
        {
            handlerList.Add(m_handler_list[i]);
        }
        m_handler_list.Clear();
        m_handlerListMutex.ReleaseMutex();

        foreach (var act in handlerList)
        {
            act();
        }
    }

    //public static void closesocket(tcpsocket socket)
    //{
    //    if (m_socket_list.containskey(socket.m_socket))
    //        m_socket_list.remove(socket.m_socket);
    //}
}
