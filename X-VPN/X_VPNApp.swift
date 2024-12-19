//
//  X_VPNApp.swift
//  X-VPN
//
//  Created by Tanvir on 29/11/2024.
//

import SwiftUI
import SwiftData

@main
struct X_VPNApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Home()
        }
        .modelContainer(sharedModelContainer)
    }
}
