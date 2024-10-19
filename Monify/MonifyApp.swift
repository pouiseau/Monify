//
//  MonifyApp.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI

@main
struct MonifyApp: App {
    @StateObject var transactionListVM = TransactionList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
 
