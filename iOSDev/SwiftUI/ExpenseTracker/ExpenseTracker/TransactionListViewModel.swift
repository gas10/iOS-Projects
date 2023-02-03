//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import Foundation
import Collections
import Combine

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error occured while fetching transaction data \(error.localizedDescription)")
                case .finished:
                    print("Successfuly fetched transactions data")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                print("------------------------------Starting Dumping Received Data------------------------------")
                dump(self?.transactions)
                print("------------------------------Finished Dumping Received Data------------------------------")
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        return TransactionGroup(grouping: transactions) { $0.month }
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        var sum: Double = 0
        var cumulatieSum = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpense  = transactions.filter { $0.dateParsed == date  && $0.isExpense }
            let dailyTotal = dailyExpense.reduce(0) { $0  - $1.signedAmount }
            sum += dailyTotal
            sum = sum.roundTo2Digit()
            cumulatieSum.append((date.formatted(), sum))
        }
        return cumulatieSum
    }
}
