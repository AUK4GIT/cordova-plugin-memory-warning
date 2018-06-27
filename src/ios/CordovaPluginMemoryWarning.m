#import <Cordova/CDV.h>
#import "CordovaPluginMemoryWarning.h"

@implementation CordovaPluginMemoryWarning

- (void)pluginInitialize
{

}

- (void)isMemoryUsageUnsafe:(CDVInvokedUrlCommand*)command
{
    // no need to check memory usage on iOS
    // onMemoryWarning will be triggered when iOS determines app is getting close to memory limit
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)onMemoryWarning
{
    NSString *jsCommand = @"cordova.fireDocumentEvent('memorywarning');";
    [self.commandDelegate evalJs:jsCommand];
    NSLog(@"cordova-plugin-memory-warning: received a memory warning");
}

- (void)getUsableSpace:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    //NSString* echo = [command.arguments objectAtIndex:0];
    
    @try{
        long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: [NSString stringWithFormat:@"%lld", freeSpace]];
    }
    @catch (NSException *exception){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
