//
//  PreferenceManager.swift
//  APTracker
//
//  Created by Tia on 07/04/22.
//

import Foundation

class PreferenceManager {
    public static
    let shared: PreferenceManager = PreferenceManager()
    let userDefaults = UserDefaults.standard
    
    func setUserIdentity(_ userIdenty: UserIdentity) {
        if let data = try? JSONEncoder().encode(userIdenty) {
            userDefaults.set(data, forKey: "userIdentity")
        }
    }
    
    func getUserIdentity() -> UserIdentity? {
        guard let data = userDefaults.value(forKey: "userIdentity") as? Data else {return nil}
        if let userIdentity = try? JSONDecoder().decode(UserIdentity.self, from: data) {
            return userIdentity
        }
        return nil
    }
    
    func removeUserIdentity() {
        userDefaults.removeObject(forKey: "userIdentity")
    }
    
    func setTutorialAlreadySeen(_ tutorialAlreadySeen: Bool) {
        userDefaults.set(tutorialAlreadySeen, forKey: "tutorialAlreadySeen")
    }
    
    func getTutorialAlreadySeen() -> Bool {
        return userDefaults.bool(forKey: "tutorialAlreadySeen")
    }
    
    func setCurrentFCMToken(fcmToken: String) -> Void {
        userDefaults.set(fcmToken, forKey: "fcmToken")
    }
    
    func getFCMToken() -> String? {
        return userDefaults.string(forKey: "fcmToken")
    }
    
    func setDropKey(_ dropKey: String) -> Void {
        userDefaults.set(dropKey, forKey: "dropKey")
    }
    
    func setDropValue(_ dropValue: Double) -> Void {
        userDefaults.set(dropValue, forKey: "dropValue")
    }
    
    func getDropKey() -> String {
        return userDefaults.string(forKey: "dropKey") ?? "always"
    }
    
    func getDropValue() -> Double {
        return userDefaults.double(forKey: "dropValue") 
    }
    
    func setCommentPolicy(_ commentPolicy: String) -> Void {
        userDefaults.set(commentPolicy, forKey: "commentPolicy")
    }
    
    func getCommentPolicy() -> String {
        return userDefaults.string(forKey: "commentPolicy") ?? "never"
    }
}
