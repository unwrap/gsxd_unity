using UnityEngine;

namespace PigeonCoopToolkit.Effects.Trails
{
    [AddComponentMenu("Pigeon Coop Toolkit/Effects/Smoke Trail")]
    public class SmokeTrail : TrailRenderer_Base
    {
        public float MinVertexDistance = 0.1f;
        public int MaxNumberOfPoints = 50;
        private Vector3 _lastPosition;
        private float _distanceMoved;
        public float RandomForceScale = 1;

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

                if (_distanceMoved != 0 && _distanceMoved >= MinVertexDistance)
                {
                    AddPoint(new SmokeTrailPoint(), _t.position);
                    _distanceMoved = 0;
                }
                _lastPosition = _t.position;

            }

            base.Update();
        }

        protected override void OnStartEmit()
        {
            _lastPosition = _t.position;
            _distanceMoved = 0;
        }

        protected override void Reset()
        {
            base.Reset();
            MinVertexDistance = 0.1f;
            RandomForceScale = 1;
        }

        protected override void InitialiseNewPoint(PCTrailPoint newPoint)
        {
            ((SmokeTrailPoint)newPoint).RandomVec = Random.onUnitSphere * RandomForceScale;
        }
        protected override void OnTranslate(Vector3 t)
        {
            _lastPosition += t;
        }

        protected override int GetMaxNumberOfPoints()
        {
            return MaxNumberOfPoints;
        }
    }

    public class SmokeTrailPoint : PCTrailPoint
    {
        public Vector3 RandomVec;

        public override void Update(float deltaTime)
        {
            base.Update(deltaTime);
            Position += RandomVec * deltaTime;
        }
    }
}
