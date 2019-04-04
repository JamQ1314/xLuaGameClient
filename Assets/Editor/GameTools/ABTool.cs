using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class ABTool : EditorWindow
{
    private static string abPath;
    private static string outPath;

    private static bool isDependencies = false;

    private static string abFolder = "ABGame";

    private static string tip = "请选择要打包的平台...";

    private static bool IsWindows;
    private static bool IsAndroid;
    private static bool IsApple;

//    [MenuItem("Tools/AssetBundle/Mark/Main Mark")]
//    static void Mark()
//    {
//        isDependencies = false;
//        //abPath = ...\QsFrame\Assets\ABGame
//        abPath = Path.Combine(Application.dataPath, abFolder).Replace("\\", "/");
//        GetFiles(abPath);
//    }

    [MenuItem("Tools/AssetBundle/Mark")]
    static void Mark2()
    {
        isDependencies = true;
        //abPath = ...\QsFrame\Assets\ABGame
        abPath = Path.Combine(Application.dataPath, abFolder).Replace("\\", "/");
        GetFiles(abPath);
    }

    [MenuItem("Tools/AssetBundle/Build")]
    static void Build()
    {
        abPath = Path.Combine(Application.dataPath, abFolder).Replace("\\", "/");

        outPath = Path.Combine(Environment.CurrentDirectory, "AssetBundles").Replace("\\", "/");


        ABTool abWindow = (ABTool)EditorWindow.GetWindow(typeof(ABTool), false, "ABTool", true);
        abWindow.Show();

    }

    [MenuItem("Tools/AssetBundle/Clear")]
    static void Clear()
    {
        string[] markedAssets = AssetDatabase.GetAllAssetBundleNames();
        for (int i = 0; i < markedAssets.Length; i++)
        {
            Debug.Log(markedAssets[i]);
            AssetDatabase.RemoveAssetBundleName(markedAssets[i], true);
        }

    }
    private void OnGUI()
    {
        GUI.color = Color.cyan;
        GUI.skin.label.fontSize = 20;
        GUILayout.Label(tip);

        GUI.skin.label.fontSize = 10;
        GUI.skin.label.alignment = TextAnchor.MiddleLeft;

        //放3个togle
        IsWindows = GUI.Toggle(new Rect(10, 60, 600, 20), IsWindows, "打包到Windows平台");

        IsAndroid = GUI.Toggle(new Rect(10, 80, 600, 20), IsAndroid, "打包到Android平台");

        IsApple = GUI.Toggle(new Rect(10, 100, 600, 20), IsApple, "打包到IOS平台");

        if (GUI.Button(new Rect(0, 140, 200, 30), "开始打包"))
        {
            BuildAllPlatform();
        }
    }

    #region 遍历资源

    private static void GetFiles(string path)
    {
        DirectoryInfo info = new DirectoryInfo(path);

        var files = info.GetFiles();
        var dirs = info.GetDirectories();
        for (int i = 0; i < files.Length; i++)
        {
            if (files[i].Extension != ".meta")
                DoMark(files[i]);
        }

        for (int i = 0; i < dirs.Length; i++)
        {
            GetFiles(dirs[i].FullName);
        }
    }

    static void DoMark(FileInfo file)
    {
        //资源在项目下的路径Assets/.../...
        var absFilePath = file.FullName.Replace("\\", "/");
        var projectPath = Directory.GetCurrentDirectory().Replace("\\", "/") + "/";
        string pathBellowProject = absFilePath.Replace(projectPath, string.Empty);
        //加载资源 路径必须为 Assets/.../...
        AssetImporter importer = AssetImporter.GetAtPath(pathBellowProject);
        //资源在ABGame文件夹下的路径
        string abName = absFilePath.Replace(abPath + "/", "");
        //修改场景文件的后缀
        string abNameExtension = file.Extension == ".unity" ? ".Scene" : "";
        abName = abName.Replace(file.Extension, abNameExtension);
        importer.assetBundleName = abName;
        Debug.Log(string.Format("<color=yellow>==>资源路径（{0}）标记名称：{1} </color> ", pathBellowProject, abName));
        //获取文件依赖
        if (isDependencies)
        {
            string[] dps = AssetDatabase.GetDependencies(pathBellowProject);
            if (dps.Length > 0)
            {
                for (int i = 0; i < dps.Length; i++)
                {
                    if (pathBellowProject == dps[i] || dps[i].EndsWith(".cs"))
                        continue;
                    Debug.Log(string.Format("资源（{0}）相关依赖：{1}  AssetPathToGUID:{2}", abName, dps[i], AssetDatabase.AssetPathToGUID(dps[i])));
                    string dpsName = "Dependencies/" + AssetDatabase.AssetPathToGUID(dps[i]);
                    AssetImporter importer2 = AssetImporter.GetAtPath(dps[i]);
                    importer2.assetBundleName = dpsName;
                }
            }
        }
    }

    static void AddAssetBundleBuild(FileInfo file)
    {
        AssetBundleBuild abb = new AssetBundleBuild();
        //var abName = file.Name.Remove(file.Name.IndexOf("."));

        string abName = file.FullName.Replace(abPath+"/", "");
        string abNameExtension = file.Extension == ".unity"? ".Scene":"";
        abName = abName.Replace(file.Extension, abNameExtension);
        abb.assetBundleName = abName;

        string truePath = file.FullName.Replace(Directory.GetCurrentDirectory() + "/", string.Empty);
        abb.assetNames = new string[1] { truePath };
    }
    #endregion

    #region  打包AB

    static void BuildAllPlatform()
    {
        CheckFold();
        if (IsWindows)
            BuildByPlatfrom(BuildTarget.StandaloneWindows);
        if (IsAndroid)
            BuildByPlatfrom(BuildTarget.Android);
        if (IsApple)
            BuildByPlatfrom(BuildTarget.iOS);

        tip = "打包完成......";
        Application.OpenURL(outPath);
    }

    static void BuildByPlatfrom(BuildTarget target)
    {
        string foldName = "";
        switch (target)
        {
            case BuildTarget.StandaloneWindows:
                foldName = "Windows";
                break;
            case BuildTarget.Android:
                foldName = "Android";
                break;
            case BuildTarget.iOS:
                foldName = "IOS";
                break;
        }
        tip = "当前正在打包"+foldName+"资源，请等待...";

        
        //if (EditorUserBuildSettings.activeBuildTarget != target)
            //EditorUserBuildSettings.SwitchActiveBuildTarget(target);
//        BuildPipeline.BuildAssetBundles(outPath + "/" + foldName,null, BuildAssetBundleOptions.None, target);
        BuildPipeline.BuildAssetBundles(outPath + "/" + foldName, BuildAssetBundleOptions.None, target);

    }


    static void CheckFold()
    {
        if (!Directory.Exists(outPath))
        {
            Directory.CreateDirectory(outPath);
            Directory.CreateDirectory(outPath + "/Windows");
            Directory.CreateDirectory(outPath + "/Android");
            Directory.CreateDirectory(outPath + "/IOS");
        }
        else
        {
            string bakPath = outPath + "(" + string.Format("{0:yyyy年MM月dd日HH时mm分ss秒}", DateTime.Now) + ")";

            DirectoryInfo info = new DirectoryInfo(outPath);
            info.MoveTo(bakPath);

            CheckFold();
        }
    }
    #endregion
}
