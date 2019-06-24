using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;



[LuaCallCSharp]
public class GApp :MonoBehaviour
{
    public static GApp Ins;
    public string server_addr = "127.0.0.1";
    public int server_port = 5566;
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


#if DEV_LOCAL
        Init();
        Reset();
#else
        var help = GetComponent<AssetUpdateHelper>();
            help.Init();
            help.StartUpdateAssets(delegate
            {
                Init();
                Reset();
            });
#endif
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
}