import SwiftUI

struct NewTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: TransactionListViewModel
    
    @State private var date = Date()
    @State private var amount = ""
    @State private var isExpense = true
    @State private var categoryId: Int = Category.uncategorized.id
    @State private var currency: Currency = Currency.USD

    
    var body: some View {
        VStack {
            
            // MARK: Transaction type
            Picker("isExpense", selection: $isExpense) {
                Text("Income").tag(false)
                Text("Expense").tag(true)
            }
            .pickerStyle(.segmented)
            
            List {
                
                // MARK: Amount input
                HStack {
                    Text(isExpense ? "-" : "+")
                        .font(.title2)
                        .foregroundColor(.primary)
                    TextField("0", text: $amount)
                        .keyboardType(.decimalPad)
                        .font(.title2)
                    Picker("", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) {currency in
                            Text("\(currency.rawValue) (\(currency.symbol))")
                        }
                    }
                }
                
                // MARK: Category selector
                Picker("Select Category", selection: $categoryId) {
                    if isExpense {
                        ForEach(Category.expenses, id: \.id) { category in
                            Text(category.name).tag(category.id)
                        }
                    } else {
                        ForEach(Category.incomes, id: \.id) { category in
                            Text(category.name).tag(category.id)
                        }
                    }
                    
                }
                
                // MARK: Pick Date
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    .accentColor(Color.customText)
                
            }.listStyle(.plain)
            
            // MARK: Save Transaction button
            Button(action: saveTransaction) {
                HStack {
                    Text("Save Transaction")
                        .font(.headline)
                        .bold()
                }
                .foregroundColor(Color.customText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.customBackground)
                .cornerRadius(10)
            }
            .padding()
            .disabled(amount.isEmpty || Double(amount) == nil)
           
        }
        .navigationTitle("New Transaction")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let formattedDate = dateFormatter.string(from: date)

        let newTransaction = Transaction(
            id: (viewModel.transactions.map { $0.id }.max() ?? 0) + 1,
            date: formattedDate,
            amount: amountValue,
            currency: currency,
            categoryId: categoryId,
            category: Category.all.first { $0.id == categoryId }?.name ?? "Unknown",
            isExpense: isExpense
        )

        viewModel.addTransaction(newTransaction)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    let transactionList = TransactionListViewModel()
    NewTransactionView(viewModel: transactionList)
       
}
