using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UnitySingleton<T> : MonoBehaviour where T : MonoBehaviour
{
    private static T ins = null;

    public static T Ins
    {
        get
        {
            string name = "(Singleton)" + typeof(T).ToString();
            GameObject go = GameObject.Find(name);
            if (go == null)
                go = new GameObject(name);
            DontDestroyOnLoad(go);
            ins = go.GetComponent<T>();
            if (ins == null)
                ins = go.AddComponent<T>();
            return ins;
        }
    }
}