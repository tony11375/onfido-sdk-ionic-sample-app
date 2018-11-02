#import "MyCordovaPlugin.h"

#import <Cordova/CDVAvailability.h>
#import <Onfido/Onfido.h>

@implementation MyCordovaPlugin
    
- (void)pluginInitialize {
}
    
- (void)launchFido:(CDVInvokedUrlCommand *)command {
    //NSString* phrase = [command.arguments objectAtIndex:0];
    
    NSError *configError = NULL;
    ONFlowConfig *config = [[self getOnfidoConfigBuilder] buildAndReturnError:&configError];
    if (configError == NULL) {
        ONFlow * onFlow = [[ONFlow alloc] initWithFlowConfiguration: config];
        [onFlow withResponseHandler:^(ONFlowResponse *response) {
            if (response.results) {
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"dd/MM/yyyy"];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[df stringFromDate:[NSDate date]]];
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
    
- (ONApplicant*) getApplicant {
    return [ONApplicant newWithFirstName:@"Ionic" lastName:@"User"];
}
    
- (ONFlowConfigBuilder*) getOnfidoConfigBuilder {
    ONFlowConfigBuilder *configBuilder = [ONFlowConfig builder];
    [configBuilder withToken:@"YOUR_MOBILE_TOKEN"];
    [configBuilder withApplicant:[self getApplicant]];
    [configBuilder withDocumentStep];
    [configBuilder withFaceStepOfVariant:ONFaceStepVariantPhoto];
    return configBuilder;
}
    
    @end
