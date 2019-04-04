using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class LuaManager :ManagerBase
{

    private LuaEnv luaEnv;

    public override void Init()
    {
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(MyCustomLoader);
        luaEnv.AddBuildin("pb", XLua.LuaDLL.Lua.LoadPb);

        luaEnv.DoString("require 'main'");
    }

    private static byte[] MyCustomLoader(ref string fileName)
    {
        if (GApp.Ins.GMode == GameMode.Debug)
        {
            fileName = fileName.Replace(".", "/") + ".lua";
            var fullName = Application.dataPath + "/LuaScripts/" + fileName;

            return File.ReadAllBytes(fullName);
        }
        else
        {
            string luaName = fileName.Substring(fileName.LastIndexOf('.')+ 1);
            TextAsset luaScript = GApp.AssetLoaderMgr.Load<TextAsset>(luaName + ".lua");
            return System.Text.Encoding.UTF8.GetBytes(luaScript.text);
        }
    }

    public LuaEnv GetLuaEnv()
    {
        return luaEnv;
    }


    public void LoadLua(string luaName)
    {
        if (GApp.Ins.GMode == GameMode.Debug)
        {
            //string relativePtah = Application.dataPath + "/ABGame/LuaScripts";
            luaEnv.DoString(string.Format("require '{0}'", luaName));
        }
        else
        {
            TextAsset luaScript = GApp.AssetLoaderMgr.Load<TextAsset>(luaName + ".lua");
            if (luaScript != null)
                luaEnv.DoString(luaScript.text);
        }

    }

    private void Update()
    {
        
    }

    private void OnDestroy()
    {
        
    }
}
