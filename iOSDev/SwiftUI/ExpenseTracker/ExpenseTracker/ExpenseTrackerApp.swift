//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

// MARK - Adding SwiftUI Chart
/*
 Download beta version, unzip and copy folder to project folder
 Now Go to ExpeseTracker(target) -> Framweork, Libraries and Embeded Content and Add it
 */

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
