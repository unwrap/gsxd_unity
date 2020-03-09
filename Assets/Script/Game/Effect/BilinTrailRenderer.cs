using UnityEngine;

public class BilinTrailRenderer : MonoBehaviour
{
    // Colors
    public Color[] colors;

    /// <summary>
    /// 头的宽度
    /// </summary>
    public float headWidth = 1f;

    // Lifetime of each segment
    public float lifeTime = 1;

    // Material - Particle Shader with "Tint Color" property
    public Material material;

    public float minVerticeDistance = 1f;

    // Print Output
    public bool printSavedPoints = false;

    /// <summary>
    /// 尾的宽度
    /// </summary>
    public float tailWidth = 1f;

    private Mesh mesh = null;

    private bool rebuildMesh = false;

    // Points
    private Point[] saved;

    private int savedCnt = 0;

    private Point[] savedUp;

    // Objects
    private GameObject trail = null;

    public Color GetColor(float ratio)
    {
        // Color
        Color color;
        if (colors.Length == 0)
        {
            color = Color.white;
        }
        else if (colors.Length == 1)
        {
            color = colors[0];
        }
        else if (colors.Length == 2)
        {
            color = Color.Lerp(colors[1], colors[0], ratio);
        }
        else
        {
            float colorRatio = ratio * (colors.Length - 1);
            int min = (int)Mathf.Floor(colorRatio);
            if (min == colors.Length - 1)
            {
                color = colors[min];
            }
            else
            {
                float lerp = colorRatio - min;
                color = Color.Lerp(colors[min], colors[min + 1], lerp);
            }
        }
        return color;
    }

    public Vector3 GetDir(int index)
    {
        Vector3 dir;
        if (index == 0)
        {
            dir = (saved[index + 1].position - saved[index].position).normalized;
        }
        else
        {
            dir = (saved[index].position - saved[index - 1].position).normalized;
        }

        return Vector3.Cross(dir, transform.up).normalized;
    }

    private void EliminatePoints()
    {
        //当地一个点的时间不到销毁，则直接返回原本数组即可
        if (saved[0] == null)
        {
            return;
        }

        if (saved[0].timeAlive < lifeTime)
        {
            return;
        }

        int forwardIndex = -1;
        for (int i = 1; i < savedCnt; i++)
        {
            Point pt = saved[i];
            if (forwardIndex < 0)
            {
                if (pt.timeAlive < lifeTime)
                {
                    forwardIndex = i;
                }
                if (forwardIndex < 0 && i == savedCnt - 1)
                {
                    forwardIndex = i;
                }
            }

            if (forwardIndex > 0)
            {
                saved[i - forwardIndex] = saved[i];
            }
        }

        if (forwardIndex > 0)
        {
            savedCnt -= forwardIndex;
            rebuildMesh = true;
        }
    }

    private float GetWidth(float ratio)
    {
        // Width
        return Mathf.Lerp(tailWidth, headWidth, ratio);
    }

    private void printPoints()
    {
        if (savedCnt == 0)
            return;
        string s = "Saved Points at time " + Time.time + ":\n";
        for (int i = 0; i < savedCnt; i++)
            s += "Index: " + i + "\tPos: " + saved[i] + "\n";
        print(s);
    }

    private void Start()
    {
        // Data Inititialization
        saved = new Point[100];
        savedUp = new Point[saved.Length];

        // Create the mesh object
        trail = new GameObject("Trail");
        trail.transform.position = Vector3.zero;
        trail.transform.rotation = Quaternion.identity;
        trail.transform.localScale = Vector3.one;
        MeshFilter meshFilter = trail.AddComponent<MeshFilter>();
        mesh = meshFilter.mesh;
        trail.AddComponent<MeshRenderer>();
        trail.GetComponent<Renderer>().material = material;
    }

    private void Update()
    {
        try
        {
            // Remove expired points
            EliminatePoints();

            Vector3 position = transform.position;
            Point p = new Point(position);
            Point normal = new Point(transform.TransformPoint(0, 0, 1));

            if (savedCnt <= 0 || (position - saved[savedCnt - 1].position).sqrMagnitude >= minVerticeDistance)
            {
                //Add New Points
                saved[savedCnt] = new Point(position);
                savedCnt++;
                rebuildMesh = true;
            }

            if (printSavedPoints)
            {
                printPoints();
            }

            if (savedCnt <= 1)
            {
                trail.gameObject.SetActive(false);
                return;
            }

            if (rebuildMesh)
            {
                if (!trail.gameObject.activeInHierarchy)
                {
                    trail.gameObject.SetActive(true);
                }
                // Common data
                Color[] meshColors;

                // Rebuild the mesh
                Vector3[] vertices = new Vector3[savedCnt * 2];
                Vector2[] uvs = new Vector2[savedCnt * 2];
                int[] triangles = new int[(savedCnt - 1) * 6];
                meshColors = new Color[savedCnt * 2];

                float pointRatio = 1f / (savedCnt - 1);
                float uvMultiplier = 1 / (saved[savedCnt - 1].timeAlive - saved[0].timeAlive);
                for (int i = 0; i < savedCnt; i++)
                {
                    Point point = saved[i];
                    float ratio = i * pointRatio;

                    // Color
                    Color color = GetColor(ratio);
                    meshColors[i * 2] = color;
                    meshColors[i * 2 + 1] = color;

                    Vector3 dir = GetDir(i);
                    // Width
                    float width = GetWidth(ratio);
                    vertices[i * 2] = point.position + dir * width * 0.5f;
                    vertices[i * 2 + 1] = point.position - dir * width * 0.5f;

                    // UVs
                    //float uvRatio = (point.timeAlive - saved[0].timeAlive) * uvMultiplier;
                    uvs[i * 2] = new Vector2(ratio, 0);
                    uvs[(i * 2) + 1] = new Vector2(ratio, 1);

                    if (i > 0)
                    {
                        // Triangles
                        int triIndex = (i - 1) * 6;
                        int vertIndex = i * 2;
                        triangles[triIndex + 0] = vertIndex - 2;
                        triangles[triIndex + 1] = vertIndex + 0;
                        triangles[triIndex + 2] = vertIndex + 1;

                        triangles[triIndex + 3] = vertIndex - 2;
                        triangles[triIndex + 4] = vertIndex + 1;
                        triangles[triIndex + 5] = vertIndex - 1;
                    }
                }
                trail.transform.position = Vector3.zero;
                trail.transform.rotation = Quaternion.identity;
                mesh.Clear();
                mesh.vertices = vertices;
                mesh.colors = meshColors;
                mesh.uv = uvs;
                mesh.triangles = triangles;
                mesh.Optimize();
                rebuildMesh = false;
            }
        }
        catch (System.Exception e)
        {
            print(e);
        }
    }

    private class Point
    {
        public float fadeAlpha = 0;
        public Vector3 position = Vector3.zero;
        public float timeCreated = 0;

        public Point(Vector3 pos)
        {
            position = pos;
            timeCreated = Time.realtimeSinceStartup;
        }

        public float timeAlive
        {
            get { return Time.realtimeSinceStartup - timeCreated; }
        }

        public static Point Lerp(Point p1, Point p2, float k)
        {
            return new Point(Vector3.Lerp(p1.position, p2.position, k));
        }

        public static Point operator -(Point p1, Point p2)
        {
            return new Point(p1.position - p2.position);
        }

        public static Point operator *(float k, Point p1)
        {
            return new Point(k * p1.position);
        }

        public static Point operator +(Point p1, Point p2)
        {
            return new Point(p1.position + p2.position);
        }

        public void update(Vector3 pos)
        {
            position = pos;
            timeCreated = Time.realtimeSinceStartup;
        }
    }
}