#import "MyCordovaPlugin.h"

#import <Cordova/CDVAvailability.h>
#import <Onfido/Onfido.h>

@implementation MyCordovaPlugin

/// Plugin Initializer
- (void)pluginInitialize {
}

/// Start the Onfido process
///
/// - parameter command: The command sent by Cordova iface
- (void)launchFido:(CDVInvokedUrlCommand *)command {
    
    NSError *configError = NULL;
    ONFlowConfig *config = [[self getOnfidoConfigBuilder] buildAndReturnError:&configError];
    if (configError == NULL) {
        ONFlow * onFlow = [[ONFlow alloc] initWithFlowConfiguration: config];
        [onFlow withResponseHandler:^(ONFlowResponse *response) {
            if (response.userCanceled) {
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"user canceled"];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            }
            else if (response.results) {
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"dd/MM/yyyy"];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[df stringFromDate:[NSDate date]]];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            }
            else if (response.error) {
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.error.description];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            }
        }];
        NSError *runError = NULL;
        UIViewController *onfidoController = [onFlow runAndReturnError:&runError];
        if (runError == NULL) {
            [self.viewController presentViewController:onfidoController animated:YES completion:nil];
        }
    }
    
}

/// Get a new `ONApplicant` instance
///
/// returns: The `ONApplicant`
- (ONApplicant*) getApplicant {
    return [ONApplicant newWithFirstName:@"Ionic" lastName:@"User"];
}

/// Get the `ONFlowConfig` builder
///
/// returns: the builder
- (ONFlowConfigBuilder*) getOnfidoConfigBuilder {
    ONFlowConfigBuilder *configBuilder = [ONFlowConfig builder];
    [configBuilder withToken:@"YOUR_MOBILE_TOKEN"];
    [configBuilder withApplicant:[self getApplicant]];
    [configBuilder withDocumentStep];
    [configBuilder withFaceStepOfVariant:ONFaceStepVariantPhoto];
    return configBuilder;
}
    
    @end
