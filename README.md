# MoEngage-Journify-Swift

MoEngage integration for Journify.

## Installation

### Swift Package Manager

In the Xcode `File` menu, click `Add Packages`.  You'll see a dialog where you can search for Swift packages.  In the search field, enter the URL to this [repo](https://github.com/journifyio/moengage-journify-ios).

### Manual Integration

1. Get `MoEngage-Journify` xcframework(s) from [releases](https://github.com/journifyio/moengage-journify-ios/releases). Use this version for checking dependencies in [`Package.swift](Package.swift).

1. Add all the XCFrameworks to `Frameworks, Libraries, and Embedded Content` section for the app target.

## Setup Journify SDK

Now head to the App Delegate file, and setup the Journify SDK by

1. Importing `Journify`, `Journify_MoEngage` and `MoEngageSDK`.
2. Initialize `MoEngageSDKConfig` object and call `initializeDefaultInstance` method of `MoEngageInitializer`.
3. Initialize `MoEngageDestination` as shown below:

Under your Journify-Swift library setup, add the MoEngage plugin using `journify.add(plugin: ...)` method. Now all your events will be tracked in MoEngage dashboard.

```swift
let analytics = Journify(configuration: Configuration(writeKey: "<YOUR WRITE KEY>")
                    .flushAt(3)
                    .trackApplicationLifecycleEvents(true))
let settings: MoEngageSettings = MoEngageSettings(apiKey: "YOUR APP ID")
analytics.add(plugin: MoEngageDestination(moengageSettings: settings))
```

### Swift

 ```swift
 import Journify_MoEngage
 import MoEngageSDK
 ...
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:  Any]?) -> Bool {
 ...
 
     let sdkConfig = MoEngageSDKConfig(withAppID: "YOUR APP ID")
     MoEngageInitializer.shared.initializeDefaultInstance(sdkConfig: sdkConfig)
     
     // Add your configuration key from Journify
     let analytics = Journify(configuration: Configuration(writeKey: "<YOUR WRITE KEY>")
                    .flushAt(3)
                    .trackApplicationLifecycleEvents(true))
     // Add Moengage Destination Plugin to send data from Journify to MoEngage
    let settings: MoEngageSettings = MoEngageSettings(apiKey: "YOUR_KEY")
    analytics.add(plugin: MoEngageDestination(moengageSettings: settings))
 ...
 }
 ```

## Tracking User Attribute

User attributes are specific traits of a user, like email, username, mobile, gender etc. **identify** lets you tie a user to their actions and record traits about them. It includes a unique User ID and any optional traits you know about them.

 ```Journify.main.identify(userId: "a user's id", traits: ["email": "a user's email address"])```


## Tracking Events

Event tracking is used to track user behaviour in an app. **track** lets you record the actions your users perform. Every action triggers i.e,“event”, which can also have associated attributes.

 ```Journify.main.track(name: "Item Purchased", properties: ["item": "Sword of Heracles"])```

That's all you need for tracking data.

## Reset Users

The *reset* method clears the SDK’s internal stores for the current user. This is useful for apps where users can log in and out with different identities over time.

 ```Journify.main.reset()```

## Install / Update Differentiation

Since you might integrate us when your app is already on the App Store, we would need to know whether your app update would be an actual UPDATE or an INSTALL.
To differentiate between those, use one of the method below:

 ```swift
 //For new Install call following
 MoEngageSDKAnalytics.sharedInstance.appStatus(.install);

 //For an app update call following
 MoEngageSDKAnalytics.sharedInstance.appStatus(.update);
 ```

For more info on this refer following [link](https://developers.moengage.com/hc/en-us/articles/4403910297620).

## Using features provided in MoEngage SDK

Along with tracking your user's activities, MoEngage iOS SDK also provides additional features which can be used for more effective user engagement:

### Push Notifications

Push Notifications are a great way to keep your users engaged and informed about your app. You have following options while implementing push notifications in your app:

#### Journify Push Implementation

1.In your application’s application:didReceiveRemoteNotification: method, add the following:

```swift
Journify.main.receivedRemoteNotification(userInfo: userInfo)
```

3.If you integrated the application:didReceiveRemoteNotification:fetchCompletionHandler: in your app, add the following to that method:

```swift
Journify.main.receivedRemoteNotification(userInfo: userInfo)
```

#### MoEngage Push Implementation

 Follow this link to implement Push Notification in your mobile app using MoEngage SDK:
 [**Push Notifications**](https://developers.moengage.com/hc/en-us/articles/4403943988756)

### In-App Messaging

In-App Messaging are custom views which you can send to a Journify of users to show custom messages or give new offers or take to some specific pages. Follow the link to know more about  inApp Messaging and how to implement it in your application:
[**InApp NATIV**](https://developers.moengage.com/hc/en-us/articles/4404155127828-In-App-Nativ)

## Journify Docs

For more info on using **Journify for iOS** refer to [**Developer Docs**](https://www.journify.io) provided by Journify.
