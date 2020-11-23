#import "SwiftPluginFiveFive.h"

@implementation SwiftPluginFiveFive

-(void)swiftHello:(CDVInvokedUrlCommand*) command {
    // Do not block the JavaScript main event loop
    [self.commandDelegate runInBackground:^{
        NSString* echoResult = [MyFrameworkFiveFiveClass echoFromFramework];
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echoResult];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
@end
