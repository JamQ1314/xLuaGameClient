using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[XLua.LuaCallCSharp]
public class Mgr : MonoBehaviour {


    public static Mgr Ins;

	void Awake() {
        Ins = this;
	}

    public void Test(Action onload)
    {
        if (onload != null)
            onload();
    }
}
