//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var txListVM: TransactionListViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("Select All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding([.top])
            
            ForEach(Array(txListVM.transactions.prefix(5).enumerated()), id: \.element) { index, tx in
                TransactionRow(tx: tx)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2) ,radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let txListVM: TransactionListViewModel = {
        let txListVM = TransactionListViewModel()
        txListVM.transactions = transactionListPreviewData
        return txListVM
    }()
    
    static var previews: some View {
        Group {
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }
        .environmentObject(txListVM)
    }
}
