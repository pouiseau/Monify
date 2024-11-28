//
//  TransactionGroup.swift
//  Monify
//
//  Created by temp on 16.11.2024.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            if viewModel.transactions.isEmpty {
                VStack {
                    Spacer()
                    Text("No Recent Transactions")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                List {
                    ForEach(Array(viewModel.groupByMonth()), id: \.key) { month, transactions in
                        Section {
                            ForEach(transactions) { transaction in
                                TransactionRowView(transaction: transaction)
                            }
                        }
                        header: {
                            Text(month)
                        }
                        .listSectionSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    let transactionList: TransactionListViewModel = {
        let transactionList = TransactionListViewModel()
        transactionList.transactions = transactionListPreviewData
        return transactionList
    }()
    NavigationView {
        TransactionListView().environmentObject(transactionList)
    }
}
