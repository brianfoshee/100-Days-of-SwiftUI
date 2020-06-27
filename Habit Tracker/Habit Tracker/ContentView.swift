//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Brian Foshee on 27/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities: Activities = Activities()

    @State private var showingAddView: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    Text("\(item.name)")
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddView.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
         }
        .sheet(isPresented: $showingAddView) {
            AddView(activities: self.activities)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
