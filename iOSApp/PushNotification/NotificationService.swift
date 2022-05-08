//
//  NotificationService.swift
//  PushNotification
//
//  Created by Matteo Visotto on 08/05/22.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            let userInfo = bestAttemptContent.userInfo
            
            if let langData = (userInfo["lang"] as? String)?.data(using: .utf8) {
                do {
                    if let lang = try JSONSerialization.jsonObject(with: langData, options: []) as? [String: Any] {
                        guard let deviceLang = (Locale.preferredLanguages.first)?.split(separator: "-").first else {
                            contentHandler(bestAttemptContent)
                            return
                        }
                        
                        if let nLang = lang["\(deviceLang)"] as? [String: Any] {
                            if let title = nLang["title"] as? String, let body = nLang["body"] as? String {
                                bestAttemptContent.title = title
                                bestAttemptContent.body = body
                            }
                        }
                    }
                } catch {}
                    
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
