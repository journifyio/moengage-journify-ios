//
//  AppDelegate.swift
//  BasicExample
//
//  Created by Deepa on 26/12/22.
//

import UIKit
import Journify
import Journify_MoEngage
import MoEngageSDK
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        let sdkConfig = MoEngageSDKConfig(appId: "YOUR APP ID", dataCenter: MoEngageDataCenter.data_center_01)
        sdkConfig.appGroupID = "group.bmex.moengage.example"
        sdkConfig.consoleLogConfig = .init(isLoggingEnabled: true, loglevel: .verbose)
        MoEngageInitializer.initializeDefaultInstance(sdkConfig: sdkConfig)
        MoEngageSDKMessaging.sharedInstance.registerForRemoteNotification(withCategories: nil, andUserNotificationCenterDelegate: self)
        requestPushNotificationPermission(application)

        return true
    }
    
    func requestPushNotificationPermission(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("Push notification permission denied: \(error?.localizedDescription ?? "No error")")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("BMEX APNs Device Token: \(tokenString)")
        Journify.main.registeredForRemoteNotifications(deviceToken: deviceToken)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        Journify.main.receivedRemoteNotification(userInfo: userInfo)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        MoEngageSDKMessaging.sharedInstance.userNotificationCenter(center, didReceive: response)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert , .sound])
    }
}

extension Journify {
    static let main: Journify = {
        let analytics = Journify(configuration: Configuration(writeKey: "<YOUR WRITE KEY>")
                            .flushAt(3)
                            .trackApplicationLifecycleEvents(true))
        let settings: MoEngageSettings = MoEngageSettings(apiKey: "YOUR APP ID")
        analytics.add(plugin: MoEngageDestination(moengageSettings: settings))
        return analytics
    }()
}
