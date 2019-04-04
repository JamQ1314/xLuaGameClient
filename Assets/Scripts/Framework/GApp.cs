using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public enum GameMode
{
    Debug,//开发模式
    Release //发布模式
}

[LuaCallCSharp]
public class GApp :MonoBehaviour
{
    //    private static GApp ins = null;
    //
    //    public static GApp Ins
    //    {
    //        get { return FindObjectOfType<GApp>(); }
    //    }

    public static GApp Ins;
    public GameMode GMode = GameMode.Debug;

    public int GetMode()
    {
        return (int) GMode;
    }
    /// <summary>
    /// AssetBundle管理器
    /// </summary>
    public static AssetLoaderManager AssetLoaderMgr = null;
    /// <summary>
    /// 网络管理器
    /// </summary>
    public static NetworkManager NetMgr = null;
    /// <summary>
    /// UI界面管理器
    /// </summary>
    public static UIManager UIMgr = null;
    /// <summary>
    /// 声音管理器
    /// </summary>
    public static AudioManager AudioMgr = null;
    /// <summary>
    /// Lua管理器
    /// </summary>
    public static LuaManager LuaMgr = null;

    private void Awake()
    {
        Ins = this;
#if !UNITY_EDITOR
        GMode = GameMode.Release;
#endif
    }
    private void Start()
    {
        DoUpdate();
    }

    private void DoUpdate()
    {
        if (Application.internetReachability == NetworkReachability.NotReachable)
        {
            Debug.LogError(" Net Disconnect");
            return;
        }
        //先更新资源
        var help = GetComponent<AssetUpdateHelper>();
        help.Init();
        help.StartUpdateAssets(delegate
        {
            Init();
            Reset();
        });
    }
    public static void Init()
    {
        AssetLoaderMgr = UnitySingleton<AssetLoaderManager>.Ins;
        NetMgr = UnitySingleton<NetworkManager>.Ins;
        UIMgr = UnitySingleton<UIManager>.Ins;
        AudioMgr = UnitySingleton<AudioManager>.Ins;
        LuaMgr = UnitySingleton<LuaManager>.Ins;
    }


    public static void Reset()
    {
        AssetLoaderMgr.Init();
        NetMgr.Init();
        UIMgr.Init();
        AudioMgr.Init();
        LuaMgr.Init();
    }


    public static void Test()
    {
        print("GApp.Test() ");
    }
    public static void Test2(string  k)
    {
        print("GApp.Test() :" + k);
    }

    public void Test3(string k)
    {
        print("GApp.Test() :" + k);
    }
}