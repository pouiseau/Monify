//
//  ExpenseChartView.swift
//  Monify
//
//  Created by temp on 23.11.2024.
//

import SwiftUI
import Charts

struct ExpenseChartView: View {
    @ObservedObject var viewModel: TransactionListViewModel
   
    var body: some View {
//        CardView(showShadow: false) {
//            VStack(alignment: .leading) {
//                // Total expenses displayed as a title
//                Text(viewModel.totalExpenses.formatted(.currency(code: "USD")))
//                    .font(.largeTitle)
//                    .bold()
//                    .padding(.bottom, 8)
//
//                // Subtitle for the chart
//                Text("Spent this month")
//                    .font(.headline)
//                    .foregroundColor(.secondary)
//                    .padding(.bottom, 16)
//
//                // Chart implementation
//                if viewModel.prefixSum.isEmpty {
//                    Text("No data available")
//                        .foregroundColor(.secondary)
//                        .font(.headline)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .padding()
//                } else {
//                    Chart(viewModel.prefixSum) { dataPoint in
//                        LineMark(
//                            x: .value("Date", dataPoint.date),
//                            y: .value("Expense", dataPoint.value)
//                        )
//                        .foregroundStyle(Color.icon.opacity(0.6))
//                        .lineStyle(StrokeStyle(lineWidth: 2))
//                    }
//                    .chartYScale(domain: 0...max(viewModel.prefixSum.map(\.value).max() ?? 1.0, 1.0)) // Dynamically scale Y-axis
//                    .padding()
//                }
//            }
//            .padding()
//            .background(Color.systemBackground)
//        }
//        .frame(height: 300)
//        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        Text("Hello")
    }
}

#Preview {
    ExpenseChartView(viewModel: TransactionListViewModel())
}
