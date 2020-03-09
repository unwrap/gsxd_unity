using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LuaStateMachineBehaviour : StateMachineBehaviour
{
    public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        LuaMonoBehaviour luaMono = animator.gameObject.GetComponent<LuaMonoBehaviour>();
        if(luaMono != null)
        {
            luaMono.CallLuaFunction("OnStateEnter", stateInfo.fullPathHash);
        }
    }

    public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        LuaMonoBehaviour luaMono = animator.gameObject.GetComponent<LuaMonoBehaviour>();
        if (luaMono != null)
        {
            luaMono.CallLuaFunction("OnStateExit", stateInfo.fullPathHash);
        }
    }

    public override void OnStateMachineEnter(Animator animator, int stateMachinePathHash)
    {
        LuaMonoBehaviour luaMono = animator.gameObject.GetComponent<LuaMonoBehaviour>();
        if (luaMono != null)
        {
            luaMono.CallLuaFunction("OnStateMachineEnter", stateMachinePathHash);
        }
    }

    public override void OnStateMachineExit(Animator animator, int stateMachinePathHash)
    {
        LuaMonoBehaviour luaMono = animator.gameObject.GetComponent<LuaMonoBehaviour>();
        if (luaMono != null)
        {
            luaMono.CallLuaFunction("OnStateMachineExit", stateMachinePathHash);
        }
    }
}
