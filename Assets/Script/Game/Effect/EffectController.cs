using UnityEngine;
using System.Collections;
using System;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;
#endif

[SLua.CustomLuaClass]
[ExecuteInEditMode]
public class EffectController : MonoBehaviour
{
    public bool playAutomatically;
    public bool autoRemove = true;
    public bool isFlip = false;
    public Action onEffectEnd;

#if UNITY_EDITOR
    [SLua.DoNotToLua]
    public float particleScale = 1.0f;
    [SLua.DoNotToLua]
    public bool alsoScaleGameobject = false;
    [SLua.DoNotToLua]
    private float prevScale = 1.0f;
#endif

    private bool mIsPlaying;
    private bool mAutoPlay;
    private bool mIsRemove;
    private bool mIsLoop;

    private ParticleSystem[] particles;
    private MeshRenderer[] mRendererList;
    private Animator[] m_animes;

    private float mEffectTimer;
    private float mEffectTime;

    public float EffectTime
    {
        get
        {
            return this.mEffectTime;
        }
    }

    private float mTimeScale = 1.0f;
    public float TimeScale
    {
        get
        {
            return this.mTimeScale;
        }
        set
        {
            this.mTimeScale = value;
            if (this.m_animes != null)
            {
                for (int i = 0; i < this.m_animes.Length; i++)
                {
                    Animator ani = this.m_animes[i];
                    ani.speed = this.mTimeScale;
                }
            }
        }
    }

    public bool isAlive
    {
        get
        {
            if (this.particles != null)
            {
                for (int i = 0; i < this.particles.Length; i++)
                {
                    ParticleSystem particle = this.particles[i];
                    if (particle.IsAlive(true))
                    {
                        return true;
                    }
                }
            }
            return false;
        }
    }

    public bool isPlaying
    {
        get
        {
            return this.mIsPlaying;
        }
    }

    public virtual void Play()
    {
        if (!this.gameObject.activeSelf)
        {
            this.gameObject.SetActive(true);
        }
        if (this.particles != null)
        {
            for (int i = 0; i < this.particles.Length; i++)
            {
                ParticleSystem particle = this.particles[i];
                particle.Play(true);
            }
        }
        if (this.mRendererList != null)
        {
            for (int i = 0; i < this.mRendererList.Length; i++)
            {
                MeshRenderer render = this.mRendererList[i];
                render.enabled = true;
            }
        }
        this.mIsPlaying = true;
        this.mEffectTimer = 0.0f;

        if(this.m_animes != null)
        {
            for(int i = 0; i < this.m_animes.Length; i++)
            {
                Animator ani = this.m_animes[i];
                AnimatorStateInfo info = ani.GetCurrentAnimatorStateInfo(0);
                ani.speed = this.TimeScale;
                ani.Play(info.fullPathHash, 0, 0);
            }
        }
    }

    public virtual void Stop(bool reset = false)
    {
        if (reset)
        {
            this.onEffectEnd = null;
        }
        this.mIsPlaying = false;
        if (this.particles != null)
        {
            for (int i = 0; i < this.particles.Length; i++)
            {
                ParticleSystem particle = this.particles[i];
                if (particle == null) continue;
                particle.Stop(true);
            }
        }
        if (this.autoRemove)
        {
            this.mIsRemove = true;
        }
    }

    public void Remove()
    {
        this.mIsRemove = false;
        ObjectPool.Recycle(this.gameObject);
        this.onEffectEnd = null;
    }

    private void Awake()
    {
#if UNITY_EDITOR
        if(UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name == "Temp")
        {
            this.mAutoPlay = true;
        }
#endif
        this.particles = this.GetComponentsInChildren<ParticleSystem>();
        this.mRendererList = this.GetComponentsInChildren<MeshRenderer>();
        mIsLoop = false;
        if (this.particles != null)
        {
            for (int i = 0; i < this.particles.Length; i++)
            {
                ParticleSystem particle = this.particles[i];
                if (particle.duration > mEffectTime)
                {
                    mEffectTime = particle.duration;
                }
                if (particle.loop)
                {
                    mIsLoop = true;
                }
            }
        }

        this.m_animes = this.GetComponentsInChildren<Animator>();
        if (this.m_animes != null)
        {
            for (int i = 0; i < this.m_animes.Length; i++)
            {
                Animator ani = this.m_animes[i];
                AnimatorStateInfo info = ani.GetCurrentAnimatorStateInfo(0);
                if(info.length > mEffectTime)
                {
                    mEffectTime = info.length;
                }
            }
        }
    }

    private void OnEnable()
    {
        this.mAutoPlay = this.playAutomatically;
    }

    private void Start()
    {
        this.mAutoPlay = this.playAutomatically;
#if UNITY_EDITOR
        prevScale = particleScale;
#endif
    }

    private void Update()
    {
        //粒子速度也加快
        if (this.TimeScale > 1.0f)
        {
            if (this.particles != null)
            {
                for (int i = 0; i < this.particles.Length; i++)
                {
                    ParticleSystem particle = this.particles[i];
                    particle.Simulate(this.TimeScale * Time.deltaTime, false, false);
                }
            }
        }
        
        if (this.mAutoPlay)
        {
            this.Play();
            this.mAutoPlay = false;
        }

        if (this.mIsPlaying)
        {
            mEffectTimer += Time.deltaTime * this.TimeScale;
            if (mEffectTimer > mEffectTime)
            {
                if (mIsLoop)
                {
                    this.mEffectTimer = 0.0f;
                }
                else
                {
                    this.Stop();
                }
            }
        }

        if (onEffectEnd != null)
        {
            if (!this.isPlaying)
            {
                onEffectEnd();
                onEffectEnd = null;
            }
        }

#if UNITY_EDITOR
        this.ParticleScale();
#endif
    }

    private void LateUpdate()
    {
#if UNITY_EDITOR
        if (UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene().name == "Temp")
        {
            return;
        }
#endif
        if (this.mIsRemove)
        {
            this.Remove();
        }
    }

#if UNITY_EDITOR

    [ContextMenu("ParticleScaler")]
    private void ParticleScale()
    {
        //check if we need to update
        if (prevScale != particleScale && particleScale > 0)
        {
            if (alsoScaleGameobject)
            {
                transform.localScale = new Vector3(particleScale, particleScale, particleScale);
            }

            float scaleFactor = particleScale / prevScale;

            //scale legacy particle systems
            ScaleLegacySystems(scaleFactor);

            //scale shuriken particle systems
            ScaleShurikenSystems(scaleFactor);

            //scale trail renders
            ScaleTrailRenderers(scaleFactor);

            prevScale = particleScale;
        }
    }

    private void ScaleShurikenSystems(float scaleFactor)
    {
#if UNITY_EDITOR
        //get all shuriken systems we need to do scaling on
        ParticleSystem[] systems = GetComponentsInChildren<ParticleSystem>();

        foreach (ParticleSystem system in systems)
        {
            system.startSpeed *= scaleFactor;
            system.startSize *= scaleFactor;
            system.gravityModifier *= scaleFactor;

            //some variables cannot be accessed through regular script, we will acces them through a serialized object
            SerializedObject so = new SerializedObject(system);

            //unity 4.0 and onwards will already do this one for us
#if UNITY_3_5
			so.FindProperty("ShapeModule.radius").floatValue *= scaleFactor;
			so.FindProperty("ShapeModule.boxX").floatValue *= scaleFactor;
			so.FindProperty("ShapeModule.boxY").floatValue *= scaleFactor;
			so.FindProperty("ShapeModule.boxZ").floatValue *= scaleFactor;
#endif

            so.FindProperty("VelocityModule.x.scalar").floatValue *= scaleFactor;
            so.FindProperty("VelocityModule.y.scalar").floatValue *= scaleFactor;
            so.FindProperty("VelocityModule.z.scalar").floatValue *= scaleFactor;
            so.FindProperty("ClampVelocityModule.magnitude.scalar").floatValue *= scaleFactor;
            so.FindProperty("ClampVelocityModule.x.scalar").floatValue *= scaleFactor;
            so.FindProperty("ClampVelocityModule.y.scalar").floatValue *= scaleFactor;
            so.FindProperty("ClampVelocityModule.z.scalar").floatValue *= scaleFactor;
            so.FindProperty("ForceModule.x.scalar").floatValue *= scaleFactor;
            so.FindProperty("ForceModule.y.scalar").floatValue *= scaleFactor;
            so.FindProperty("ForceModule.z.scalar").floatValue *= scaleFactor;
            so.FindProperty("ColorBySpeedModule.range").vector2Value *= scaleFactor;
            so.FindProperty("SizeBySpeedModule.range").vector2Value *= scaleFactor;
            so.FindProperty("RotationBySpeedModule.range").vector2Value *= scaleFactor;

            so.ApplyModifiedProperties();
        }
#endif
    }

    private void ScaleLegacySystems(float scaleFactor)
    {
        /*
#if UNITY_EDITOR
        //get all emitters we need to do scaling on
        ParticleEmitter[] emitters = GetComponentsInChildren<ParticleEmitter>();

        //get all animators we need to do scaling on
        ParticleAnimator[] animators = GetComponentsInChildren<ParticleAnimator>();

        //apply scaling to emitters
        foreach (ParticleEmitter emitter in emitters)
        {
            emitter.minSize *= scaleFactor;
            emitter.maxSize *= scaleFactor;
            emitter.worldVelocity *= scaleFactor;
            emitter.localVelocity *= scaleFactor;
            emitter.rndVelocity *= scaleFactor;

            //some variables cannot be accessed through regular script, we will acces them through a serialized object
            SerializedObject so = new SerializedObject(emitter);

            so.FindProperty("m_Ellipsoid").vector3Value *= scaleFactor;
            so.FindProperty("tangentVelocity").vector3Value *= scaleFactor;
            so.ApplyModifiedProperties();
        }

        //apply scaling to animators
        foreach (ParticleAnimator animator in animators)
        {
            animator.force *= scaleFactor;
            animator.rndForce *= scaleFactor;
        }
#endif
        */
    }

    private void ScaleTrailRenderers(float scaleFactor)
    {
        //get all animators we need to do scaling on
        TrailRenderer[] trails = GetComponentsInChildren<TrailRenderer>();

        //apply scaling to animators
        foreach (TrailRenderer trail in trails)
        {
            trail.startWidth *= scaleFactor;
            trail.endWidth *= scaleFactor;
        }
    }

#endif
}
