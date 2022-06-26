//
//  APTrackerApp.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

@main
struct myAPTrackerApp: App {
    let tutorialToSee: Bool
    
    init () {
        self.tutorialToSee = CommandLine.arguments.contains("-UITest_TutorialToSee")
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView(tutorialToSee: tutorialToSee)
                    .environmentObject(AppState.shared)
                    .onAppear {
                    if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: rootVC, action: #selector(rootVC.dismissKeyboard))
                        tap.cancelsTouchesInView = false
                        rootVC.view.addGestureRecognizer(tap)
                    }
                    }.onOpenURL { url in
                        let str = url.absoluteString
                        if str.contains("product?id") {
                            let id = str.split(separator: "=")[1]
                            AppDelegate.shared?.parseProduct(productId: String(id))
                        }
                    }
            } else {
                iPadContentView()
                    .environmentObject(AppState.shared)
                    .onAppear {
                    if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: rootVC, action: #selector(rootVC.dismissKeyboard))
                        tap.cancelsTouchesInView = false
                        rootVC.view.addGestureRecognizer(tap)
                    }
                    }.onOpenURL { url in
                        let str = url.absoluteString
                        if str.contains("product?id") {
                            let id = str.split(separator: "=")[1]
                            AppDelegate.shared?.parseProduct(productId: String(id))
                        }
                    }
                
            }
            
        }
    }
}
