using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;
using XLua;


public class ResPath
{
    private static string Url = "http://111.230.129.194/res/AssetBundles/";

    public static string Platform
    {
        get
        {
            switch (Application.platform)
            {
                case RuntimePlatform.Android:   //安卓
                    return "Android";
                case RuntimePlatform.IPhonePlayer:  //Iphone
                    return "IOS";
                case RuntimePlatform.WindowsEditor: //windows
                    return "Windows";
                case RuntimePlatform.WindowsPlayer:
                    return "Windows";
                default:
                    return "Windows";
            }
        }
    }
    public static string ManifestName
    {
        get { return "/" +  Platform; }
    }

    public static string RomotePath
    {
        get { return Url + Platform; }
    }

    public static string LocalPath
    {
        get { return Application.persistentDataPath + "/Res"; }
    }
}

[XLua.LuaCallCSharp]
[XLua.CSharpCallLua]
public class AssetUpdateHelper : MonoBehaviour
{

    private WWW wwwNewManifest;
    private List<string> lUpdateFile = new List<string>();

    private UIResUpdate uiRes;

    private void Awake()
    {
    }

    void Start()
    {
        
    }

    private void GameInit()
    {
        //游戏初始化
        GApp.Init();
        GApp.Reset();
        
    }
    public void Init()
    {
        uiRes = GetComponentInChildren<UIResUpdate>(true);
        uiRes.gameObject.SetActive(true);
    }

    public void Test()
    {
        Debug.Log("very good");
    }

    public void Test(Action onLoad)
    {
        Debug.Log("very very good");
        onLoad();
    }

    public void StartUpdateAssets(Action onLoad = null)
    {
        StartCoroutine(ieCheckResources(() =>
                StartCoroutine(ieUpdateResources(() =>
                    {
                        if (onLoad != null)
                            onLoad();
                    })
                )
            )
        );
    }

    /// <summary>
    /// 资源校验
    /// </summary>
    /// <param name="onLoad"></param>
    /// <returns></returns>
    IEnumerator ieCheckResources(Action onLoad = null)
    {
        string url = ResPath.RomotePath + ResPath.ManifestName;
        print(url);
        wwwNewManifest = new WWW(url);
        yield return wwwNewManifest;

        if (!string.IsNullOrEmpty(wwwNewManifest.error))
        {
            Debug.Log("获取AssetBundleManifest出错！");
            yield break;
        }

        uiRes.ShowTips("正在校验资源，请耐心等待......");
        //获取网络新资源的总依赖
        AssetBundle newManifestAssetBundle = wwwNewManifest.assetBundle;
        var newManifest = newManifestAssetBundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        string[] allNewAssetBundles = newManifest.GetAllAssetBundles();
        newManifestAssetBundle.Unload(false); //释放AssetBundle

        string localManifestPath = ResPath.LocalPath + ResPath.ManifestName;
        //Debug.Log("localManifestPath : "+ localManifestPath);
        if (File.Exists(localManifestPath))
        {
            WWW wwwLocalManifest = new WWW("file://" + localManifestPath);
            yield return wwwLocalManifest;
            if (!string.IsNullOrEmpty(wwwLocalManifest.error))
            {
                Debug.Log("获取本地AssetBundleManifest出错！");
                yield break;
            }

            //获取本地资源
            AssetBundle localManifestAssetBundle = wwwLocalManifest.assetBundle;
            var localManifest = localManifestAssetBundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
            var allLocalAssetBundles = new List<string>(localManifest.GetAllAssetBundles());
            localManifestAssetBundle.Unload(false); //释放AssetBundle
                                                    //
            for (int i = 0; i < allNewAssetBundles.Length; i++)
            {
                if (allLocalAssetBundles.Contains(allNewAssetBundles[i]))
                {
                    var newHashID = newManifest.GetAssetBundleHash(allNewAssetBundles[i]);
                    var localHashID = localManifest.GetAssetBundleHash(allNewAssetBundles[i]);
                    if (newHashID != localHashID)
                    {
                        Debug.Log(string.Format("校验资源名称： {0}  HashID：old-{1}  new-{2}", allNewAssetBundles[i],
                            localHashID, newHashID));
                        lUpdateFile.Add(allNewAssetBundles[i]);
                    }
                }
                else
                {
                    Debug.Log(string.Format("校验资源名称： {0}  HashID：{1}", allNewAssetBundles[i],
                        newManifest.GetAssetBundleHash(allNewAssetBundles[i])));
                    lUpdateFile.Add(allNewAssetBundles[i]);
                }
            }
        }
        else
        {
            //第一次运行游戏 没有本地manifest
            for (int i = 0; i < allNewAssetBundles.Length; i++)
            {
                Debug.Log(string.Format("校验资源名称： {0}  HashID：{1}", allNewAssetBundles[i],
                    newManifest.GetAssetBundleHash(allNewAssetBundles[i])));
                lUpdateFile.Add(allNewAssetBundles[i]);
            }
        }

        if (onLoad != null)
            onLoad();
    }

    /// <summary>
    /// 资源更新
    /// </summary>
    /// <param name="onLoad"></param>
    /// <returns></returns>
    IEnumerator ieUpdateResources(Action onLoad = null)
    {
        if (lUpdateFile.Count != 0)
        {
            uiRes.ShowTips("正在更新资源，请耐心等待......");

            for (int i = 0; i < lUpdateFile.Count; i++)
            {
                uiRes.ShowProcess((float)(i + 1) / lUpdateFile.Count);
                yield return StartCoroutine(ieDownload(lUpdateFile[i]));
            }
            //保存Manifest
            string savePath = ResPath.LocalPath + ResPath.ManifestName;
            SaveBytes(savePath, wwwNewManifest.bytes);
        }

        uiRes.ShowTips("资源更新完成，祝您游戏愉快。");
        uiRes.gameObject.SetActive(false);

        if (onLoad != null)
            onLoad();
    }
    /// <summary>
    /// 资源下载WWW方式
    /// </summary>
    /// <param name="bundleName"></param>
    /// <returns></returns>
    IEnumerator ieDownload(string  bundleName)
    {
        string url = ResPath.RomotePath + "/" + bundleName;
        WWW www = new WWW(url);
        yield return www;
        if (!string.IsNullOrEmpty(www.error))
        {
            Debug.Log("资源下载出错：" + url + "            " + www.error.ToString());
        }

        string savePath = ResPath.LocalPath + "/" + bundleName;
        SaveBytes(savePath,www.bytes);
    }
    /// <summary>
    /// 资源下载UnityWebRequest方式
    /// </summary>
    /// <param name="bundleName"></param>
    /// <returns></returns>
    IEnumerator ieWebRequestDown(string bundleName)
    {
        string url = ResPath.RomotePath + "/" + bundleName;
        UnityWebRequest request = UnityWebRequest.Get(url);
        request.timeout = 30;
        yield return request.SendWebRequest();

        if (request.isNetworkError)
        {
            Debug.Log("资源下载出错：" + url + "            " + request.error.ToString());
        }
        string savePath = ResPath.LocalPath + "/" + bundleName;
        SaveBytes(savePath, request.downloadHandler.data);
    }
    /// <summary>
    /// 保存资源到本地
    /// </summary>
    /// <param name="fulldName"></param>
    /// <param name="bytes"></param>
    void SaveBytes(string fulldName,byte[] bytes)
    { 
        if (File.Exists(fulldName))
            File.Delete(fulldName);

        string foldName = fulldName.Substring(0, fulldName.LastIndexOf("/"));
        if (!Directory.Exists(foldName))
            Directory.CreateDirectory(foldName);

        using (FileStream fs = new FileStream(fulldName, FileMode.Create))
        {
            using (BinaryWriter bw = new BinaryWriter(fs))
            {
                bw.Write(bytes); //写入
                bw.Flush(); //清空缓冲区
                bw.Close(); //关闭流
            }
            fs.Close();
        }
    }
}



