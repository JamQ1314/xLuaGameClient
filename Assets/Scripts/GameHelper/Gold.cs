using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Gold : MonoBehaviour {

    public void XGold(int xgold)
    {
        StartCoroutine(ieXGold(xgold));
    }


    private IEnumerator ieXGold(int xgold)
    {
        int cGold = int.Parse(transform.GetComponent<Text>().text);
        int eGold = cGold + xgold;
        int speed = xgold / Mathf.Abs(xgold);


        AudioSource audio = GetComponent<AudioSource>();
        if (audio != null)
        {
            audio.loop = true;
            audio.Play();
        }

        while (cGold != eGold)
        {
            cGold += speed;
            transform.GetComponent<Text>().text = cGold.ToString();
            yield return new WaitForEndOfFrame();
        }

        if ( audio != null)
        {
            audio.Stop();
        }
    }

}
