using System.Collections;
using System;
using UnityLogic;
using UnityEngine;
using System.Diagnostics;

public class GameManager : Agent
{
    [SerializeField]
    GameObject pfBox;

    [SerializeField]
    GameObject[] pickupAreas;
    Stopwatch stopWatch ;
    private int number = 0;
    private int numberRecieved=0;
    public string kbPath = "KBs/PrologFile";
    public string kbName = "KbName";

    void Start()
    {
        Init(kbPath, kbPath);
        stopWatch = new Stopwatch();
        stopWatch.Start();
    }

    public GameObject SpawnBox(GameObject startPickupArea, GameObject destPickupArea)
    {
        UnityEngine.Debug.Log("Should created a new Objects");
        GameObject boxObject = Instantiate(pfBox, startPickupArea.transform.position + new Vector3(0, 2.5f, 0), Quaternion.identity);
        boxObject.name = "Box " + ++number;

        Box box = boxObject.GetComponent<Box>();
        box.start = startPickupArea;
        box.destination = destPickupArea;

        UnityEngine.Debug.Log("Created " + boxObject.name + ". Start is " + startPickupArea.transform.parent.name + ". Destination is " + destPickupArea.transform.parent.name + ".");
        return boxObject;
    }

    public GameObject GetArea(int index)
    {
        return pickupAreas[index];
    }

    public GameObject GetArea()
    {
        return pickupAreas[UnityEngine.Random.Range(0, pickupAreas.Length)];
    }

    public IEnumerator WaitForSeconds(float seconds)
    {
        float time = 0;

        while (time < seconds)
        {
            time += Time.deltaTime;
            yield return null;
        }
    }

    // print whatever you want on the console from a UnityProlog plan
    public void PrintLog(object str)
    {
        UnityEngine.Debug.Log(str.ToString());
    }

    public void notify()
    {
        lock (this)  {
        numberRecieved=numberRecieved+1;
        UnityEngine.Debug.Log("Number of deliveried box is "+numberRecieved);
        if(numberRecieved==number) {
            stopWatch.Stop();
            TimeSpan ts = stopWatch.Elapsed;
            string elapsedTime = string.Format("{0:00}:{1:00}:{2:00}.{3:00}",
            ts.Hours, ts.Minutes, ts.Seconds,
            ts.Milliseconds / 10);
            UnityEngine.Debug.Log("RunTime " + elapsedTime);
            UnityEngine.Debug.Log("RunTime seconds " + ts.TotalSeconds);
        }
        }
    }
}
