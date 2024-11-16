//
//  ContentView.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionList: TransactionListViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    let data = transactionList.accumulate()
                    
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView (showShadow: false) {
                            VStack (alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                LineChart()
                            }.background(Color.systemBackground)
                            
                        }
                            .data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    
                    // MARK: Recent transactions
                    RecentTransactionListView()
                        .environmentObject(transactionList)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.customBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Add Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewTransaction()) {
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
    let transactionList: TransactionListViewModel = {
        let transactionList = TransactionListViewModel()
        transactionList.transactions = transactionListPreviewData
        return transactionList
    }()
    
    ContentView()
        .environmentObject(transactionList)
}
