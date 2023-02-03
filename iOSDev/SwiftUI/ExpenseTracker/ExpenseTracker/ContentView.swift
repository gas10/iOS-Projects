//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var txVM: TransactionListViewModel
    var demoData: [Double] = [8, 2, 4, 6, 12, 9 ,2]
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Overview")
                            .font(.title2)
                            .bold()
                        
                        // Chart
                        let data = txVM.accumulateTransactions()
                        
                        if !data.isEmpty {
                            let totalExpense = data.last?.1 ?? 0
                            CardView {
                                VStack(alignment: .leading) {
                                    ChartLabel(totalExpense.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                    
                                    LineChart()
                                }
                                .background(Color.systemBackground)
                            }
                            .data(demoData)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground,
                                        foregroundColor: ColorGradient(Color.icon.opacity(0.4),Color.icon)))
                            .frame(height: 300)
                        }
                        
                        // Display transactions
                        RecentTransactionList()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .accentColor(.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let txListVM: TransactionListViewModel = {
        let txListVM = TransactionListViewModel()
        txListVM.transactions = transactionListPreviewData
        return txListVM
    }()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(txListVM)
    }
}
