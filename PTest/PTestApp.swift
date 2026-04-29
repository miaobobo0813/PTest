//
//  PTestApp.swift
//  PTest
//
//  Created by miaobobo on 2026/4/28.
//

import SwiftUI

@main
struct PTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
