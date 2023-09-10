//
//  TestApp.swift
//  Test
//
//  Created by Amar Gawade on 9/9/23.
//

import SwiftUI

@main
struct TestApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            NavigationAndListContentView()
                .environmentObject(modelData)
        }
    }
}
