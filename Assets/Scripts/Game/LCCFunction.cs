using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[XLua.LuaCallCSharp]
public class LCCFunction  {

    /// <summary>
    /// 账号校验
    /// </summary>
    public static string MatchAccout(string acc)
    {
        if (acc.Length > 11 ||acc.Length<4)
            return "注册失败，账号长度为4-11位";
        if(acc.Contains("钱") && acc.Contains("杰"))
            return "注册失败，账号不符合规则";
        return "";
    }
}
