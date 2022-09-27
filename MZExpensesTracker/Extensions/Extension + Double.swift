//
//  Extension + Double.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import Foundation

extension Double {
    func roundTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
