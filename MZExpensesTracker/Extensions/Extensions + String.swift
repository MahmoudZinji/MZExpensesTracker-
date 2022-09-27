//
//  Extensions + String.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import Foundation

extension String {

    func dateParsed() -> Date {
        guard let parsedData = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedData
    }
}
