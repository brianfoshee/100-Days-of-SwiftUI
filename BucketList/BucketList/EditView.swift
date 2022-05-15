//
//  EditView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @StateObject private var viewModel: ViewModel

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                // wikipedia results
                Section("Nearby") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location // make a copy
                    // needs a new id so when inserting back into locations array in ContentView
                    // the view updates. Otherwise it won't because the id's are the same even though
                    // the name and desc changed.
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

    init(location: Location, onsave: @escaping (Location) -> Void) {
        self.onSave = onsave

        _viewModel = StateObject(wrappedValue: ViewModel(location: location, name: location.name, description: location.description))
    }

}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in
            // do nothing
        }
    }
}
