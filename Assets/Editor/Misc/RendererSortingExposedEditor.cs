using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(RendererSortingExposed))]
public class RendererSortingExposedEditor : Editor
{
    public override void OnInspectorGUI()
    {
        // Get the renderer from the target object
        Renderer renderer = (target as RendererSortingExposed).gameObject.GetComponent<Renderer>();

        // If there is no renderer, we can't do anything
        if (!renderer)
        {
            return;
        }

        // Expose the sorting layer name
        string newSortingLayerName = EditorGUILayout.TextField("Sorting Layer Name", renderer.sortingLayerName);
        if (newSortingLayerName != renderer.sortingLayerName) {
            Undo.RecordObject(renderer, "Edit Sorting Layer Name");
            renderer.sortingLayerName = newSortingLayerName;
            EditorUtility.SetDirty(renderer);
        }

        // Expose the sorting layer ID
        int newSortingLayerId = EditorGUILayout.IntField("Sorting Layer ID", renderer.sortingLayerID);
        if (newSortingLayerId != renderer.sortingLayerID) {
            Undo.RecordObject(renderer, "Edit Sorting Layer ID");
            renderer.sortingLayerID = newSortingLayerId;
            EditorUtility.SetDirty(renderer);
        }

        // Expose the manual sorting order
        int newSortingLayerOrder = EditorGUILayout.IntField("Sorting Layer Order", renderer.sortingOrder);
        if (newSortingLayerOrder != renderer.sortingOrder) {
            Undo.RecordObject(renderer, "Edit Sorting Order");
            renderer.sortingOrder = newSortingLayerOrder;
            EditorUtility.SetDirty(renderer);
        }
    }
}
