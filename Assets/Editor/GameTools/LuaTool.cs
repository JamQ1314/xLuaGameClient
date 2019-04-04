using System;
using System.IO;
using UnityEditor;
using UnityEngine;

public class LuaTool : Editor
{
    static string srcPath = Application.dataPath + "/LuaScripts";
    static string dstPath = Application.dataPath + "/ABGame/lua";

    [MenuItem("Tools/Lua/Delete")]
    static void Del()
    {
        if (!Directory.Exists(dstPath))
            Directory.CreateDirectory(dstPath);
        else
            ClearDir(dstPath);

        AssetDatabase.Refresh();
    }

    [MenuItem("Tools/Lua/Copy")]
    static void Copy()
    {
        if (!Directory.Exists(dstPath))
            Directory.CreateDirectory(dstPath);
        else
            ClearDir(dstPath);
        //复制
        CopyLuaScirpts(srcPath);

        AssetDatabase.Refresh();
    }

 

    /// <summary>
    /// 清空ABGame/lua文件夹下所有文件
    /// </summary>
    /// <param name="dstPath"></param>
    static void ClearDir(string dstPath)
    {
        if (!Directory.Exists(dstPath))
            return;
        DirectoryInfo dir = new DirectoryInfo(dstPath);
        FileSystemInfo[] fileinfo = dir.GetFileSystemInfos(); //返回目录中所有文件和子目录
        foreach (FileSystemInfo i in fileinfo)
        {
            if (i is DirectoryInfo) //判断是否文件夹
            {
                DirectoryInfo subdir = new DirectoryInfo(i.FullName);
                subdir.Delete(true); //删除子目录和文件
            }
            else
            {
                File.Delete(i.FullName); //删除指定文件
            }
        }
    }

    static void CopyLuaScirpts(string ptah)
    {
        DirectoryInfo info = new DirectoryInfo(ptah);
        foreach (var file in info.GetFiles())
        {
            if (file.Extension == ".meta")
                continue;
            var srcFullName = file.FullName.Replace("\\","/");
            var dstFullName = srcFullName.Replace(srcPath, dstPath) + ".txt";
            file.CopyTo(dstFullName);
        }

        foreach (var dir in info.GetDirectories())
        {
            Debug.Log("-------------------- " + dir.FullName);

            var srcDirName = dir.FullName.Replace("\\","/");
            var dstDirName = srcDirName.Replace(srcPath, dstPath);
            Directory.CreateDirectory(dstDirName);
            CopyLuaScirpts(srcDirName);
        }
    }
}
