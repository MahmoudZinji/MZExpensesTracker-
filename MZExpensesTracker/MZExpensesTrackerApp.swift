//
//  MZExpensesTrackerApp.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import SwiftUI

@main
struct MZExpensesTrackerApp: App {

    @StateObject var transactionListViewModel = TransactionListViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListViewModel)
        }
    }
}
