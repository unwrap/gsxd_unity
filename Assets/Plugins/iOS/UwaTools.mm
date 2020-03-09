#import "UwaTools.h"
#import <ifaddrs.h>
#import <sys/socket.h>
#import <net/if.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <UnityAppController.h>
#include "UnityView.h"
#include "GlesHelper.h"
#include "DisplayManager.h"

static ScreenshotCreator* _Creator = nil;

@implementation ScreenshotCreator
{
    char*   imageBuffer;
    int     bufferSize;

    int     bufferW;
    int     bufferRowLen;
    int     bufferH;

    int     imageW;
    int     imageH;

    BOOL    bufferFlipped;
@public BOOL showLog;
}

- (id)init
{
    NSAssert(_Creator == nil, @"You can have only one instance of ScreenshotCreator");
    if ((self = [super init]))
    {
        self->screenshotPath = nil;
        self->callback = nil;

        self->requestedScreenshot = self->creatingScreenshot = NO;

        imageBuffer = 0;
        bufferSize = imageW = imageH = 0;
    }

    _Creator = self;
    return self;
}
- (void)onBeforeMainDisplaySurfaceRecreate:(struct RenderingSurfaceParams*)params
{
    if (showLog) NSLog(@"onBeforeMainDisplaySurfaceRecreate");
    params->useCVTextureCache = true;
}

- (void)onFrameResolved
{
    if (showLog) NSLog(@"onFrameResolved");
    if (self->requestedScreenshot)
    {
        self->creatingScreenshot = YES;

        UnityDisplaySurfaceBase* ss = GetAppController().mainDisplay.surface;
        
        CVPixelBufferRef pixelBuf = (CVPixelBufferRef)ss->cvPixelBuffer;

        bufferSize      = CVPixelBufferGetDataSize(pixelBuf);
        imageBuffer     = (char*)::malloc(bufferSize);
        bufferW         = CVPixelBufferGetWidth(pixelBuf);
        bufferH         = CVPixelBufferGetHeight(pixelBuf);
        bufferRowLen    = CVPixelBufferGetBytesPerRow(pixelBuf);
        bufferFlipped   = CVOpenGLESTextureIsFlipped((CVOpenGLESTextureRef)ss->cvTextureCacheTexture);

        imageW  = ss->targetW;
        imageH  = ss->targetH;

        // we need to copy data to avoid stalling gl
        CVPixelBufferLockBaseAddress(pixelBuf, kCVPixelBufferLock_ReadOnly);
        {
            ::memcpy(imageBuffer, CVPixelBufferGetBaseAddress(pixelBuf), bufferSize);
        }
        CVPixelBufferUnlockBaseAddress(pixelBuf, kCVPixelBufferLock_ReadOnly);
        [self performSelectorInBackground: @selector(saveImage) withObject: NULL];
    }
    self->requestedScreenshot = NO;
}

- (void)queryScreenshot:(NSString*)path callback:(ScreenshotComplete)callback_
{
    if (showLog) NSLog(@"queryScreenshot");
    if (!self->creatingScreenshot)
    {
#if !__has_feature(objc_arc)
        if (self->screenshotPath != nil) [self->screenshotPath release];
        
        self->screenshotPath = [path mutableCopy];
#else
        self->screenshotPath = path;
#endif
        self->callback = callback_;
        self->requestedScreenshot = YES;
    }
}

- (void)saveImage
{
    // we need to convert bgra->rgba and possibly flip image upside-down
    // bgra->rgba can be done with Accelerate.framework vImagePermuteChannels_ARGB8888
    // also manual flipping could be avoided if we used pnglib directly (write png rows right away)
    // anyway we strive for min deps here ;-)
    if (showLog) NSLog(@"saveImage");
    char* finalImageData = (char*)::malloc(4 * imageW * imageH);
    {
        const int srcRowSize = bufferRowLen;
        const int dstRowSize = 4 * imageW;
        const int srcRowNext = bufferFlipped ? -srcRowSize : srcRowSize;

        char* srcRow = imageBuffer;
        char* dstRow = finalImageData;

        if (bufferFlipped)   srcRow = imageBuffer + (bufferH - 1) * srcRowSize;
        else                srcRow = imageBuffer;

        for (int i = 0; i < imageH; ++i, srcRow += srcRowNext, dstRow += dstRowSize)
        {
            for (int j = 0; j < imageW; ++j)
            {
                dstRow[4 * j + 0] = srcRow[4 * j + 2];
                dstRow[4 * j + 1] = srcRow[4 * j + 1];
                dstRow[4 * j + 2] = srcRow[4 * j + 0];
                dstRow[4 * j + 3] = srcRow[4 * j + 3];
            }
        }
    }
    ::free(imageBuffer);

    CGDataProviderRef cgProvider = CGDataProviderCreateWithData(0, finalImageData, 4 * imageW * imageH, 0);
    CGColorSpaceRef cgColorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage =
        CGImageCreate(imageW, imageH, 8, 32, 4 * imageW,
            cgColorSpace, kCGBitmapByteOrderDefault, cgProvider, 0, NO, kCGRenderingIntentDefault
            );
    CGDataProviderRelease(cgProvider);
    CGColorSpaceRelease(cgColorSpace);

    UIImage* image = [UIImage imageWithCGImage: cgImage];
    CGImageRelease(cgImage);

    NSURL* fileUrl   =[NSURL fileURLWithPath:screenshotPath];
    NSData* jpgData = UIImageJPEGRepresentation(image,0.5);
    if([jpgData writeToURL: fileUrl atomically: YES])
    {
    }
    ::free(finalImageData);

    [self performSelectorOnMainThread: @selector(doneSavingImage) withObject: NULL waitUntilDone: NO];
}

- (void)doneSavingImage
{
    self->creatingScreenshot = NO;
    self->callback();
}

@end


extern "C" void uwaTakeImage(const char* filename, ScreenshotComplete complete)
{
    [_Creator queryScreenshot: [NSString stringWithUTF8String: filename] callback: complete];
}


@implementation UwaSystemInfo

+(float) uwaGetBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [UIDevice currentDevice].batteryLevel;
}
+(void) uwaGetWifiInterfaceBytes:(UwaNetworkCallback)callback
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        callback(0,0);
        return;
    }
    u_int32_t iBytes = 0;
    u_int32_t oBytes = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            //NSLog(@"%s :iBytes is %d, oBytes is %d", ifa->ifa_name, iBytes, oBytes);
        }
    }
    freeifaddrs(ifa_list);
    //return iBytes + oBytes;
    callback(iBytes, oBytes);
}
+ (float) uwaGetUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    return taskInfo.resident_size / 1024.0f;
}
@end

extern "C"
{
    void _registerPlugin(bool log) {
        _Creator = [[ScreenshotCreator alloc] init];
        
        if (log)
        {
            _Creator->showLog = true;
            NSLog(@"screen shot log enabled");
        }
        
        RenderPluginArrayDelegate* rad = [[RenderPluginArrayDelegate alloc] init];
        
        rad.delegateArray = [NSArray array];
        
        if (GetAppController().renderDelegate != nil)
        {
            if (log) NSLog(@"add old renderDelegate");
            rad.delegateArray = [rad.delegateArray arrayByAddingObject:GetAppController().renderDelegate];
        }
        rad.delegateArray = [rad.delegateArray arrayByAddingObject:_Creator];
        
        GetAppController().renderDelegate = rad;
        
        if (log) NSLog(@"recreateRenderingSurface");
        
#if UNITY_VERSION < 201720
        [GetAppController().unityView recreateGLESSurface];
#else
        [GetAppController().unityView recreateRenderingSurface];
#endif
    }
    
    void _unregisterPlugin() {
    }
    
    const char* uwaBundleShortVersion()
    {
        return [[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"] UTF8String];
    }
    const char* uwaGetBundleIdentifier()
    {
        return [[[NSBundle mainBundle]bundleIdentifier] UTF8String];
    }
    const char* uwaGetBundleDisplayName()
    {
        return [[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"] UTF8String];
    }
    float uwaGetBatteryLevel()
    {
        return [UwaSystemInfo uwaGetBatteryLevel];
    }
    float uwaGetUsedMemory()
    {
        return [UwaSystemInfo uwaGetUsedMemory];
    }
    void  uwaGetWifiInterfaceBytes(UwaNetworkCallback callback)
    {
        [UwaSystemInfo uwaGetWifiInterfaceBytes:callback];
    }
}
