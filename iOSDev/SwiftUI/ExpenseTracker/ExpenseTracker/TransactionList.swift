//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var txListVM: TransactionListViewModel
    var body: some View {
        VStack {
            List {
                ForEach(Array(txListVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(tx: transaction)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let txListVM: TransactionListViewModel = {
        let txListVM = TransactionListViewModel()
        txListVM.transactions = transactionListPreviewData
        return txListVM
    }()
    static var previews: some View {
        Group {
            NavigationView() {
                TransactionList()
            }
            NavigationView() {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(txListVM)
    }
}
