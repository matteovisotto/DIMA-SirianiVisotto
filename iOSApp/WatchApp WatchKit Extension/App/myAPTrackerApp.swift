//
//  myAPTrackerApp.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

@main
struct myAPTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(WatchAppModel.shared)
            }
        }
    }
}
