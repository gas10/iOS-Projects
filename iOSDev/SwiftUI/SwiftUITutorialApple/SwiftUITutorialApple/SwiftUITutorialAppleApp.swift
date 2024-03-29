//
//  SwiftUITutorialAppleApp.swift
//  SwiftUITutorialApple
//
//  Created by Amar Gawade on 9/10/23.
//

import SwiftUI

@main
struct SwiftUITutorialAppleApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }

        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
        #endif
    }
}
