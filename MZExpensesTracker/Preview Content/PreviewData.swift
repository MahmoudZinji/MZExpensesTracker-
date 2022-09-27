//
//  PreviewData.swift
//  MZExpensesTracker
//
//  Created by Mahmoud Zinji on 2022-09-26.
//

import Foundation

var transactionPreviewData = TransactionModel(
    id: 1, date: "01/24/2022",
    institution: "Desjardins",
    account: "Visa Desjardins",
    merchant: "Apple",
    amount: 11.49,
    type: "debit",
    categoryId: 801,
    category: "Software",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)

var transactionListPreviewData = [TransactionModel](repeating: transactionPreviewData, count: 10)
