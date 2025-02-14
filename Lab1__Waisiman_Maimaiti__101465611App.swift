//
//  Lab1__Waisiman_Maimaiti__101465611App.swift
//  Lab1- Waisiman Maimaiti -101465611
//
//  Created by Family Vide on 2025-02-13.
//

import SwiftUI
import SwiftData

@main
struct Lab1__Waisiman_Maimaiti__101465611App: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
