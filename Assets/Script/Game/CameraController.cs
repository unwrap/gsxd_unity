using UnityEngine;

[SLua.CustomLuaClass]
public class CameraController : MonoBehaviour
{
    public Vector3 offsetVector3;

    [SLua.DoNotToLua]
    public Transform target;
    private Camera myCamera;
    private Transform cameraTransform;

    private void Start()
    {
        GameObject cameraObj = this.transform.GetChild(0).gameObject;
        this.myCamera = cameraObj.GetComponent<Camera>();
        this.myCamera.orthographic = false;
        this.myCamera.fieldOfView = 60;
        this.cameraTransform = cameraObj.transform;

        this.offsetVector3 = new Vector3(0, 5.3f, -7.3f);
    }

    public void SetTarget(Transform target)
    {
        this.target = target;
    }

    public void SetCameraSize(float w, float h)
    {

    }

   private void Update()
    {
        if(this.target == null)
        {
            return;
        }

        Vector3 pos = this.target.position;
        Vector3 to = pos + this.offsetVector3;

        this.transform.position = to;
        this.transform.LookAt(pos);

#if UNITY_EDITOR
        DrawCorners(Vector3.Distance(pos, to));
#endif
    }

#if UNITY_EDITOR
    private void DrawCorners(float distance)
    {
        if(this.target == null)
        {
            return;
        }
        float halfFOV = this.myCamera.fieldOfView * 0.5f * Mathf.Deg2Rad;
        float aspect = this.myCamera.aspect;

        float height = distance * Mathf.Tan(halfFOV);
        float width = height * aspect;

        Vector3 upperLeft = this.cameraTransform.position + this.cameraTransform.forward * distance;
        upperLeft -= this.cameraTransform.right * width;
        upperLeft += this.cameraTransform.up * height;

        Vector3 upperRight = this.cameraTransform.position + this.cameraTransform.forward * distance;
        upperRight += this.cameraTransform.right * width;
        upperRight += this.cameraTransform.up * height;

        Vector3 lowerLeft = this.cameraTransform.position + this.cameraTransform.forward * distance;
        lowerLeft -= this.cameraTransform.right * width;
        lowerLeft -= this.cameraTransform.up * height;

        Vector3 lowerRight = this.cameraTransform.position + this.cameraTransform.forward * distance;
        lowerRight += this.cameraTransform.right * width;
        lowerRight -= this.cameraTransform.up * height;

        Debug.DrawLine(upperLeft, upperRight, Color.red);
        Debug.DrawLine(upperRight, lowerRight, Color.red);

        Debug.DrawLine(lowerRight, lowerLeft, Color.red);
        Debug.DrawLine(lowerLeft, upperLeft, Color.red);
    }
#endif
}
