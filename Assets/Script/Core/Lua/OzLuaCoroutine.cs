using UnityEngine;
using System.Collections;
using SLua;

[SLua.CustomLuaClass]
public class OzLuaCoroutine : MonoBehaviour
{
    public void ExecuteWhen(object instruction, LuaFunction func, object param)
    {
        StartCoroutine(ExecuteWhenCoroutine(instruction, func, param));
    }

    private IEnumerator ExecuteWhenCoroutine(object instruction, LuaFunction func, object param)
    {
        yield return instruction;
        func.call(param);
    }
}
