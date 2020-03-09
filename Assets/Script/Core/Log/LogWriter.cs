using System;
using System.IO;
using UnityEngine;
using System.Threading;

namespace OzLib.Log
{

    public class LogWriter
    {
        public static readonly object mLocker = new object();

        private FileStream mFStream;
        private StreamWriter mStreamWriter;

        private string mLogFileName = "log_{0}.txt";
        private string mLogFilePath;
        private string mLogPath = Application.persistentDataPath + "/log/";

        public LogWriter()
        {
            this.mLogFilePath = this.mLogPath + string.Format(this.mLogFileName, DateTime.Today.ToString("yyyyMMdd"));
            try
            {
                if (!Directory.Exists(this.mLogPath))
                {
                    Directory.CreateDirectory(this.mLogPath);
                }
                this.mFStream = new FileStream(this.mLogFilePath, FileMode.Append, FileAccess.Write, FileShare.ReadWrite);
                this.mStreamWriter = new StreamWriter(this.mFStream);
            }
            catch (Exception ex)
            {
                Debug.Log(ex.Message);
            }
        }

        public void WriteLog(string msg, LogLevel level, bool writeEditorLog)
        {
            //Write( msg, level, writeEditorLog );

            LogSaveThread sThread = new LogSaveThread(this.mStreamWriter, msg, level, writeEditorLog);
            Thread th = new Thread(new ThreadStart(sThread.run));
            th.Start();
        }

        public void Release()
        {
            lock (mLocker)
            {
                if (this.mStreamWriter != null)
                {
                    this.mStreamWriter.Close();
                    this.mStreamWriter.Dispose();
                }
                if (this.mFStream != null)
                {
                    this.mFStream.Close();
                    this.mFStream.Dispose();
                }
            }
        }

        private void Write(string msg, LogLevel level, bool writeEditorLog)
        {

        }

        private class LogSaveThread
        {


            private string msg;
            private LogLevel level;
            private bool writeEditorLog;

            private StreamWriter mStreamWriter;

            public LogSaveThread(StreamWriter sw, string msg, LogLevel level, bool writeEditorLog)
            {
                this.mStreamWriter = sw;
                this.msg = msg;
                this.level = level;
                this.writeEditorLog = writeEditorLog;
            }

            public void run()
            {
                Monitor.Enter(LogWriter.mLocker);
                try
                {
                    if (writeEditorLog)
                    {
                        switch (level)
                        {
                            case LogLevel.DEBUG:
                            case LogLevel.INFO:
                                Debug.Log(msg);
                                break;
                            case LogLevel.WARNING:
                                Debug.LogWarning(msg);
                                break;
                            case LogLevel.ERROR:
                                Debug.LogError(msg);
                                break;
                            default:
                                break;
                        }
                    }

                    if (this.mStreamWriter != null)
                    {
                        this.mStreamWriter.WriteLine(msg);
                        this.mStreamWriter.Flush();
                    }
                }
                catch (Exception ex)
                {
                    Debug.LogError(ex.Message);
                }
                finally
                {
                    Monitor.Exit(LogWriter.mLocker);
                }
            }
        }
    }
}
