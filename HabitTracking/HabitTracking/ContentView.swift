//
//  ContentView.swift
//  HabitTracking
//
//  Created by Brian Foshee on 29/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits: Habits = Habits()

    @State private var showingAddSheet = false

    var body: some View {
        NavigationView {
            HabitView(habits: habits)
                .navigationTitle("Habit Tracker")
                .toolbar {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddSheet) {
                    NewHabitView(habits: habits)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
