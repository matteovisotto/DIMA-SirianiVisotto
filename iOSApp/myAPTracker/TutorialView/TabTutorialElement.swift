//
//  TabElements.swift
//  APTracker
//
//  Created by Tia on 16/04/22.
//

import Foundation
import SwiftUI

struct TabTutorialElement: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subtitle: String
    var description: String
    var image: String
    var color: Color
}

var tabTutorialElement: [TabTutorialElement] = [
    TabTutorialElement(title: "First tab", subtitle: "First subtitle", description: "First description", image: "ipad", color: Color(.systemBlue)),
    TabTutorialElement(title: "Second tab", subtitle: "Second subtitle", description: "Second description", image: "applewatch", color: Color(.systemRed)),
    TabTutorialElement(title: "Third tab", subtitle: "Third subtitle", description: "Third description", image: "iphone", color: Color(.systemYellow))
]
