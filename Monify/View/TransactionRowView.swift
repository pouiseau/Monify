//
//  TransactionRow.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRowView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.customIcon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.customIcon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                
                // MARK: Transaction merchant
//                Text(transaction.name)
//                    .font(.subheadline)
//                    .bold()
//                    .lineLimit(1)
                
                // MARK: Transaction category
                Text(transaction.category)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction date
                Text(transaction.dateParsed, format: .dateTime.year().month(.wide).day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
            
            Spacer()
            
            // MARK Transaction amount
            Text(transaction.signedAmount, format: .currency(code: transaction.currency.rawValue))
                .bold()
                .foregroundStyle(!transaction.isExpense
                                 ? Color.customText
                                 : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRowView(transaction: transactionPreviewData)
}
