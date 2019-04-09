using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using XLua;

[LuaCallCSharp]
public class UIEventListener : EventTrigger
{
    public Action<GameObject> onClick;

    public static UIEventListener Get(Transform transform)
    {
        var go = transform.gameObject;
        UIEventListener listener = go.GetComponent<UIEventListener>();
        if (listener == null) listener = go.AddComponent<UIEventListener>();
        return listener;
    }

    public override void OnPointerClick(PointerEventData eventData)
    {
        base.OnPointerClick(eventData);
        if (onClick != null)
            onClick(gameObject);
    }
}
