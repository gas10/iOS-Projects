//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Gawade, Amar on 1/20/23.
//

// MARK: Add SwiftUIFontIcon Library -
// In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency...
// Paste the repository URL (https://github.com/huybuidac/SwiftUIFontIcon) and click Next.
// For Rules, select Branch (with branch set to master). Click Finish.

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var tx: Transaction
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: tx.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(tx.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(tx.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                Text(tx.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(tx.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(tx.type == TransactionType.credit.rawValue ?
                                 Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(tx: transactionPreviewData)
        TransactionRow(tx: transactionPreviewData)
            .preferredColorScheme(.dark)
    }
}
