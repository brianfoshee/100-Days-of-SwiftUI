//
//  Order.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import Foundation

class OrderWrapper: ObservableObject {
    @Published var order: Order

    init() {
        order = Order()
    }
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    // delivery details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // $ per cake
        var cost = Double(quantity) * 2

        // complicated types cost more
        cost += (Double(type) / 2)

        // $1 /cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50 for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
