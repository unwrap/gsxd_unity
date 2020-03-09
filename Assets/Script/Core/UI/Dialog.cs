using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using System.Collections.Generic;

namespace UI
{
    [SLua.CustomLuaClass]
    public class Dialog
    {
        public delegate void DialogShowedDelegate(UIDialogView source);

        public delegate void DialogCloseDelegate(UIDialogView source, DialogState state);

        #region member

        private static UIDialogView mTargetDialog;
        private static UIDialogView mNextDialog;

        private static UIAlertView mCurrentAlert;

        private static GameObject mWaiting;

        #endregion

        #region public

        public static void Reset()
        {
            mTargetDialog = null;
            mNextDialog = null;
        }

        public static bool isShow
        {
            get
            {
                return Dialog.mTargetDialog != null;
            }
        }

        public static void Alert(string message)
        {
            if (mCurrentAlert != null)
            {
                mCurrentAlert.PlayStopAnim(delegate ()
                {
                    mCurrentAlert = null;
                    AlertEx(message);
                });
            }
            else
            {
                AlertEx(message);
            }
        }

        private static void AlertEx(string message)
        {
            GameObject go = ObjectPool.Spawn("base/alerttext.u3d", "alerttext");
            Text tfText = go.GetComponentInChildren<Text>();
            if (tfText != null)
            {
                tfText.text = message;
            }
            UIManager.Instance.AddAlert(go);
            mCurrentAlert = go.AddMissingComponent<UIAlertView>();
            mCurrentAlert.PlayAnim(RemoveAlert);
        }

        private static void RemoveAlert()
        {
            mCurrentAlert = null;
        }

        public static void ShowMessage(string message)
        {
            ShowMessage(message, null);
        }

        public static void ShowMessage(string message, Dialog.DialogCloseDelegate closeCallback)
        {
            ShowMessage(message, closeCallback, true, true, true);
        }

        public static void ShowMessage(string message, Dialog.DialogCloseDelegate closeCallback, bool showOK, bool showCancel, bool showClose)
        {
            GameObject go = ObjectPool.Spawn("base/messagepopup.u3d", "messagepopup");
            Transform tfText = go.transform.Find("Text");
            if (tfText != null)
            {
                Text text = tfText.GetComponent<Text>();
                if (text != null)
                {
                    text.text = message;
                }
            }

            Transform btnOK = go.transform.Find("btn/ButtonOK");
            if (btnOK != null)
            {
                btnOK.gameObject.SetActive(showOK);
            }

            Transform btnCancel = go.transform.Find("btn/ButtonCancel");
            if (btnCancel != null)
            {
                btnCancel.gameObject.SetActive(showCancel);
            }

            Transform btnClose = go.transform.Find("ButtonClose");
            if (btnClose != null)
            {
                btnClose.gameObject.SetActive(showClose);
            }

            Show(go, true, closeCallback);
        }

        public static void ShowWaiting()
        {
            Dialog.ShowWaiting(string.Empty);
        }

        public static void ShowWaiting(string message)
        {
            if(message == null)
            {
                message = string.Empty;
            }
            if (Dialog.mWaiting == null)
            {
                Dialog.mWaiting = ObjectPool.Spawn("base/waiting.u3d", "waiting");
                UIManager.Instance.AddWaiting(Dialog.mWaiting);
            }

            RectTransform tf = Dialog.mWaiting.transform as RectTransform;
            if (tf != null)
            {
                tf.offsetMax = Vector2.zero;
                tf.offsetMin = Vector2.zero;
                tf.anchorMin = Vector2.zero;
                tf.anchorMax = Vector2.one;
            }

            Transform tfText = Dialog.mWaiting.transform.Find("Text");
            if (tfText != null)
            {
                Text text = tfText.GetComponent<Text>();
                if (text != null)
                {
                    text.text = message;
                }
            }
        }

        public static void CloseWaiting()
        {
            if (Dialog.mWaiting != null)
            {
                ObjectPool.Recycle(Dialog.mWaiting);
                Dialog.mWaiting = null;
            }
        }

        public static void Show(GameObject go)
        {
            Show(go, true, null);
        }

        public static void Show(GameObject go, bool isModal, Dialog.DialogCloseDelegate closeCallback)
        {
            Show(go, isModal, closeCallback, null);
        }

        public static void Show(GameObject go, bool isModal, Dialog.DialogCloseDelegate closeCallback, Dialog.DialogShowedDelegate showCallback)
        {
            if (go == null)
            {
                return;
            }
            UIDialogView dialog = go.GetComponent<UIDialogView>();
            if (dialog == null)
            {
                dialog = go.AddComponent<UIDialogView>();
            }
            if (closeCallback != null)
            {
                dialog.hideCallback += closeCallback;
            }
            if(showCallback != null)
            {
                dialog.ShowedEvent += showCallback;
            }
            dialog.mIsModal = isModal;

            if (Dialog.mNextDialog != null)
            {
                Dialog.mNextDialog.Remove();
                Dialog.mNextDialog = null;
            }
            Dialog.mNextDialog = dialog;

            Hide(DialogState.OK, delegate
            {
                ShowEx();
            });
        }

        public static void Hide()
        {
            Hide(DialogState.OK, null);
        }

        public static void Hide(DialogCloseDelegate m)
        {
            Hide(DialogState.OK, m);
        }

        public static void Hide(DialogState state, DialogCloseDelegate m = null)
        {
            if (Dialog.mTargetDialog == null)
            {
                if (m != null)
                {
                    m(null, state);
                }
                return;
            }
            if (m != null)
            {
                Dialog.mTargetDialog.hideCallback += m;
            }
            Dialog.mTargetDialog.Hide(state);
        }

        #endregion

        #region private

        private static void ShowEx()
        {
            if (Dialog.mNextDialog == null)
            {
                return;
            }
            Dialog.mTargetDialog = Dialog.mNextDialog;
            Dialog.mNextDialog = null;

            if (Dialog.mTargetDialog.mIsModal)
            {
                UIManager.Instance.ShowModal(true);
            }
            else
            {
                UIManager.Instance.HideModal(true);
            }
            UIManager.Instance.AddDialog(Dialog.mTargetDialog.gameObject);

            Dialog.mTargetDialog.HideEvent += DialogHide;
            Dialog.mTargetDialog.Show();
        }

        private static void DialogHide(UIDialogView dialog, DialogState state)
        {
            UIManager.Instance.HideModal(true);
            Dialog.mTargetDialog = null;
        }

        #endregion
    }
}

[SLua.CustomLuaClass]
public enum DialogState
{
    OK,
    CANCEL,
    CLOSE
}
