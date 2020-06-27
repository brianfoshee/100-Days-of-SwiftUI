//
//  AddView.swift
//  Habit Tracker
//
//  Created by Brian Foshee on 27/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var activities: Activities
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationBarTitle("Add Activity")
            .navigationBarItems(trailing: Button("Save") {
                // add item to activities
                let item: ActivityItem = ActivityItem(
                    name: self.name
                )
                self.activities.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
