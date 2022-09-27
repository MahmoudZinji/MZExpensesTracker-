//
//  Extensions + Date.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import Foundation

extension DateFormatter {

    static let allNumericUSA: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"

        return formatter
    }()
}

extension Date {
    func formatter() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}
