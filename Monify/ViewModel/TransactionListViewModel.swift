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
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var totalExpenses: Double = 0
    @Published var prefixSum: TransactionPrefixSum = []
    
    private let baseURL = "https://v6.exchangerate-api.com/v6/870232fa088e440f13c8572b/latest/USD"
    private var exchangeRates: [String: Double] = [:]
    
    private let storageKey = "transactions"
    
    
    init() {
        loadTransactions()
        Task {
            await fetchRates()
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
                calculateTotalExpenses()
            } catch {
                print("Failed to fetch exchange rates: \(error.localizedDescription)")
            }
    }
    
    func calculateTotalExpenses() {
        guard !transactions.isEmpty else {
            totalExpenses = 0
            return
        }

        totalExpenses = transactions.reduce(0) { total, transaction in
            let exchangeRate = transaction.currency == .USD ? 1.0 : (exchangeRates[transaction.currency.rawValue] ?? 1.0)
            return total - transaction.amountInUSD(exchangeRate: exchangeRate)
        }
    }
    
    func updateAccumulatedData() {
        Task {
            if exchangeRates.isEmpty {
                await fetchRates()
            }
            let result = accumulate2()
            DispatchQueue.main.async {
                self.prefixSum = result
                self.totalExpenses = result.reduce(0) { $0 + $1.1 }
            }
        }
    }
    
    func accumulate2() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return  []}
        
        if exchangeRates.isEmpty {
            Task {
                await fetchRates()
            }
        }
        
        let today = Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = 0
        var cumulativeSum = TransactionPrefixSum()

        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = self.transactions.filter { $0.isExpense && $0.dateParsed == date }

            let dailyTotal = dailyExpenses.reduce(0) { total, transaction in
                let exchangeRate = transaction.currency == .USD ? 1.0 : (exchangeRates[transaction.currency.rawValue] ?? 1.0)
                return total - transaction.amountInUSD(exchangeRate: exchangeRate)
            }

            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
        }
    
        
        return cumulativeSum
    }
}
 
