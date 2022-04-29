//
//  AppDelegate.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import GoogleSignIn
import FacebookCore
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    public static var shared: AppDelegate? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppDelegate.shared = self
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        setupRemotePushNotifications()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var handled: Bool
    ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }
      return false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }

        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            DispatchQueue.main.async{
                AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("unable to register for remote notification", comment: "unable to register for remote notification"))
            }
        }
}

extension AppDelegate {
    private func setupRemotePushNotifications() {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound],
            completionHandler: { [weak self] granted, error in
                if granted {
                    FirebaseApp.configure()
                    FirebaseConfiguration.shared.setLoggerLevel(.min)
                    DispatchQueue.main.async {
                        AppState.shared.areNotificationsEnabled = true
                    }
                    self?.getNotificationSettingsAndRegister()
                    Messaging.messaging().delegate = self
                } else {
                    DispatchQueue.main.async {
                        AppState.shared.areNotificationsEnabled = false
                    }
                }
            })

    }

    private func getNotificationSettingsAndRegister() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    private func processPushToken() {
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            if let token = Messaging.messaging().fcmToken {
                /*
                 Controlli qui per non reinviare al server
                 */
                if let fcmToken = PreferenceManager.shared.getFCMToken() {
                    if(token != fcmToken){
                        registerPushTokenRemotely(deviceId: deviceId, token: token)
                    }
                } else {
                    registerPushTokenRemotely(deviceId: deviceId, token: token)
                }
                
            }
        }
        
    }
    
    func registerNotificationRemotlyOnLogin(){
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            if let token = Messaging.messaging().fcmToken {
                registerPushTokenRemotely(deviceId: deviceId, token: token)
            }
        }
    }
    
    private func registerPushTokenRemotely(deviceId: String, token: String) -> Void {
        let reqParam: [String: Any] = [
            "deviceId":deviceId,
            "fcmToken":token,
            "email":AppState.shared.userIdentity?.email ?? "none"
        ]
        let taskManger = TaskManager(urlString: AppConstant.fcmRegistration, method: .POST, parameters: reqParam)
        taskManger.execute { result, content, data in
            if(!result){
                DispatchQueue.main.async{
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Unable to register the device for notification", comment: "Unable to register the device for notification"))
                }
            } else {
                PreferenceManager.shared.setCurrentFCMToken(fcmToken: token)
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
/*
        let ui = notification.request.content.userInfo
        let type = ui["type"] as! String

        var category = UNNotificationCategory(identifier: "", actions: [], intentIdentifiers: [], options: [])

        switch type {
        case "type1":
            let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: [.foreground])
            let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: [.foreground, .destructive])

            category = UNNotificationCategory(identifier: "", actions: [acceptAction, declineAction], intentIdentifiers: [], options: [])
        default:
            break
        }

        UNUserNotificationCenter.current().setNotificationCategories([category])

        completionHandler([.alert, .badge, .sound])*/
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

       /* if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {

            let ui = response.notification.request.content.userInfo
            let type = ui["type"] as! String

            switch type {
            case "type1":
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                vc.selectedIndex = 0
                window.rootViewController = vc
                window.makeKeyAndVisible()
            default:
                break
            }
        }

        completionHandler()*/
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        processPushToken()
    }
}
