//
//  GroupPreferenceManager.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation

class GroupPreferenceManager {
    public static let shared: GroupPreferenceManager = GroupPreferenceManager()
    
    let userDefaults = UserDefaults(suiteName: "group.it.matteovisotto.aptracker")
    
    func getApiType() -> Int {
        return userDefaults?.integer(forKey: "widgetApiType") ?? 0
    }
    
    func setApiType(type: Int) {
        userDefaults?.set(type, forKey: "widgetApiType")
    }
    
    func getWidgetType() -> Int {
        return userDefaults?.integer(forKey: "widgetWidgetType") ?? 0
    }
    
    func setWidgetType(type: Int) {
        userDefaults?.set(type, forKey: "widgetWidgetType")
    }
    
    
}
