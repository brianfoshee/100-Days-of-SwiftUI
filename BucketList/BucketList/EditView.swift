//
//  EditView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void

    @State private var name: String
    @State private var description: String

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = location // make a copy
                    // needs a new id so when inserting back into locations array in ContentView
                    // the view updates. Otherwise it won't because the id's are the same even though
                    // the name and desc changed.
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocationj)
                    dismiss()
                }
            }
        }
    }

    init(location: Location, onsave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onsave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in
            // do nothing
        }
    }
}
