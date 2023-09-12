 //
//  BrokeApp.swift
//  Broke
//
//  Created by Wilson Mak on 2023-09-08.
//

import SwiftUI

@main
struct BrokeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
