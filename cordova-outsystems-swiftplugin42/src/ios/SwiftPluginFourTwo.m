#import "SwiftPluginFourTwo.h"

@implementation SwiftPluginFourTwo

-(void)swiftHello:(CDVInvokedUrlCommand*) command {
    // Do not block the JavaScript main event loop
    [self.commandDelegate runInBackground:^{
        NSString* echoResult = [MyFrameworkClass echoFromFramework];
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echoResult];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
@end
