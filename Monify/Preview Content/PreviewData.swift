//
//  PreviewData.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

//var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Louvre", account: "Visa Louvre", merchant: "Apple",
//     amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", amount: 11.49, categoryId: 8, category: "Software", isTransfer: false, isExpense: true)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
