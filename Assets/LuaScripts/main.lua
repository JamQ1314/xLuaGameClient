--HelpCs = go:AddComponent(typeof(CS.DoTest))
--HelpCs = CS.UnityEngine.GameObject("AssetUpdateHelper"):AddComponent(typeof(CS.AssetUpdateHelper))
-- 资源更新
--local asset_helper = CS.UnityEngine.GameObject.FindObjectOfType(typeof(CS.AssetUpdateHelper))
--asset_helper:UpdateAssets(GameInit)
--asset_helper:Test(main.xxtest)
WWW = CS.UnityEngine.WWW;
GameObject = CS.UnityEngine.GameObject;
Color = CS.UnityEngine.Color;
Vector3 = CS.UnityEngine.Vector3;

require "UnitTest.CommonTest"

require "Common.GameManager"
GameManager.Start()
