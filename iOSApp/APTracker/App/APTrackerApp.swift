//
//  APTrackerApp.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

@main
struct APTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppState.shared).onAppear {
                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: rootVC, action: #selector(rootVC.dismissKeyboard))
                    tap.cancelsTouchesInView = false
                    rootVC.view.addGestureRecognizer(tap)
                }
            }
        }
    }
}
