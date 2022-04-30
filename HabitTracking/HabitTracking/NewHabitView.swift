//
//  NewHabitView.swift
//  HabitTracking
//
//  Created by Brian Foshee on 30/4/22.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var habits: Habits

    @State private var name: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Habit name", text: $name)

                TextField("Habit Description", text: $description)
            }
            .toolbar {
                Button("Done") {
                    // add to list of habits
                    let habit = Habit(name: name, description: description)
                    habits.habits.append(habit)

                    dismiss()
                }
            }
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var habits = Habits()
    static var previews: some View {
        NewHabitView(habits: habits)
    }
}
