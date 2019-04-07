#define XLUA
//#define XLUA
//#define SLUA
//#define TOLUA
//#define ULUA

using System;
using System.Runtime.InteropServices;

//For XLua add the following code to XLua.LuaEnv.LuaEnv() makes to enable loading of LuaDebuggee.dll/so:
//AddSearcher(LuaPerfect.LuaDebuggeeLoader.LoadLuaDebuggee, -1);

namespace LuaPerfect
{
    class LuaDebuggeeLoader
    {
#if XLUA
        [XLua.MonoPInvokeCallback(typeof(XLua.LuaDLL.lua_CSFunction))]
        public static int LoadLuaDebuggee(IntPtr L)
        {
            try
            {
                string libararyName = XLua.LuaDLL.Lua.lua_tostring(L, 1);
                if (libararyName == "LuaDebuggee")
                {
                    XLua.LuaDLL.Lua.lua_pushstdcallcfunction(L, luaopen_LuaDebuggee);
                }
                return 1;
            }
            catch (System.Exception e)
            {
                return XLua.LuaDLL.Lua.luaL_error(L, "C# exception in LuaPerfect.LuaDebuggeeLoader.LoadLuaDebuggee():" + e);
            }
        }
#endif

        [DllImport("LuaDebuggee", CallingConvention = CallingConvention.Cdecl)]
        private static extern int luaopen_LuaDebuggee(IntPtr L);
    }
}