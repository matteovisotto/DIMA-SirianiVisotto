//
//  MainViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 07/04/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    public static let tabs: [TabElement] = [
    TabElement(tag: 0, iconSystemName: "house", tabName: NSLocalizedString("Home", comment: "Home")),
    TabElement(tag: 1, iconSystemName: "sun.max", tabName: NSLocalizedString("Tracked", comment: "Tracked")),
    TabElement(tag: 2, iconSystemName: "calendar", tabName: NSLocalizedString("Explore", comment: "Explore")),
    TabElement(tag: 3, iconSystemName: "gear", tabName: NSLocalizedString("Settings", comment: "Settings")),
    ]
    
    @Published var selectedTab: Int = 0
    @Published var showLogin: Bool = false
}
