using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

public class DoTest : MonoBehaviour
{


	// Use this for initialization
    void Start()
    {
       var BYTES =  BitConverter.GetBytes(256);

        string str = "";
        for (int i = 0; i < BYTES.Length; i++)
        {
            str += BYTES[i] + " ";
        }
    }
	
	// Update is called once per frame
	void Update () {
		
	}



}
