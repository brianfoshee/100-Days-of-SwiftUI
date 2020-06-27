//
//  Habit.swift
//  Habit Tracker
//
//  Created by Brian Foshee on 27/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import Foundation

struct ActivityItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
}

class Activities: ObservableObject {
    @Published var items: [ActivityItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "Activites") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ActivityItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}
