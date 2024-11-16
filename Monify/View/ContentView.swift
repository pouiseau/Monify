//
//  ContentView.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI
import SwiftUICharts

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
                    
                    // MARK: Chart
                    let data = transactionList.accumulate()
                    
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack (alignment: .leading) {
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                LineChart()
                            }.background(Color.systemBackground)
                            
                        }
                            .data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                            .frame(height: 300)
                    }
                    
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
        .accentColor(.primary)
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
