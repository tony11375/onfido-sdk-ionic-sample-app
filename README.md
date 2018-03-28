# onfido-sdk-ionic-sample-app
Sample app showcasing the integration of the Onfido SDK on an Ionic app

This project consists of 2 modules:
- `onfidoSampleApp` contains the sample app code
- `cordova-plugin-template` contains the Cordova plugin that wraps the Onfido Android SDK. Based on [this template](https://github.com/ionic-team/cordova-plugin-template)

How to run:

`cd cordova-plugin-template && cordova build android`
Builds the cordova plugin wrapping the Onfido Android SDK

`cd onfidoSampleApp && cordova plugin add --link ../cordova-plugin-template` 
Links the plugin to the sample app

`ionic serve` 
Starts the app


TODO:
- Complete the e2e integration between the Ionic application and the Cordova plugin, with callbacks to the application.