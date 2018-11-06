# onfido-sdk-ionic-sample-app
Sample app showcasing the integration of the Onfido SDK on an Ionic app

## This project consists of 2 modules:
- `onfidoSampleApp` contains the sample app code
- `cordova-plugin-template` contains the Cordova plugin that wraps the Onfido Android SDK. Based on [this template](https://github.com/ionic-team/cordova-plugin-template)

## How to run:
Install the project, link the plugin to the sample app and add android or iOS platform

```
cd onfidoSampleApp
npm install
cordova plugin add --link ../cordova-plugin-template
cordova platform add android
```
iOS requires the Cocoapod support plugin for Cordova:
```
cd onfidoSampleApp
npm install
cordova plugin add --link ../cordova-plugin-template
cordova plugin add cordova-plugin-cocoapod-support
cordova platform add ios
```

## Edit for adding the SDK dependency 

### iOS
```
platforms/ios/Podfile
```

```
platform :ios, '9.0'
use_frameworks!
target 'onfidoSampleApp' do
pod 'Onfido', '9.0.0'
end
```

### Android (According to the [Android SDK Documentation](https://github.com/onfido/onfido-android-sdk#2-adding-the-sdk-dependency)):
```
platforms/android/app/build.gradle
```

```
repositories {
	maven {
		url  "https://dl.bintray.com/onfido/maven"
	}
}

dependencies {
	compile 'com.onfido.sdk.capture:onfido-capture-sdk:+'
}
```

## Build and start the app
### Android
```
ionic cordova build android
cordova emulate android
```
### iOS
```
ionic cordova build ios
cordova emulate ios
```


## TODO:
- Complete the e2e integration between the Ionic application and the Cordova plugin, with callbacks to the application.
