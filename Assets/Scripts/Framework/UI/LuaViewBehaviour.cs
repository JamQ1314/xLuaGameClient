using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

[CSharpCallLua]
public class LuaViewBehaviour : MonoBehaviour {

    private Action<GameObject> luaAwake;
    private Action luaStart;
    private Action luaUpdate;
    private Action luaOnDestroy;
    private Action<LuaTable> luaOpen;
    private Action luaClose;

    private LuaEnv luaenv;
    private LuaTable scriptEnv;

    private void Awake()
    {
        GApp.UIMgr.RegisterGameObject(gameObject);

        luaenv = GApp.LuaMgr.GetLuaEnv();
        scriptEnv = luaenv.NewTable();
        LuaTable meta = luaenv.NewTable();
        meta.Set("__index", luaenv.Global);
        scriptEnv.SetMetaTable(meta);
        meta.Dispose();

        var goName = name.Contains("(Clone)") ? name.Replace("(Clone)", "") : name;
        luaAwake = scriptEnv.GetInPath<Action<GameObject>>(goName + ".awake");
        luaStart = scriptEnv.GetInPath<Action>(goName + ".start");
        luaUpdate = scriptEnv.GetInPath<Action>(goName + ".update");
        luaOnDestroy = scriptEnv.GetInPath<Action>(goName + ".ondestory");
        luaOpen = scriptEnv.GetInPath<Action<LuaTable>>(goName + ".open");
        luaClose = scriptEnv.GetInPath<Action>(goName + ".close");

        if (luaAwake != null)
            luaAwake(gameObject);
        else
            print("luaAwake is null");
    }

    private void Start()
    {
        if (luaStart != null)
            luaStart();
        else
            print("luaStart is null");
    }

    private void Update()
    {
        if (luaUpdate != null)
            luaUpdate();
        if (luaenv != null)
            luaenv.Tick();
    }

    private void OnDestroy()
    {
        if (luaOnDestroy != null)
            luaOnDestroy();

        luaAwake = null;
        luaOnDestroy = null;
        luaUpdate = null;
        luaStart = null;
        scriptEnv.Dispose();

        GApp.UIMgr.RemoveGameObject(gameObject);
    }


    public void Open(LuaTable luaTable = null)
    {
        gameObject.SetActive(true);
        if(luaOpen !=null)
            luaOpen(luaTable);
    }

    public void Close()
    {
        if (luaClose != null)
            luaClose();
        gameObject.SetActive(false);
    }
}
