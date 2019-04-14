using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UI;

public class Clock : MonoBehaviour {

    private void Start()
    {
        gameObject.SetActive(false);
    }

    public void TimeDown(int s,Action onLoad = null)
    {
        gameObject.SetActive(true);
        StartCoroutine(ieTimeDown(s, onLoad));
    }

    private IEnumerator ieTimeDown(int s ,Action onLoad)
    {
        var timeText = transform.GetComponentInChildren<Text>();
        var ac = transform.GetComponentInChildren<AudioSource>();
       
        timeText.text = s.ToString();
        ac.Play();

        while (s >= 0)
        {
            yield return new WaitForSeconds(1);
            s--;
            timeText.text = s.ToString();
            ac.Play();
        }

        transform.gameObject.SetActive(false);
        if (onLoad != null)
            onLoad();

    }
}
