//
//  TransactionList.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias Summary = [TransactionPrefixSum]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var totalExpenses: Double = 0
    @Published var prefixSum: Summary = []
    
    private let baseURL = "https://v6.exchangerate-api.com/v6/870232fa088e440f13c8572b/latest/USD"
    private var exchangeRates: [String: Double] = [:]
    
    private let storageKey = "transactions"
    
    
    init() {
        loadTransactions()
        Task {
            await fetchRates()
            DispatchQueue.main.async {
                self.updateAccumulatedData()
            }
        }
        
    }
    
    func loadTransactions() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let savedTransactions = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = savedTransactions
        } else {
            transactions = []
        }
    }
    
    private func saveTransactions() {
        if let data = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
        updateAccumulatedData()
    }
    
    func groupByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        let groupedTransactions =  TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransactions
    }
    
    
    @MainActor
    func fetchRates() async {
        guard let url = URL(string: baseURL) else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
                exchangeRates = decodedResponse.conversionRates
            } catch {
                print("Failed to fetch exchange rates: \(error.localizedDescription)")
            }
    }

    
    func updateAccumulatedData() {
        let result = accumulate()
        if let lastItem = result.last {
            self.totalExpenses = lastItem.sum
        } else {
            self.totalExpenses = 0
        }
        self.prefixSum = result
    }
    
    func accumulate() -> Summary {
        guard !transactions.isEmpty else { return  []}
        
        Task {
            await fetchRates()
        }
        
        let today = Date()
        let dateInterval = Calendar.current.dateInterval(of: .weekOfYear, for: today)!
        
        var sum: Double = 0
        var cumulativeSum = Summary()

        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = self.transactions.filter { $0.isExpense && $0.dateParsed == date }

            let dailyTotal = dailyExpenses.reduce(0) { total, transaction in
                let exchangeRate = transaction.currency == .USD ? 1.0 : (exchangeRates[transaction.currency.rawValue] ?? 1.0)
                return total - transaction.amountInUSD(exchangeRate: exchangeRate)
            }

            sum += dailyTotal
            cumulativeSum.append(TransactionPrefixSum(date: date.formatted(), sum: sum))
        }
    
        
        return cumulativeSum
    }
}
 
