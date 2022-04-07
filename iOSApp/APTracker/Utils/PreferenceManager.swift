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
}
