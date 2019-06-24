using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class EditorCommTools : Editor {

    [MenuItem("Tools/SwitchMode/全部本地")]
    static void Switch1()
    {
        SwitchMode("DEV_LOCAL");
    }

    static void SwitchMode(string ndev)
    {
        //PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android, sdev);
        var defines = PlayerSettings.GetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android);
        var arrDefines = defines.Split(';');
        bool isSwitch = false;
        for (int i = 0; i < arrDefines.Length; i++)
        {
            if (arrDefines[i].Contains("DEV_"))
            {
                defines = defines.Replace(arrDefines[i], ndev);
                isSwitch = true;
                break;
            }
        }

        if (!isSwitch)
        {
            defines += ";" + ndev;
        }

        PlayerSettings.SetScriptingDefineSymbolsForGroup(BuildTargetGroup.Android,defines);
    }
}
