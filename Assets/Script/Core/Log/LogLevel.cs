using System;

namespace OzLib.Log
{
    public enum LogLevel
    {
        NONE = 0x0,
        DEBUG = 0x1,
        INFO = 0x2,
        WARNING = 0x4,
        ERROR = 0x8,
        EXCEPT = 0x10,
        CRITICAL = 0x20
    }
}