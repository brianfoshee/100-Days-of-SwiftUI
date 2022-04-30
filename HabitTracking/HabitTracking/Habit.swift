//
//  Habit.swift
//  HabitTracking
//
//  Created by Brian Foshee on 30/4/22.
//

import Foundation

struct Habit: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

class Habits: ObservableObject {
    @Published var habits = [Habit]() {
        // save new habits to UserDefaults when one is added
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }

    init() {
        // try to load any habits saved to UserDefaults
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
                return // return so habits don't get overwritten by empty array
            }
        }

        // otherwise set it to an empty array
        habits = []
    }
}
