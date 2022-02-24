//
//  APTrackerApp.swift
//  Shared
//
//  Created by Tia on 24/02/22.
//

import SwiftUI

@main
struct APTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
