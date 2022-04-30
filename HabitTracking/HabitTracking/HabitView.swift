//
//  HabitView.swift
//  HabitTracking
//
//  Created by Brian Foshee on 30/4/22.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits

    var body: some View {
        List {
            ForEach(habits.habits) { habit in
                NavigationLink {
                    Text("\(habit.description)")
                } label: {
                    Text("\(habit.name)")
                }
            }
            .onDelete(perform: removeHabit)
        }
    }

    func removeHabit(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var habits = Habits()
    static var previews: some View {
        HabitView(habits: habits)
    }
}
