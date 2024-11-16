import SwiftUI

struct NewTransaction: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var transactionList: TransactionListViewModel
    @State private var date = Date()
    @State private var institution = ""
    @State private var account = ""
    @State private var merchant = ""
    @State private var amount = ""
    @State private var type = "debit"
    @State private var categoryId: Int = Category.categories.first?.id ?? 1
    @State private var isTransfer = false
    @State private var isExpense = true

    var body: some View {
        NavigationView {
            Form {
                
                Button(action: {
//                    saveTransaction()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .font(.subheadline)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                
                
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

//    private func saveTransaction() {
//        guard let amount = Double(amount) else { return }
//        let newTransaction = Transaction(
//            id: transactionList.transactions.count + 1,
//            date: date.formatted(date: .numeric, time: .omitted),
//            institution: institution,
//            account: account,
//            merchant: merchant,
//            amount: amount,
//            type: type,
//            categoryId: categoryId,
//            category: Category.all.first { $0.id == categoryId }?.name ?? "",
//            isPending: false,
//            isTransfer: isTransfer,
//            isExpense: isExpense,
//            isEdited: false
//        )
//        transactionList.transactions.append(newTransaction)
//    }
}

#Preview {
    let transactionList = TransactionListViewModel()
    NewTransaction()
        .environmentObject(transactionList)
}
