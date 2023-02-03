//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import Foundation
var transactionPreviewData = Transaction(id: 1, date: "01/04/2022", institution: "Ridgeline", account: "Visa", merchant: "Apple", amount: 22.90, type: "debit", categoryId: 801, category: "Rent", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
