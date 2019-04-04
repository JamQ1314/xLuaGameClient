using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class main1 : MonoBehaviour {

    LuaEnv luaenv;
    private void Awake()
    {
        
    }

    private void Start()
    {
        luaenv = new LuaEnv();

        luaenv.DoString("require 'main1'");
    }
}
