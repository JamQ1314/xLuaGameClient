using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class ETest : MonoBehaviour
{
    private LuaEnv luaenv;
    
	void Awake() {
	}
	
	void Start ()
	{
	    luaenv = new LuaEnv();
	    luaenv.AddBuildin("pb", XLua.LuaDLL.Lua.LoadPb);


	    luaenv.DoString("require 'TestMain'");

	}
	
	void Update () {
		
	}


    public void TCsharCallLua()
    {
        print("TCsharCallLua");
    }

    public void TCsharCallLua(XLuaExtend.OnLoad onload)
    {
        print("TCsharCallLua");
        onload();
    }
}



public static class XLuaExtend
{
    [XLua.CSharpCallLua]
    public delegate void OnLoad();
}
