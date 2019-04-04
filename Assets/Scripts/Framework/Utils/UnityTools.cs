using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UnityTools {

    public static Transform FindChild(Transform p, string childName)
    {
        if (childName.Contains("/"))
        {
            return p.Find(childName);
        }

        Transform child = p.Find(childName);
        if (child != null)
        {
            return child;
        }

        Transform[] tranArray = p.GetComponentsInChildren<Transform>(true);
        for (int i = 0; i < tranArray.Length; ++i)
        {
            Transform tran = tranArray[i];
            if (tran.name == childName)
            {
                return tran;
            }
        }

        return null;
    }


    public static void LogDictionary<T,W>(Dictionary<T, W> dict)
    {
        foreach (var kvp in dict)
        {
            Debug.Log(string.Format("key : {0}   value : {1}", kvp.Key, kvp.Value));
        }
    }
}
