//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Brian Foshee on 24/4/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Comparable {
    // needs to be a var for Codable. When decoding from JSON, we want id to be set to the ID
    // that was stored in JSON instead of creating a new id.
    var id = UUID()

    let name: String
    let type: String
    let amount: Double

    static func < (lhs: ExpenseItem, rhs: ExpenseItem) -> Bool {
        return lhs.name < rhs.name
    }
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    func businessItems() -> [ExpenseItem] {
        return items.filter({ item in
            item.type == "Business"
        }).sorted()
    }

    func personalItems() -> [ExpenseItem] {
        return items.filter({ item in
            item.type == "Personal"
        }).sorted()
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }

}
