//
//  ExpenseChartView.swift
//  Monify
//
//  Created by temp on 23.11.2024.
//

import SwiftUI
import Charts

struct ExpenseChartView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
   
    var body: some View {
        VStack(spacing: 20) {
            // MARK: Total Expenses Header
            HStack {
                Text("Spent this Week:")
                    .foregroundStyle(.primary)
                    .bold()
                
                Text(viewModel.totalExpenses, format: .currency(code: "USD"))
                    .foregroundStyle(Color.customText)
                    .bold()
            }.frame(alignment: .leading)
                

            if viewModel.totalExpenses == 0 {
                EmptyGraphView()
                    .padding()
                    .frame(height: 300)
            } else {
                Chart {
                    ForEach(viewModel.prefixSum) { item in
                        LineMark(
                            x: .value("Day", item.date),
                            y: .value("Value", item.sum)
                        )
                    }
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(Color.customIcon)
                }
                .frame(height: 300)
                .background(Color.customBackground.opacity(0.8))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
            }
            
        }
        .task {
            viewModel.updateAccumulatedData()
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct EmptyGraphView: View {
    var body: some View {
        VStack {
            Image(systemName: "chart.xyaxis.line")
                .font(.largeTitle)
                .foregroundColor(Color.customIcon)
            Text("No expenses yet")
                .font(.footnote)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let viewModel: TransactionListViewModel = TransactionListViewModel()
    ExpenseChartView().environmentObject(viewModel)
}
