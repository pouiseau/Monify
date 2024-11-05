//
//  ContentView.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var transactionList: TransactionList
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Recent transactions
                    RecentTransactionList()
                        .environmentObject(transactionList)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.customIcon, .primary)
                }
                
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    let transactionList: TransactionList = {
        let transactionList = TransactionList()
        transactionList.transactions = transactionListPreviewData
        return transactionList
    }()
    
    ContentView()
        .environmentObject(transactionList)
}
