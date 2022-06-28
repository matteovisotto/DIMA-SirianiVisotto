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
    var fontColor: Color
}

var tabTutorialElement: [TabTutorialElement] = [
    TabTutorialElement(id: UUID().uuidString, title: "myAPTracker", subtitle: NSLocalizedString("Welcome in", comment: "Welcome in"), description: NSLocalizedString("Keep track of your favourite Amazon product", comment: "Keep track of your favourite Amazon product"), image: "hand.thumbsup", color: Color("Tutorial1"), fontColor: Color("Tutorial3")),
    TabTutorialElement(title: NSLocalizedString("Stay update", comment: "Stay update"), subtitle: NSLocalizedString("Create your account", comment: "Create your account"), description: NSLocalizedString("Create an account or sign in via socials", comment: "Create an account or sign in via socials"), image: "waveform.path.ecg", color: Color("Tutorial2"), fontColor: Color("Tutorial3")),
    TabTutorialElement(title: NSLocalizedString("Get notified", comment: "Get notified"), subtitle: NSLocalizedString("Track every product", comment: "Track every product"), description: NSLocalizedString("Get notified whenever your tracked product has a lower price", comment: "Get notified whenever your tracked product has a lower price"), image: "bell.fill", color: Color("Tutorial3"), fontColor: Color("Tutorial1"))
]

