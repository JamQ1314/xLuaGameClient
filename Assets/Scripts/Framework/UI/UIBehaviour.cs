using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class UIBehaviour : MonoBehaviour {

    private void Awake()
    {
        GApp.UIMgr.RegisterGameObject(gameObject);
    }
    private void OnDestroy()
    {
        GApp.UIMgr.RemoveGameObject(gameObject);
    }

    public void AddClickListener(UnityAction onEvent)
    {
        if (onEvent != null)
            GetComponent<Button>().onClick.AddListener(onEvent);
    }

    public void AddSliderValueChangeListener(UnityAction<float> onEvent)
    {
        if (onEvent != null)
            GetComponent<Slider>().onValueChanged.AddListener(onEvent);
    }

    public void AddInputValueChangeListener(UnityAction<string> onEvent)
    {
        if (onEvent != null)
            GetComponent<InputField>().onValueChanged.AddListener(onEvent);
    }

    public void AddToggleListener(UnityAction<bool> onEvent)
    {
        if (onEvent != null)
            GetComponent<Toggle>().onValueChanged.AddListener(onEvent);
    }
}
