//
//  EditView-VewModel.swift
//  BucketList
//
//  Created by Brian Foshee on 14/5/22.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location

        @Published var name: String
        @Published var description: String

        // from wikipedia stuff
        @Published private(set) var loadingState = LoadingState.loading
        @Published private(set) var pages = [Page]()

        init(location: Location, name: String, description: String) {
            self.location = location
            _name = Published(initialValue: name)
            _description = Published(initialValue: description)
        }

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("bad URL \(urlString)")
                loadingState = .failed
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                let items = try JSONDecoder().decode(Result.self, from: data)

                Task { @MainActor in
                    // values is the dictionary's values as an array, which is pages
                    pages = items.query.pages.values.sorted()
                    loadingState = .loaded
                }
            } catch {
                Task { @MainActor in
                    loadingState = .failed
                }
            }
        }
        
    }
}
