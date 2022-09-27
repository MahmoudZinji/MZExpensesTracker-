//
//  TransactionList.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import SwiftUI

struct TransactionList: View {

    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
        VStack {
            List {
                // MARK: Transactions Groups
                ForEach(Array( transactionListVM.groupTransactionsByMonth() ), id: \.key) { month, transactions in
                    Section {
                        // MARK: Transaction List
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } footer: {
                        // MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(Visibility.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {

    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            NavigationView {
                TransactionList()
            }

            NavigationView {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
