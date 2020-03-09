using System.Collections.Generic;
using System.IO;
using taecg.tools.mobileFastShadow;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(TileMapGraph), true)]
public class TileMapGraphEditor : EditorBase
{
    private TileMapGraph tileMap;

    private bool showBuildMap = true;
    private bool showAstar = true;

    [DrawGizmo(GizmoType.InSelectionHierarchy|GizmoType.NonSelected)]
    private static void DrawSceneRect(TileMapGraph go, GizmoType gizmoType)
    {
        go.OnDrawGizmosSelected();
    }

    private void OnEnable()
    {
        tileMap = target as TileMapGraph;
    }

    private void OnSceneGUI()
    {
        Ray ray = HandleUtility.GUIPointToWorldRay(Event.current.mousePosition);
        RaycastHit hitInfo;
        bool hasChange = false;
        if (Physics.Raycast(ray, out hitInfo, 2000, 1 << GameUtil.MapLayer))
        {
            float x = hitInfo.point.x;
            float z = hitInfo.point.z;
            Event e = Event.current;
            if (e.isKey)
            {
                if (e.keyCode == KeyCode.A)
                {
                    tileMap.EditorObserver(x, z, TileType.Block);
                    hasChange = true;
                }
                if (e.keyCode == KeyCode.W)
                {
                    tileMap.EditorObserver(x, z, TileType.None);
                    hasChange = true;
                }
            }
        }
        if (hasChange)
        {
            RepaintSceneView();
        }
    }

    protected override void Inspector()
    {
        EditorGUILayout.BeginVertical("Box");
        showBuildMap = GUILayout.Toggle(showBuildMap, ("BuildMap"), GUI.skin.GetStyle("foldout"), GUILayout.ExpandWidth(true), GUILayout.Height(18));
        if (showBuildMap)
        {
            PropertyField("tilePrefabs");
            PropertyField("wallPrefabs");
            DrawColRowFields();
            if (GUILayout.Button("Build", GUILayout.Width(80)))
            {
                BuildMap();
            }
            if (GUILayout.Button("Repair", GUILayout.Width(80)))
            {
                RepairMap();
            }
            if (GUILayout.Button("Replace Models", GUILayout.Width(80)))
            {
                ReplaceSceneModel();
            }
        }
        EditorGUILayout.EndVertical();

        EditorGUI.BeginChangeCheck();

        EditorGUILayout.BeginVertical("Box");
        showAstar = GUILayout.Toggle(showAstar, ("Astar"), GUI.skin.GetStyle("foldout"), GUILayout.ExpandWidth(true), GUILayout.Height(18));
        if (showAstar)
        {
            DrawAstar();
        }
        EditorGUILayout.EndVertical();

        if (EditorGUI.EndChangeCheck())
        {
            RepaintSceneView();
        }
    }

    private void RepaintSceneView()
    {
        if (!Application.isPlaying || EditorApplication.isPaused)
        {
            SceneView.RepaintAll();
        }
    }

    private void DrawAstar()
    {
        //PropertyField("xNode", "width");
        //ClampInt("xNode", 1);
        //PropertyField("zNode", "depth");
        //ClampInt("zNode", 1);
        PropertyField("nodeSize");
        Clamp("nodeSize", 0.1f);

        if (GUILayout.Button("Scan", GUILayout.Width(80)))
        {
            BuildAstar2();
        }

        tileMap.drawGizmos = GUILayout.Toggle(tileMap.drawGizmos, ("Draw Gizmos"));
    }

    /*
    private void BuildAstar()
    {
        Transform tilemapTransform = tileMap.transform;
        Transform wall = tilemapTransform.Find("wall");
        Transform environment = tilemapTransform.Find("environment");
        Transform[] testList = new Transform[] { wall, environment };
        for(int t = 0; t < testList.Length; t++)
        {
            Transform testTf = testList[t];
            if(testTf == null)
            {
                continue;
            }
            BoxCollider[] colliders = testTf.gameObject.GetComponentsInChildren<BoxCollider>();
            foreach(BoxCollider box in colliders)
            {
                Transform tf = box.transform;
                Vector3 center =box.center;
                Vector3 halfExtents = box.size * 0.5f;
                Vector3 left_top = new Vector3(center.x - halfExtents.x, center.y, center.z + halfExtents.z);
                Vector3 left_bottom = new Vector3(center.x - halfExtents.x, center.y, center.z - halfExtents.z);
                Vector3 right_top = new Vector3(center.x + halfExtents.x, center.y, center.z + halfExtents.z);
                Vector3 right_bottom = new Vector3(center.x + halfExtents.x, center.y, center.z - halfExtents.z);

                Vector3[] lists = new Vector3[] { left_top, right_top, left_bottom, right_bottom};

                for(float x = left_top.x; x <= right_bottom.x; x += 0.1f)
                {
                    for(float z = left_top.z; z > right_bottom.z; z -= 0.1f)
                    {
                        Vector3 p = new Vector3(x, center.y, z);
                        p = tf.TransformPoint(p);
                        RaycastHit[] hitResults = GameUtil.Raycast(p, Vector3.down, 100, 1 << GameUtil.MapLayer);
                        for (int n = 0; n < hitResults.Length; n++)
                        {
                            RaycastHit hit = hitResults[n];
                            if (hit.collider != null && hit.collider.gameObject != null)
                            {
                                tileMap.EditorObserver(hit.point.x, hit.point.z, TileType.Block);
                            }
                        }
                    }
                }
                
                for(int i = 0; i < lists.Length; i++)
                {
                    Vector3 p = tf.TransformPoint(lists[i]);
                    RaycastHit[] hitResults = GameUtil.Raycast(p, Vector3.down, 100, 1 << GameUtil.MapLayer);
                    for (int n = 0; n < hitResults.Length; n++)
                    {
                        RaycastHit hit = hitResults[n];
                        if (hit.collider != null && hit.collider.gameObject != null)
                        {
                            tileMap.EditorObserver(hit.point.x, hit.point.z, TileType.Block);
                        }
                    }
                }
                
            }
        }
    }
    */

    private void BuildAstar2()
    {
        float nodeSize = tileMap.nodeSize;
        int xNode = tileMap.xNode;
        int zNode = tileMap.zNode;
        float yPos = 0f;
        float ySize = 100f;

        Vector3 offset = new Vector3(-xNode * nodeSize * 0.5f, 0, -zNode * nodeSize * 0.5f);

        tileMap.InitValues();
        for (int x = 0; x < tileMap.xNode; x++)
        {
            for (int z = 0; z < tileMap.zNode; z++)
            {
                Vector3 center = new Vector3(x * nodeSize + nodeSize * 0.5f, yPos, z * nodeSize + nodeSize * 0.5f) + offset;
                Vector3 halfExtents = new Vector3(nodeSize, ySize, nodeSize) * 0.5f;
                RaycastHit[] hitResults = GameUtil.BoxCastAll(center, halfExtents, Vector3.up, Quaternion.identity, 10, 1 << GameUtil.MapOutWallLayer | 1 << GameUtil.ObstructLayer);
                for (int n = 0; n < hitResults.Length; n++)
                {
                    RaycastHit hit = hitResults[n];
                    if (hit.collider != null && hit.collider.gameObject != null)
                    {
                        tileMap.SetTileValue(x, z, TileType.Block);
                    }
                }
            }
        }
    }

    private void DrawColRowFields()
    {
        GUILayout.BeginHorizontal();

        GUILayout.BeginVertical();
        PropertyField("width");
        Clamp("width", 1);
        PropertyField("length");
        Clamp("length", 1);
        GUILayout.EndVertical();

        GUILayout.EndHorizontal();
    }

    private void RepairMap()
    {
        Transform tilemapTransform = tileMap.transform;
        Transform floor = tilemapTransform.Find("floor");
        if (floor != null)
        {
            for (int i = 0; i < floor.childCount; i++)
            {
                Transform child = floor.GetChild(i);
                MeshFilter meshFilter = child.GetComponent<MeshFilter>();
                if (meshFilter != null)
                {
                    Vector3 childPos = child.position;
                    Mesh mesh = meshFilter.sharedMesh;
                    Bounds b = mesh.bounds;
                    Vector3 centerPos = child.TransformPoint(b.center);
                    childPos.y = -b.extents.y;
                    child.position = childPos;
                }
            }
        }
        Transform wall = tilemapTransform.Find("wall");
        if(wall != null)
        {
            for(int i = 0; i < wall.childCount; i++)
            {
                Transform child = wall.GetChild(i);
                Vector3 childPos = child.position;
                childPos.y = 0.0f;
                child.position = childPos;
            }
        }
    }

    private void BuildMap()
    {
        Transform tilemapTransform = tileMap.transform;
        Transform floor = tilemapTransform.Find("floor");
        if (floor == null)
        {
            floor = new GameObject("floor").transform;
            floor.SetParent(tilemapTransform);
            floor.localPosition = Vector3.zero;
            floor.localScale = Vector3.one;
        }
        floor.localScale = new Vector3(1, 1, 1.0f / Mathf.Sin(55.0f * Mathf.PI / 180.0f));

        Transform wall = tilemapTransform.Find("wall");
        if (wall == null)
        {
            wall = new GameObject("wall").transform;
            wall.SetParent(tilemapTransform);
            wall.localPosition = Vector3.zero;
            wall.localScale = Vector3.one;
        }
        Transform obstruct = tilemapTransform.Find("obstruct");
        if(obstruct == null)
        {
            obstruct = new GameObject("obstruct").transform;
            obstruct.SetParent(tilemapTransform);
            obstruct.localPosition = Vector3.zero;
            obstruct.localScale = Vector3.one;
        }
        Transform environment = tilemapTransform.Find("environment");
        if (environment == null)
        {
            environment = new GameObject("environment").transform;
            environment.SetParent(tilemapTransform);
            environment.localPosition = Vector3.zero;
            environment.localScale = Vector3.one;
        }

        GameObject cameraFollow = GameObject.Find("CameraFollow");
        if (cameraFollow == null)
        {
            GameObject prefabCameraFollow = AssetDatabase.LoadAssetAtPath<GameObject>("Assets/RawResources/Scene/Prefab/CameraFollow.prefab");
            cameraFollow = Instantiate(prefabCameraFollow);
            cameraFollow.name = "CameraFollow";
        }
        GameObject canvas = GameObject.Find("Canvas");
        if (canvas == null)
        {
            GameObject prefabCanvas = AssetDatabase.LoadAssetAtPath<GameObject>("Assets/RawResources/Scene/Prefab/Canvas.prefab");
            canvas = Instantiate(prefabCanvas);
            canvas.name = "Canvas";
        }
        GameObject mobileFastShadow = GameObject.Find("MobileFastShadow");
        if (mobileFastShadow == null)
        {
            GameObject prefabShadow = AssetDatabase.LoadAssetAtPath<GameObject>("Assets/RawResources/Scene/Prefab/MobileFastShadow.prefab");
            mobileFastShadow = Instantiate(prefabShadow);
            mobileFastShadow.name = "MobileFastShadow";
        }
        GameObject entityObj = GameObject.Find("entity");
        if (entityObj == null)
        {
            entityObj = new GameObject("entity");
            entityObj.transform.localPosition = Vector3.zero;

            GameObject heroObj = new GameObject("hero");
            heroObj.transform.SetParent(entityObj.transform);

            GameObject monsterObj = new GameObject("monster");
            monsterObj.transform.SetParent(entityObj.transform);
        }
        MobileFastShadow shadowCtrl = mobileFastShadow.GetComponent<MobileFastShadow>();
        shadowCtrl.FollowTarget = entityObj;
        GameUtil.SetLayer(entityObj.transform, GameUtil.PlayerLayer);

        if (tileMap.wallPrefabs != null && tileMap.wallPrefabs.Length > 0)
        {
            for (int i = wall.childCount - 1; i >= 0; i--)
            {
                DestroyImmediate(wall.GetChild(i).gameObject);
            }
            
            GameObject prefabWall = tileMap.wallPrefabs[0];
            MeshFilter mf = prefabWall.GetComponentInChildren<MeshFilter>();
            Mesh m = mf.sharedMesh;

            float yPos = m.bounds.center.y - m.bounds.extents.y;
            float grid = m.bounds.extents.x;
            float zg = m.bounds.extents.z;
            float xOffset = tileMap.width * grid * 2.0f * 0.5f;
            float zOffset = tileMap.length * grid * 2.0f * 0.5f;
            float[] xList = new float[] { 0, tileMap.width - 1 };
            float[] yList = new float[] { 0, tileMap.length - 1 };
            for (int i = 0; i < xList.Length; i++)
            {
                float x = xList[i];
                float xPos = 2 * (x + i) * grid - zg + i * zg * 2;
                for (int y = 0; y < tileMap.length; y++)
                {
                    float zPos = (2 * y) * grid + grid;
                    Transform tileChild = GameObject.Instantiate(prefabWall).transform;
                    tileChild.SetParent(wall);
                    tileChild.position = new Vector3(xPos - xOffset, yPos, zPos - zOffset);
                    tileChild.forward = Vector3.right;
                }
            }
            for (int i = 0; i < yList.Length; i++)
            {
                float y = yList[i];
                float zPos = 2 * (y + i) * grid - zg + i * zg * 2;
                for (int x = 0; x < tileMap.width; x++)
                {
                    float xPos = (2 * x) * grid + grid;
                    Transform tileChild = GameObject.Instantiate(prefabWall).transform;
                    tileChild.SetParent(wall);
                    tileChild.position = new Vector3(xPos - xOffset, yPos, zPos - zOffset);
                }
            }

        }

        if (tileMap.tilePrefabs != null && tileMap.tilePrefabs.Length > 0)
        {
            for (int i = floor.childCount - 1; i >= 0; i--)
            {
                DestroyImmediate(floor.GetChild(i).gameObject);
            }

            GameObject prefabObj = tileMap.tilePrefabs[0];

            MeshFilter mf = prefabObj.GetComponent<MeshFilter>();
            Mesh m = mf.sharedMesh;

            float colNum = tileMap.width + 10;
            float rowNum = tileMap.length + 15;
            float yPos = m.bounds.center.y - m.bounds.extents.y;
            float grid = m.bounds.extents.x;
            float zg = m.bounds.extents.z;
            float xOffset = colNum * grid * 2.0f * 0.5f;
            float zOffset = rowNum * grid * 2.0f * 0.5f;
            for (int x = 0; x < colNum; x++)
            {
                float xPos = (2 * x + 1) * grid;
                for (int y = 0; y < rowNum; y++)
                {
                    int idx = Random.Range(0, tileMap.tilePrefabs.Length);
                    prefabObj = tileMap.tilePrefabs[idx];

                    mf = prefabObj.GetComponent<MeshFilter>();
                    m = mf.sharedMesh;
                    yPos = m.bounds.center.y - m.bounds.extents.y;

                    float zPos = (2 * y + 1) * grid;
                    Transform tileChild = GameObject.Instantiate(prefabObj).transform;
                    tileChild.SetParent(floor);
                    tileChild.position = new Vector3(xPos - xOffset, yPos, zPos - zOffset);
                }
            }
        }

        GameUtil.SetLayer(floor, GameUtil.MapLayer);
        GameUtil.SetLayer(wall, GameUtil.MapOutWallLayer);

        /*
        if (GUILayout.Button("分类", GUILayout.Height(30)))
        {
            List<GameObject> floors = new List<GameObject>();
            List<GameObject> environments = new List<GameObject>();
            
            for (int i = 0; i < tilemapTransform.childCount; i++)
            {
                Transform childTrans = tilemapTransform.GetChild(i);
                GameObject child = childTrans.gameObject;
                if(child.name == "floor")
                {
                    floor = child;
                }
                else if(child.name == "environment")
                {
                    environment = child;
                }
                else if(child.name.StartsWith("T_"))
                {
                    floors.Add(child);
                }
                else
                {
                    environments.Add(child);
                }
            }
            if(floor == null)
            {
                floor = new GameObject("floor");
                floor.transform.SetParent(tilemapTransform);
                floor.transform.localPosition = Vector3.zero;
                floor.transform.localScale = Vector3.one;
            }
            if(environment == null)
            {
                environment = new GameObject("environment");
                environment.transform.SetParent(tilemapTransform);
                environment.transform.localPosition = Vector3.zero;
                environment.transform.localScale = Vector3.one;
            }
            foreach(GameObject obj in floors)
            {
                obj.transform.SetParent(floor.transform, true);
            }
            foreach(GameObject obj in environments)
            {
                obj.transform.SetParent(environment.transform, true);
            }
        }

        if(GUILayout.Button("对齐到地面", GUILayout.Height(30)))
        {
            Transform floor = tilemapTransform.Find("floor");
            if(floor != null)
            {
                for(int i = 0; i < floor.childCount; i++)
                {
                    Transform child = floor.GetChild(i);
                    MeshFilter meshFilter = child.GetComponent<MeshFilter>();
                    if(meshFilter != null)
                    {
                        Vector3 childPos = child.position;
                        Mesh mesh = meshFilter.sharedMesh;
                        Bounds b = mesh.bounds;
                        Vector3 centerPos = child.TransformPoint(b.center);
                        if(child.forward == Vector3.up)
                        {
                            childPos.y = 0f;
                            child.position = childPos;
                        }
                        else
                        {
                            childPos.y = b.center.z;
                            child.position = childPos;
                        }
                    }
                }
            }
        }
        */
    }

    public void ReplaceSceneModel()
    {
        GameObject mapObj = GameObject.Find("map");
        Transform tilemapTransform = mapObj.transform;
        List<GameObject> removeObjs = new List<GameObject>();
        List<GameObject> addObjs = new List<GameObject>();
        for (int i = 0; i < tilemapTransform.childCount; i++)
        {
            Transform childTrans = tilemapTransform.GetChild(i);
            string prefabPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(childTrans.gameObject);
            string prefabName = Path.GetFileNameWithoutExtension(prefabPath);
            EditorUtility.DisplayProgressBar("replace model", prefabName, (float)i / tilemapTransform.childCount);
            string[] prefabList = AssetDatabase.FindAssets(prefabName + " t:prefab");
            if (prefabList.Length > 0)
            {
                string assetPath = AssetDatabase.GUIDToAssetPath(prefabList[0]);
                GameObject asset = AssetDatabase.LoadAssetAtPath<GameObject>(assetPath);
                if (asset != null)
                {
                    Debug.Log(assetPath);
                    GameObject go = PrefabUtility.InstantiatePrefab(asset) as GameObject;
                    go.name = prefabName;
                    Transform goTrans = go.transform;
                    goTrans.position = childTrans.position;
                    goTrans.localRotation = childTrans.localRotation;
                    goTrans.localScale = childTrans.localScale;
                    addObjs.Add(go);
                    removeObjs.Add(childTrans.gameObject);
                }
            }
        }
        foreach (GameObject go in addObjs)
        {
            go.transform.SetParent(tilemapTransform, true);
        }
        foreach (GameObject go in removeObjs)
        {
            DestroyImmediate(go);
        }
        removeObjs.Clear();

        EditorUtility.ClearProgressBar();
    }
}
