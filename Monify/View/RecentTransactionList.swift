//
//  RecentTransactionList.swift
//  Monify
//
//  Created by temp on 05.11.2024.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionList: TransactionList
    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                // MARK: Navigation link
                NavigationLink{
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("See All ")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.customText)
                }
            }
            .padding(.top)
            
            let transactions = Array(transactionList.transactions.prefix(5).enumerated())
            
            // MARK: Recent transactions list
            ForEach(transactions, id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider().opacity(index == transactions.count - 1 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    let transactionList: TransactionList = {
        let transactionList = TransactionList()
        transactionList.transactions = transactionListPreviewData
        return transactionList
    }()
    
    RecentTransactionList()
        .environmentObject(transactionList)
}
