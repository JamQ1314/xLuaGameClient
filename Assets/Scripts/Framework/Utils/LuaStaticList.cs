using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class LuaStaticList : MonoBehaviour {

    [BlackList]
    public static List<List<string>> BlackList = new List<List<string>>()  {
        new List<string>(){"UnityEngine.Light", "shadowRadius"},
        new List<string>(){"UnityEngine.Light", "shadowAngle"},
    };
}
