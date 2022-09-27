//
//  TransactionListViewModel.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [TransactionModel]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {

    @Published var transactions: [TransactionModel] = []
    private var cancellable = Set<AnyCancellable>()

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
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    //dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [TransactionModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Failed fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Successfully fetched transactions.")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                //dump(self?.transactions)
            }
            .store(in: &cancellable)
    }

    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }

        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        return groupedTransactions
    }

    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }

        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!

        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()

        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }

            sum += dailyTotal
            sum = sum.roundTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "DailyTotal: ", dailyTotal, "sum: ", sum)
        }
        return cumulativeSum
    }
}
