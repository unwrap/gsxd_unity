using PigeonCoopToolkit.Utillities;
using UnityEngine;

namespace PigeonCoopToolkit.Effects.Trails
{
    [AddComponentMenu("Pigeon Coop Toolkit/Effects/Smooth Trail")]
    public class SmoothTrail : TrailRenderer_Base
    {
        public float MinControlPointDistance = 0.1f;
        public int MaxControlPoints = 15;
        public int PointsBetweenControlPoints = 4;

        private Vector3 _lastPosition;
        private float _distanceMoved;
        private CircularBuffer<ControlPoint> _controlPoints;

        private class ControlPoint
        {
            public Vector3 p;
            public Vector3 forward;
        }
        
        protected override void Start()
        {
            base.Start();
            _lastPosition = _t.position;
        }

        protected override void Update()
        {

            if (_emit)
            {
                _distanceMoved += Vector3.Distance(_t.position, _lastPosition);

                if (!Mathf.Approximately(_distanceMoved, 0) && _distanceMoved >= MinControlPointDistance)
                {
                    AddControlPoint(_t.position);
                    _distanceMoved = 0;
                }
                else
                {
                    _controlPoints[_controlPoints.Count - 1].p = _t.position;

                    if (TrailData.UseForwardOverride)
                    {
                        _controlPoints[_controlPoints.Count - 1].forward = TrailData.ForwardOverrideRelative
                                       ? _t.TransformDirection(TrailData.ForwardOverride.normalized)
                                       : TrailData.ForwardOverride.normalized;
                    }

                }

                _lastPosition = _t.position;
            }

            base.Update();
        }

        /*
        void OnDrawGizmos()
        {
            if (Application.isPlaying && _controlPoints != null)
            {
                for (int i = 0; i < _controlPoints.Count; i++)
                {
                    Gizmos.color = Color.red;
                    Gizmos.DrawSphere(_controlPoints[i].p, 0.01f);

                    if (i < _controlPoints.Count - 1)
                    {
                        Vector3 Handle1, Handle2;
                        float distanceBetween = Vector3.Distance(_controlPoints[i].p, _controlPoints[i + 1].p) / 2;
                        if (i == 0)
                        {
                            Handle1 = _controlPoints[i].p + (_controlPoints[i + 1].p - _controlPoints[i].p).normalized * distanceBetween;
                        }
                        else
                        {
                            Handle1 = _controlPoints[i].p + (_controlPoints[i + 1].p - _controlPoints[i - 1].p).normalized * distanceBetween;
                        }

                        int nextI = i + 1;

                        if (nextI == _controlPoints.Count - 1)
                        {
                            Handle2 = _controlPoints[nextI].p + (_controlPoints[nextI - 1].p - _controlPoints[nextI].p).normalized * distanceBetween;
                        }
                        else
                        {
                            Handle2 = _controlPoints[nextI].p + (_controlPoints[nextI - 1].p - _controlPoints[nextI + 1].p).normalized * distanceBetween;
                        }

                        Gizmos.color = Color.green;
                        Gizmos.DrawSphere(Handle1, 0.01f);
                        Gizmos.DrawLine(_controlPoints[i].p, Handle1);
                        Gizmos.color = Color.blue;
                        Gizmos.DrawSphere(Handle2, 0.01f);
                        Gizmos.DrawLine(_controlPoints[nextI].p, Handle2);


                        Vector3 current = _controlPoints[i].p;

                        for (int pointBetween = 0; pointBetween < PointsBetweenControlPoints; pointBetween++)
                        {
                            Vector3 next = GetPointAlongCurve(_controlPoints[i].p, Handle1, _controlPoints[i + 1].p, Handle2, ((pointBetween + 1) / ((float)PointsBetweenControlPoints + 1f)), 0.3f);

                            Gizmos.DrawLine(current, next);

                            Gizmos.color = Color.yellow;
                            Gizmos.DrawSphere(next, 0.01f);

                            current = next;
                        }

                        Gizmos.color = Color.blue;
                        Gizmos.DrawLine(current, _controlPoints[i + 1].p);

                    }
                }
            }
        }
        */

        protected override void OnStartEmit()
        {
            _lastPosition = _t.position;
            _distanceMoved = 0;
            _controlPoints = new CircularBuffer<ControlPoint>(MaxControlPoints);

            _controlPoints.Add(new ControlPoint { p = _lastPosition });

            if (TrailData.UseForwardOverride)
            {
                _controlPoints[0].forward = TrailData.ForwardOverrideRelative
                               ? _t.TransformDirection(TrailData.ForwardOverride.normalized)
                               : TrailData.ForwardOverride.normalized;
            }

            AddPoint(new PCTrailPoint(), _lastPosition);

            AddControlPoint(_lastPosition);
        }

        protected override void UpdateTrail(PCTrail trail, float deltaTime)
        {
            if (trail.IsActiveTrail == false)
                return;

            //TODO Must optimize this further, I don't need to keep recalculating point positions unless we are
            //dealng with the points between the last and 2nd last CP (+ the last CP itself)
            int trailPointIndex = 0;
            for (int i = 0; i < _controlPoints.Count; i++)
            {
                trail.Points[trailPointIndex].Position = _controlPoints[i].p;

                if (TrailData.UseForwardOverride)
                {
                    trail.Points[trailPointIndex].Forward = _controlPoints[i].forward;
                }

                trailPointIndex++;

                if (i < _controlPoints.Count - 1)
                {
                    Vector3 Handle1, Handle2;
                    float distanceBetween = Vector3.Distance(_controlPoints[i].p, _controlPoints[i + 1].p) / 2;
                    if (i == 0)
                    {
                        Handle1 = _controlPoints[i].p + (_controlPoints[i + 1].p - _controlPoints[i].p).normalized * distanceBetween;
                    }
                    else
                    {
                        Handle1 = _controlPoints[i].p + (_controlPoints[i + 1].p - _controlPoints[i - 1].p).normalized * distanceBetween;
                    }

                    int nextI = i + 1;

                    if (nextI == _controlPoints.Count - 1)
                    {
                        Handle2 = _controlPoints[nextI].p + (_controlPoints[nextI - 1].p - _controlPoints[nextI].p).normalized * distanceBetween;
                    }
                    else
                    {
                        Handle2 = _controlPoints[nextI].p + (_controlPoints[nextI - 1].p - _controlPoints[nextI + 1].p).normalized * distanceBetween;
                    }

                    PCTrailPoint currentHandle = trail.Points[trailPointIndex-1];
                    PCTrailPoint nextHandle = trail.Points[(trailPointIndex-1) + PointsBetweenControlPoints+1];

                    
                    for (int pointBetween = 0; pointBetween < PointsBetweenControlPoints; pointBetween++)
                    {
                        float t= (((float)pointBetween + 1f) / ((float)PointsBetweenControlPoints + 1f));
                        trail.Points[trailPointIndex].Position = GetPointAlongCurve(_controlPoints[i].p, Handle1, _controlPoints[i + 1].p, Handle2, t, 0.3f);
                        trail.Points[trailPointIndex].SetTimeActive(Mathf.Lerp(currentHandle.TimeActive(), nextHandle.TimeActive(), t));

                        if (TrailData.UseForwardOverride)
                        {
                            trail.Points[trailPointIndex].Forward = Vector3.Lerp(currentHandle.Forward, nextHandle.Forward, t);
                        }


                        trailPointIndex++;
                    }

                }
            }

            int lastControlPointPointIndex = ((_controlPoints.Count - 1) + ((_controlPoints.Count - 1) * PointsBetweenControlPoints));
            int prevControlPointPointIndex = lastControlPointPointIndex - PointsBetweenControlPoints - 1;
            int activePointCount = lastControlPointPointIndex + 1;
            

            /*
             * 
             * This is that optimisation mentioned above..sort of works, but smoothing isn't working right so i am leaving it out for now
             * 
             * 
             
            int lastControlPointIndex = _controlPoints.Count - 1;
            int prevControlPointIndex = _controlPoints.Count - 2;

            Vector3 Handle1, Handle2;
            float distanceBetween = Vector3.Distance(_controlPoints[lastControlPointIndex].p, _controlPoints[prevControlPointIndex].p) / 2;

            if (prevControlPointIndex == 0)
                Handle1 = _controlPoints[prevControlPointIndex].p + (_controlPoints[lastControlPointIndex].p - _controlPoints[prevControlPointIndex].p).normalized * distanceBetween;
            else
                Handle1 = _controlPoints[prevControlPointIndex].p + (_controlPoints[lastControlPointIndex].p - _controlPoints[prevControlPointIndex - 1].p).normalized * distanceBetween;
           

            Handle2 = _controlPoints[lastControlPointIndex].p + (_controlPoints[prevControlPointIndex].p - _controlPoints[lastControlPointIndex].p).normalized * distanceBetween;


            float timeActiveLastControlPoint = trail.Points[lastControlPointPointIndex].TimeActive();
            float timeActivePrevControlPoint = trail.Points[prevControlPointPointIndex].TimeActive();

            for (int pointBetween = 0; pointBetween < PointsBetweenControlPoints; pointBetween++)
            {
                float t= (((float)pointBetween + 1f) / ((float)PointsBetweenControlPoints + 1f));
                trail.Points[prevControlPointPointIndex + pointBetween + 1].Position = GetPointAlongCurve(_controlPoints[prevControlPointIndex].p, Handle1, _controlPoints[lastControlPointIndex].p, Handle2, t, 0.3f);
                trail.Points[prevControlPointPointIndex + pointBetween + 1].SetTimeActive(Mathf.Lerp(timeActivePrevControlPoint, timeActiveLastControlPoint, t));
            }
            trail.Points[lastControlPointPointIndex].Position = _controlPoints[lastControlPointIndex].p;
            */

            float distanceFromStart = trail.Points[prevControlPointPointIndex].GetDistanceFromStart();
            for (int i = prevControlPointPointIndex + 1; i < activePointCount; i++)
            {
                distanceFromStart += Vector3.Distance(trail.Points[i - 1].Position, trail.Points[i].Position);
                trail.Points[i].SetDistanceFromStart(distanceFromStart);
            }

        }

        protected override void Reset()
        {
            base.Reset();
            MinControlPointDistance = 0.1f;
            MaxControlPoints = 15;
            PointsBetweenControlPoints = 4;
        }

        protected override void OnTranslate(Vector3 t)
        {
            _lastPosition += t;

            for (int i = 0; i < _controlPoints.Count; i++)
                _controlPoints[i].p += t;
        }

        private void AddControlPoint(Vector3 position)
        {
            for (int i = 0; i < PointsBetweenControlPoints; i++)
            {
                AddPoint(new PCTrailPoint(), position);
            }

            AddPoint(new PCTrailPoint(), position);

            ControlPoint newCP = new ControlPoint { p = position };

            if (TrailData.UseForwardOverride)
            {
                newCP.forward = TrailData.ForwardOverrideRelative
                               ? _t.TransformDirection(TrailData.ForwardOverride.normalized)
                               : TrailData.ForwardOverride.normalized;
            }

            _controlPoints.Add(newCP);
        }

        protected override int GetMaxNumberOfPoints()
        {
            return ((MaxControlPoints) + ((MaxControlPoints) * PointsBetweenControlPoints));
        }

        public Vector3 GetPointAlongCurve(Vector3 curveStart, Vector3 curveStartHandle, Vector3 curveEnd, Vector3 curveEndHandle, float t, float crease)
        {
            float oneMinT = 1 - t;
            float oneMinTPow3 = Mathf.Pow(oneMinT, 3);
            float oneMinTPow2 = Mathf.Pow(oneMinT, 2);

            float oneMinCrease = 1 - crease;
            return ((oneMinTPow3 * curveStart * oneMinCrease) + (3 * oneMinTPow2 * t * curveStartHandle * crease) + (3 * oneMinT * Mathf.Pow(t, 2) * curveEndHandle * crease) +
                   (Mathf.Pow(t, 3) * curveEnd * oneMinCrease))
                   /
                   ((oneMinTPow3 * oneMinCrease) + (3 * oneMinTPow2 * t * crease) + (3 * oneMinT * Mathf.Pow(t, 2) * crease) +
                   (Mathf.Pow(t, 3) * oneMinCrease));
        }
    }
}
