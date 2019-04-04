using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIResUpdate : MonoBehaviour
{
    private Slider loadProcessBar;
    private Text loadInfo;
    private Text loadProcessValue;

    private Button closeBtn;
    private void Awake()
    {
        loadProcessBar = UnityTools.FindChild(transform, "bar").GetComponent<Slider>();
        loadInfo = UnityTools.FindChild(transform, "info").GetComponent<Text>();
        loadProcessValue = UnityTools.FindChild(transform, "value").GetComponent<Text>();
        closeBtn = UnityTools.FindChild(transform, "btn").GetComponent<Button>();

        Init();
    }

    private void Init()
    {
        loadProcessBar.value = 0;
        loadInfo.text = "正在校验资源，请耐心等待......";
        loadProcessValue.text = "";

        closeBtn.onClick.AddListener(() => { Application.Quit();});
    }

    public void ShowNetError()
    {
        UnityTools.FindChild(transform, "Tips").gameObject.SetActive(true);
    }
    public void ShowTips(string msg)
    {
        loadInfo.text = msg;
    }

    public void ShowProcess(float value)
    {
        StartCoroutine(ieShowProcess(value));

    }

    private IEnumerator ieShowProcess(float value)
    {
        var tempValue = loadProcessBar.value;
        if (tempValue > value)
            tempValue = 0;
        while (tempValue < value)
        {
            tempValue += 0.01f;
            loadProcessBar.value = tempValue;
            loadProcessValue.text = (int)(tempValue * 100) + "%";
            yield return new WaitForEndOfFrame();
        }
    }
}
