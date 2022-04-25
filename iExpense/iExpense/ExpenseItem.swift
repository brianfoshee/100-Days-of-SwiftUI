//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Brian Foshee on 24/4/22.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
