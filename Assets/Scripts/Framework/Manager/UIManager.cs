using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class UIManager : ManagerBase
{
    private Dictionary<string, GameObject> dictOpenedUIs;

    public override void Init()
    {
        base.Init();
        dictOpenedUIs = new Dictionary<string, GameObject>();
    }

    /// <summary>
    /// 打开UI，附带Hashtable参数
    /// </summary>
    /// <param name="uiName"></param>
    /// <param name="hashtable"></param>
    public void Open(string uiName,Action onCreate = null)
    {
        GameObject ui = GetGameObject(uiName);
        if (ui == null)
        {
            ui = GApp.AssetLoaderMgr.LoadAsset(uiName);
            if (onCreate != null)
                onCreate();
        }
        ui.GetComponent<LuaViewBehaviour>().Open();
        dictOpenedUIs.Add(uiName, ui);
    }

    public void Test()
    {
        print("uimanager test");
    }

    /// <summary>
    /// 关闭单个UI
    /// </summary>
    /// <param name="name"></param>
    public void Close(string name)
    {
        GameObject ui = dictOpenedUIs[name];
        if (ui == null) return;
        ui.GetComponent<LuaViewBehaviour>().Close();
        dictOpenedUIs.Remove(name);

    }
    /// <summary>
    /// 关闭所有UI
    /// </summary>
    public void CloseAll()
    {
        foreach (var v in dictOpenedUIs.Values)
        {
            v.GetComponent<LuaViewBehaviour>().Close();
        }
        dictOpenedUIs = new Dictionary<string, GameObject>();
    }
}