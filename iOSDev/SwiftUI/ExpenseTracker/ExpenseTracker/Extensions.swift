//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

import Foundation
import SwiftUI
extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing date formatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else {
            return Date()
        }
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundTo2Digit() -> Double {
        return (self * 100).rounded() / 100
    }
}
