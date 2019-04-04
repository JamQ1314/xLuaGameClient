public enum NET_EVENT_ID
{
    MAIN_ID,
    GAME_ID,
}


public enum MAIN_ID
{
    WXLogin = 0,    //微信登录
    QQLogin,        //QQ登录
    CMLogin,        //游客登录

    //Call Back
    Login_Success = 100,
    Login_Failuer
}