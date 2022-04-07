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
    TabElement(tag: 1, iconSystemName: "sun.max", tabName: NSLocalizedString("Tab1", comment: "Tab1")),
    TabElement(tag: 2, iconSystemName: "calendar", tabName: NSLocalizedString("Tab2", comment: "tab")),
    TabElement(tag: 3, iconSystemName: "gear", tabName: NSLocalizedString("Settings", comment: "Settings")),
    ]
    
    @Published var selectedTab: Int = 0
    
}
