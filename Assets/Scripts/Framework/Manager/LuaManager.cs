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
#if DEV_LOCAL
            fileName = fileName.Replace(".", "/") + ".lua";
            var fullName = Application.dataPath + "/LuaScripts/" + fileName;
            return File.ReadAllBytes(fullName);
#endif
            string luaName = fileName.Substring(fileName.LastIndexOf('.')+ 1);
            TextAsset luaScript = GApp.AssetLoaderMgr.Load<TextAsset>(luaName + ".lua");
            return System.Text.Encoding.UTF8.GetBytes(luaScript.text);
    }

    public LuaEnv GetLuaEnv()
    {
        return luaEnv;
    }


    public void LoadLua(string luaName)
    {
#if DEV_LOCAL
        //string relativePtah = Application.dataPath + "/ABGame/LuaScripts";
        luaEnv.DoString(string.Format("require '{0}'", luaName));
        return;
#endif
        TextAsset luaScript = GApp.AssetLoaderMgr.Load<TextAsset>(luaName + ".lua");
        if (luaScript != null)
            luaEnv.DoString(luaScript.text);

    }

    private void Update()
    {
        
    }

    private void OnDestroy()
    {
        
    }
}
