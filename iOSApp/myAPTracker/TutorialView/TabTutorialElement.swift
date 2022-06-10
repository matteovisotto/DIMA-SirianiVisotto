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
    TabTutorialElement(id: UUID().uuidString, title: "myAPTracker", subtitle: "Welcome in", description: "Keep track of your favourite Amazon product", image: "person.fill", color: Color("Tutorial1"), fontColor: Color("Tutorial3")),
    TabTutorialElement(title: "Stay update", subtitle: "Create your account", description: "Create an account or sign in via socials", image: "applewatch", color: Color("Tutorial2"), fontColor: Color("Tutorial3")),
    TabTutorialElement(title: "Get notified", subtitle: "Track every product", description: "Get notified whenever your tracked product has a lower price", image: "iphone", color: Color("Tutorial3"), fontColor: Color("Tutorial1"))
]

