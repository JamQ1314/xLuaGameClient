using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ManagerBase : MonoBehaviour
{
    protected Dictionary<string, GameObject> dictGameObjects;
    /// <summary>
    /// 管理器初始化函数
    /// </summary>
    public virtual void Init()
    {
        dictGameObjects = new Dictionary<string, GameObject>();
    }

    #region 缓存注册物体

    public void RegisterGameObject(GameObject go)
    {
        if (dictGameObjects.ContainsKey(go.name))
        {
            Debug.LogError("物体注册失败，名字已存在：" + go.name);
            return;
        }
        dictGameObjects.Add(go.name, go);
    }

    public void RemoveGameObject(GameObject go)
    {
        if (!dictGameObjects.ContainsKey(go.name))
        {
            return;
        }

        dictGameObjects.Remove(go.name);
    }

    public GameObject GetGameObject(string name)
    {
        if (!dictGameObjects.ContainsKey(name))
        {
            return null;
        }
        return dictGameObjects[name];
    }

    #endregion
}