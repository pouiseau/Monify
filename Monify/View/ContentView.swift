//
//  ContentView.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TransactionListViewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    ExpenseChartView().environmentObject(viewModel)
                
                    // MARK: Recent transactions
                    RecentTransactionListView().environmentObject(viewModel)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Add Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        NewTransactionView().environmentObject(viewModel)
                    } label: {
                        Image(systemName: "plus")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle( .primary)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
    
}

#Preview {
    ContentView()
}
