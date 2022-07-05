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
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    public static var shared: AppDelegate? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.shared.applicationIconBadgeNumber = 0
        AppDelegate.shared = self
        if !WatchSessionManager.shared.isSuported() {
            print("WCSession not supported (f.e. on iPad).")
        }
        
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        setupRemotePushNotifications()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlString = url.absoluteString
        print(urlString)
        var handled: Bool
        ApplicationDelegate.shared.application(app,open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
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
        
        if #available(iOS 14.0, *) {
            completionHandler([.badge, .sound])
        } else {
            completionHandler([.alert, .badge, .sound])
        }
        
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        self.parseNotification(userInfo)
        completionHandler()
    }
    
    private func parseNotification(_ userInfo: [AnyHashable: Any]) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        if let type = userInfo["type"] as? String {
            if(type == "product"){
                if let productId = userInfo["productId"] as? String {
                    parseProduct(productId: productId)
                }
            }
        }
    }
    
    public func parseProduct(productId: String){
        let taskManger = TaskManager(urlString: AppConstant.getProductByIdURL+"?id=\(productId)&lastPriceOnly", method: .GET, parameters: nil)
        taskManger.execute { result, content, data in
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let product = try decoder.decode(Product.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.openProductView(product)
                        return
                    }
                } catch {
                    var errorStr = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                    do {
                        let error = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let e = error {
                            if let d = e["exception"] as? String {
                                errorStr = d
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                    }
                }
            }
        }
    }
    
    private func openProductView(_ product: Product){
    
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            var productViewController: UIViewController
            if UIDevice.current.userInterfaceIdiom == .phone {
                productViewController = UIHostingController(rootView: ProductView(product: product).environmentObject(AppState.shared))
            } else {
                productViewController = UIHostingController(rootView: FullScreenDismissableContainerView(content: {
                    iPadProductView(product: product).environmentObject(AppState.shared)
                }, title: product.shortName))
            }
            productViewController.modalPresentationStyle = .overFullScreen
            topController.present(productViewController, animated: true, completion: nil)
        }
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        processPushToken()
    }
}
