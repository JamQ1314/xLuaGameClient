using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UnityCommFunc
{
    private static CoroutineRunner corunner;

    public static void WWWDown(string url,Action onLoad)
    {
        if (corunner == null)
        {
            corunner = GameObject.FindObjectOfType<CoroutineRunner>();
        }

        corunner.StartCoroutine(IeDown(url, onLoad));
    }


    private static IEnumerator IeDown(string url, Action onLoad)
    {
        WWW w = new WWW(url);
        yield return w;

        yield return null;
    }
}
