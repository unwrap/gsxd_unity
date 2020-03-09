using UnityEngine;
using UnityEditor;

namespace PigeonCoopToolkit.Effects.Trails.Editor
{
    public class TrailPreviewUtillity : EditorWindow
    {
        public TrailRenderer_Base Trail;
    
        void Update()
        {
            if (Trail == null  || Trail.TrailData == null || Selection.activeGameObject != Trail.gameObject)
            {
                Close();
                return;
            }

            Repaint();
        }

        void OnGUI()
        {
            if (Trail == null || Trail.TrailData == null)
            {
                return;
            }

            

            GUIStyle blackBG = new GUIStyle();
            blackBG.normal.background = EditorGUIUtility.whiteTexture;
            blackBG.normal.textColor = Color.white;
            Color revertTo = GUI.color;

            

            float highPoint = 0;

            for (int i = 0; i < 100; i++)
            {
                float s = (Trail.TrailData.UsingSimpleSize ? Mathf.Lerp(Trail.TrailData.SimpleSizeOverLifeStart, Trail.TrailData.SimpleSizeOverLifeEnd, (float)i / (float)100) : Trail.TrailData.SizeOverLife.Evaluate((float)i / (float)100));
                


                if (highPoint < s)
                    highPoint = s;
            }

            GUI.color = new Color(0.3f,0.3f,0.3f,1);
            GUILayout.BeginArea(new Rect(0, 0, position.width, position.height), blackBG);


            float xPos = 0;
            float increment = 101;
            float modulo = 303;

            while (xPos * increment < position.width)
            {
                xPos++;
                DrawLine(Vector2.right * (xPos * increment), Vector2.right * (xPos * increment) + Vector2.up * position.height, xPos * increment % modulo == 0 ? new Color(1, 1, 1, 0.1f) : new Color(1, 1, 1, 0.025f), 1);
            }

            DrawLine(Vector2.up * position.height / 2, Vector2.right * position.width + Vector2.up * position.height / 2, new Color(1, 1, 1, 0.1f), 1);

            
            GL.PushMatrix();
            GL.LoadPixelMatrix(-0.5f, 0.5f, 0.5f, -0.5f);
            if (Trail.TrailData.TrailMaterial != null)
                Trail.TrailData.TrailMaterial.SetPass(0);

            GL.Begin(GL.TRIANGLE_STRIP);

            InsertTriangle(0, 1);

            for (int i = 0; i < 100; i++)
            {
                InsertTriangle((float)i / (float)100, highPoint * 2);
            }

            GL.End();
            GL.PopMatrix();

            GUILayout.EndArea();

            if (Trail.TrailData.TrailMaterial == null)
            {
                GUILayout.BeginVertical();
                GUILayout.BeginHorizontal();
                GUILayout.FlexibleSpace();
                GUI.color = new Color(0, 0, 0, 0.15f);

                GUILayout.BeginVertical();

                GUILayout.FlexibleSpace();

                GUILayout.BeginVertical(blackBG);
                GUI.color = Color.white;
                GUILayout.Label("Material is NULL", EditorStyles.whiteMiniLabel);
                GUILayout.EndVertical();
                GUILayout.FlexibleSpace();
                GUILayout.EndVertical();

                GUILayout.FlexibleSpace();

                GUILayout.EndHorizontal();
                GUILayout.EndVertical();

            }
            else
            {
                GUILayout.BeginVertical();
                GUILayout.FlexibleSpace();
                GUILayout.BeginHorizontal();
                GUI.color = new Color(0, 0, 0, 0.15f);
                GUILayout.BeginVertical(blackBG);
                GUI.color = Color.white;
                GUILayout.Label("Start", EditorStyles.whiteMiniLabel);
                GUILayout.EndVertical();
                GUILayout.FlexibleSpace();

                GUI.color = new Color(0, 0, 0, 0.15f);
                GUILayout.BeginVertical(blackBG);
                GUI.color = Color.white;
                GUILayout.Label("End", EditorStyles.whiteMiniLabel);
                GUILayout.EndVertical();

                GUILayout.EndHorizontal();
                GUILayout.EndVertical();
            }

            GUI.color = revertTo;


        }

        void InsertTriangle(float t, float scaler)
        {
            if(scaler <= 0)
                return;

            Color c = (Trail.TrailData.UsingSimpleColor ? 
                Color.Lerp(Trail.TrailData.SimpleColorOverLifeStart, Trail.TrailData.SimpleColorOverLifeEnd, t) : 
                Trail.TrailData.ColorOverLife.Evaluate(t));

            float s = (Trail.TrailData.UsingSimpleSize ? Mathf.Lerp(Trail.TrailData.SimpleSizeOverLifeStart, Trail.TrailData.SimpleSizeOverLifeEnd, t) : Trail.TrailData.SizeOverLife.Evaluate(t)) / (scaler);
            
            GL.Color(c);
            GL.Vertex3(t, 0.5f + s, 0);
            GL.MultiTexCoord(0, Trail.TrailData.MaterialTileLength > 0 ? new Vector3((t * position.width) / (300 * Trail.TrailData.MaterialTileLength), 0, 0) : new Vector3(t, 0, 0));
            GL.Vertex3(t, 0.5f - s, 0);
            GL.MultiTexCoord(0, Trail.TrailData.MaterialTileLength > 0 ? new Vector3((t * position.width) / (300 * Trail.TrailData.MaterialTileLength), 1, 0) : new Vector3(t, 1, 0));
        }

        public static void DrawLine(Vector2 start, Vector2 end, Color color, float width)
        {
            if (Event.current == null)
                return;
            if (Event.current.type != EventType.Repaint)
                return;

            CreateMaterial();

            lineMaterial.SetPass(0);

            Vector3 startPt;
            Vector3 endPt;

            if (width == 1)
            {
                GL.Begin(GL.LINES);
                GL.Color(color);
                startPt = new Vector3(start.x, start.y, 0);
                endPt = new Vector3(end.x, end.y, 0);
                GL.Vertex(startPt);
                GL.Vertex(endPt);
            }
            else
            {
                GL.Begin(GL.QUADS);
                GL.Color(color);
                startPt = new Vector3(end.y, start.x, 0);
                endPt = new Vector3(start.y, end.x, 0);
                Vector3 perpendicular = (startPt - endPt).normalized * width;
                Vector3 v1 = new Vector3(start.x, start.y, 0);
                Vector3 v2 = new Vector3(end.x, end.y, 0);
                GL.Vertex(v1 - perpendicular);
                GL.Vertex(v1 + perpendicular);
                GL.Vertex(v2 + perpendicular);
                GL.Vertex(v2 - perpendicular);
            }
            GL.End();
        }

        public static void CreateMaterial()
        {
            if (lineMaterial != null)
                return;

            lineMaterial = new Material("Shader \"Lines/Colored Blended\" {" +
                                        "SubShader { Pass { " +
                                        "    Blend SrcAlpha OneMinusSrcAlpha " +
                                        "    ZWrite Off Cull Off Fog { Mode Off } " +
                                        "    BindChannels {" +
                                        "      Bind \"vertex\", vertex Bind \"color\", color }" +
                                        "} } }");
            lineMaterial.hideFlags = HideFlags.HideAndDontSave;
            lineMaterial.shader.hideFlags = HideFlags.HideAndDontSave;
        }

        public static Material lineMaterial = null;
 

    }
}

/*
using UnityEngine;
using UnityEditor;

namespace PigeonCoopToolkit.Effects.Trails.Editor
{
    public class TrailPreviewUtillity : EditorWindow
    {

        public PCTrailRendererData Data;
    
        void OnGUI()
        {
            if(Data == null)
            {
                Close();
                return;
            }

            DrawLine(Vector2.zero, Vector2.right + Vector2.up,Color.red,1,Data.TrailMaterial);

        }

        public static void DrawLine(Vector2 start, Vector2 end, Color color, float width, Material m)
        {
            if (Event.current == null)
                return;
            if (Event.current.type != EventType.repaint)
                return;



            m.SetPass(0);

            Vector3 startPt;
            Vector3 endPt;

            if (width == 1)
            {
                GL.Begin(GL.LINES);
                GL.Color(color);
                startPt = new Vector3(start.x, start.y, 0);
                endPt = new Vector3(end.x, end.y, 0);
                GL.Vertex(startPt);
                GL.Vertex(endPt);
            }
            else
            {
                GL.Begin(GL.QUADS);
                GL.Color(color);
                startPt = new Vector3(end.y, start.x, 0);
                endPt = new Vector3(start.y, end.x, 0);
                Vector3 perpendicular = (startPt - endPt).normalized * width;
                Vector3 v1 = new Vector3(start.x, start.y, 0);
                Vector3 v2 = new Vector3(end.x, end.y, 0);
                GL.Vertex(v1 - perpendicular);
                GL.Vertex(v1 + perpendicular);
                GL.Vertex(v2 + perpendicular);
                GL.Vertex(v2 - perpendicular);
            }
            GL.End();
        }
	
    }
}

*/