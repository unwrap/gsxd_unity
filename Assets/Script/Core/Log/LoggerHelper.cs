using System;
using UnityEngine;
using System.Diagnostics;
using System.Reflection;
using System.Text;

namespace OzLib.Log
{
    [SLua.CustomLuaClass]
    public class LoggerHelper
    {
        public static LogLevel CurrentLogLevels = LogLevel.NONE | LogLevel.DEBUG | LogLevel.INFO | LogLevel.WARNING | LogLevel.ERROR | LogLevel.EXCEPT | LogLevel.CRITICAL;
        public static string DebugFilterStr = string.Empty;
        public static bool logEnabled = true;

        private static LogWriter mLogWriter = new LogWriter();
        private const bool SHOW_STACK = true;
        private static ulong index = 0L;

        static LoggerHelper()
        {
            /*
#if UNITY_5
            Application.logMessageReceived += LoggerHelper.ProcessExceptionReport;
#else
		    Application.RegisterLogCallback(new Application.LogCallback(LoggerHelper.ProcessExceptionReport));
#endif
            */
        }

        public static void Release()
        {
            mLogWriter.Release();
        }

        public static void Debug(object message, bool isShowStack = false)
        {
            if ((DebugFilterStr == "") && (LogLevel.DEBUG == (CurrentLogLevels & LogLevel.DEBUG)))
            {
                object[] objArray = new object[5];
                objArray[0] = " [DEBUG]: ";
                objArray[1] = isShowStack ? GetStacksInfo() : "";
                objArray[2] = message;
                objArray[3] = " Index = ";
                index += 1L;
                objArray[4] = index;
                Log(string.Concat(objArray), LogLevel.DEBUG, true);
            }
        }

        public static void Info(object message, bool isShowStack = false)
        {
            if (LogLevel.INFO == (CurrentLogLevels & LogLevel.INFO))
            {
                Log(" [INFO]: " + (isShowStack ? GetStackInfo() : "") + message, LogLevel.INFO, true);
            }
        }

        public static void Warning(object message, bool isShowStack = false)
        {
            if (LogLevel.WARNING == (CurrentLogLevels & LogLevel.WARNING))
            {
                Log(" [WARNING]: " + (isShowStack ? GetStackInfo() : "") + message, LogLevel.WARNING, true);
            }
        }

        public static void Error(object message, bool isShowStack = false)
        {
            if (LogLevel.ERROR == (CurrentLogLevels & LogLevel.ERROR))
            {
                Log(string.Concat(new object[] { " [ERROR]: ", message, '\n', isShowStack ? GetStacksInfo() : "" }), LogLevel.ERROR, true);
            }
        }

        public static void Except(Exception ex, object message = null)
        {
            if (LogLevel.EXCEPT == (CurrentLogLevels & LogLevel.EXCEPT))
            {
                Exception innerException = ex;
                while (innerException.InnerException != null)
                {
                    innerException = innerException.InnerException;
                }
                Log(" [EXCEPT]: " + ((message == null) ? "" : (message + "\n")) + ex.Message + innerException.StackTrace, LogLevel.CRITICAL, true);
            }
        }

        public static void Critical(object message, bool isShowStack = false)
        {
            if (LogLevel.CRITICAL == (CurrentLogLevels & LogLevel.CRITICAL))
            {
                Log(string.Concat(new object[] { " [CRITICAL]: ", message, '\n', isShowStack ? GetStacksInfo() : "" }), LogLevel.CRITICAL, true);
            }
        }

        private static void Log(string message, LogLevel level, bool writeEditorLog = true)
        {
            if(LoggerHelper.logEnabled)
            {
                string msg = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss,fff") + message;
                mLogWriter.WriteLog(msg, level, false);
            }
        }

        private static string GetStackInfo()
        {
            StackTrace trace = new StackTrace();
            MethodBase method = trace.GetFrame(2).GetMethod();
            return string.Format("{0}.{1}(): ", method.ReflectedType.Name, method.Name);
        }

        private static string GetStacksInfo()
        {
            StringBuilder builder = new StringBuilder();
            StackFrame[] frames = new StackTrace().GetFrames();
            for (int i = 2; i < frames.Length; i++)
            {
                builder.AppendLine(frames[i].ToString());
            }
            return builder.ToString();
        }

        private static void ProcessExceptionReport(string message, string stackTrace, LogType type)
        {
            LogLevel level = LogLevel.DEBUG;
            switch (type)
            {
                case LogType.Error:
                    level = LogLevel.ERROR;
                    break;
                case LogType.Assert:
                    level = LogLevel.DEBUG;
                    break;
                case LogType.Warning:
                    level = LogLevel.WARNING;
                    break;
                case LogType.Log:
                    level = LogLevel.DEBUG;
                    break;
                case LogType.Exception:
                    level = LogLevel.EXCEPT;
                    break;
            }
            if (level == (CurrentLogLevels & level))
            {
                if (type == LogType.Error || type == LogType.Warning || type == LogType.Exception)
                {
                    Log(string.Concat(new object[] { " [SYS_", level, "]: ", message, '\n', stackTrace }), level, false);
					//OzDebug.Log (message);
                }
            }
        }
    }
}

