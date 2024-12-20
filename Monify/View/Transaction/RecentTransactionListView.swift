//
//  RecentTransactionList.swift
//  Monify
//
//  Created by temp on 05.11.2024.
//

import SwiftUI

struct RecentTransactionListView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel

    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                // MARK: Navigation link
                NavigationLink{
                    TransactionListView().environmentObject(viewModel)
                } label: {
                    HStack(spacing: 4) {
                        Text("See All ")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.customText)
                }
            }
            .padding(.top)
            
            let transactions = Array(viewModel.transactions.suffix(5).enumerated().reversed())
            
            // MARK: No recent transactions
            if transactions.isEmpty {
                Text("No Recent Transactions")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.top, .bottom], 8)
            }
            
            // MARK: Recent transactions list
            ForEach(transactions, id: \.element) { index, transaction in
                TransactionRowView(transaction: transaction)
                
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
    let viewModel: TransactionListViewModel = TransactionListViewModel()
    RecentTransactionListView().environmentObject(viewModel)
}
