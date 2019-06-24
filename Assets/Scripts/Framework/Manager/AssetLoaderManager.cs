using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class AssetLoaderManager : ManagerBase
{
    /// <summary>
    /// 总依赖文件
    /// </summary>
    private AssetBundleManifest manifest;
    /// <summary>
    /// 记录资源名称-路径对应关系
    /// </summary>
    private Dictionary<string, string> dictAssets;
    /// <summary>
    /// 加载到缓存资源
    /// </summary>
    private List<AssetBundle> lCacheDenpendences;
    public override void Init()
    {
        base.Init();
        manifest = null;
        dictAssets = new Dictionary<string, string>();
        lCacheDenpendences = new List<AssetBundle>();
#if !DEV_LOCAL
        LoadLocalManifest();
#endif
    }
    /// <summary>
    /// 加载总依赖文件
    /// </summary>
    private void LoadLocalManifest()
    {
        string manifestPath = ResPath.LocalPath + ResPath.ManifestName;
        AssetBundle manifestAssetBundle = AssetBundle.LoadFromFile(manifestPath);
        manifest = manifestAssetBundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        string[] allAssetBundles = manifest.GetAllAssetBundles();
        manifestAssetBundle.Unload(false);//释放AssetBundle

        for (int i = 0; i < allAssetBundles.Length; i++)
        {
            string tempAssetName = allAssetBundles[i];
            if (tempAssetName.Contains("/"))
            {
                var splits = tempAssetName.Split('/');
                tempAssetName = splits[splits.Length - 1];
            }
            dictAssets.Add(tempAssetName, allAssetBundles[i]);
        }
        //UnityTools.LogDictionary(dictAssets);
    }

    /// <summary>
    /// 加载资源
    /// </summary>
    /// <typeparam name="T">type</typeparam>
    /// <param name="name"></param>
    /// <returns></returns>
    public T Load<T>(string name) where T: UnityEngine.Object
    {
        if (!dictAssets.ContainsKey(name.ToLower()))
        {
            Debug.LogWarning("asset is not exist : " + name);
            return default(T);
        }
        string abName = dictAssets[name.ToLower()];

        //Debug.Log(string.Format("<Load Asset , name :"+ name +"    abName :"+ abName));
        //加载依赖
        string[] dps = manifest.GetAllDependencies(abName);
        if (dps.Length != 0)
        {
            foreach (string dp in dps)
            {
                //Debug.Log(string.Format("正在加载资源{0}依赖：{1}", name, dp));
                LoadAssetBundle(dp);
            }
        }
        AssetBundle ab = LoadAssetBundle(abName);
        return ab.LoadAsset<T>(name.ToLower());
    }

    /// <summary>
    /// 加载并且实例化
    /// </summary>
    /// <param name="name"></param>
    /// <returns></returns>
    public GameObject LoadAsset(string assetName)
    {

#if DEV_LOCAL
            assetName = assetName.Replace(".", "/") +".prefab";
            string fullName = "Assets/ABGame/" + assetName;
            return (GameObject)Instantiate(UnityEditor.AssetDatabase.LoadAssetAtPath<Object>(fullName));
#else
            var tagName = assetName.Substring(assetName.LastIndexOf(".") + 1);
            Object o = Load<Object>(tagName);
            GameObject go = (GameObject)Instantiate(o);
            return go;
#endif
    }

    /// <summary>
    /// 加载AssetBundle
    /// </summary>
    /// <param name="abName"></param>
    /// <returns></returns>
    private AssetBundle LoadAssetBundle(string abName)
    {
        string abPath = ResPath.LocalPath + "/" + abName;
        //方法1
        //AssetBundle ab = AssetBundle.LoadFromFile(ResPath.LocalPath + "/" + abName);
        //方法2
        //WWW www = WWW.LoadFromCacheOrDownload(@"file:/"+ ResPath.LocalPath + "/" + abName,1);
        AssetBundle ab = AssetBundle.LoadFromMemory(File.ReadAllBytes(abPath));
        lCacheDenpendences.Add(ab);
        return ab;
    }
    /// <summary>
    /// 释放缓存中的资源
    /// </summary>
    public void Release()
    {
        lock (lCacheDenpendences)
        {
            for (int i = 0; i < lCacheDenpendences.Count; i++)
            {
                lCacheDenpendences[i].Unload(false);
            }
            lCacheDenpendences.Clear();
        }
    }
}
