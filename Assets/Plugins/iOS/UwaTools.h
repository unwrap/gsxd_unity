#include "RenderPluginDelegate.h"

extern "C" typedef void (*ScreenshotComplete)();
extern "C" typedef void (*UwaNetworkCallback)(u_int32_t download, u_int32_t upload);

@interface ScreenshotCreator : RenderPluginDelegate
{
    NSString*               screenshotPath;
    ScreenshotComplete      callback;

    BOOL                    requestedScreenshot;
    BOOL                    creatingScreenshot;
}
- (id)init;

- (void)onBeforeMainDisplaySurfaceRecreate:(struct RenderingSurfaceParams*)params;
- (void)onFrameResolved;

- (void)queryScreenshot:(NSString*)path callback:(ScreenshotComplete)callback;

@end

@interface UwaSystemInfo :NSObject
+ (float) uwaGetBatteryLevel;
+ (void) uwaGetWifiInterfaceBytes:(UwaNetworkCallback)callback;
+ (float) uwaGetUsedMemory;
@end

extern "C"
{
    void _registerPlugin(bool log);
    void _unregisterPlugin();
}
