//
//  TransactionGroup.swift
//  Monify
//
//  Created by temp on 16.11.2024.
//

import SwiftUI

struct TransactionGroupView: View {
    @EnvironmentObject var transactionList: TransactionList
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionList.groupByMonth()), id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
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
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    let transactionList: TransactionList = {
        let transactionList = TransactionList()
        transactionList.transactions = transactionListPreviewData
        return transactionList
    }()
    NavigationView {
        TransactionGroupView().environmentObject(transactionList)
    }
}
