//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Brian Foshee on 14/5/22.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var authError = false

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("unable to save data")
            }
        }

        func addLocation() {
            let location = Location(
                id: UUID(),
                name: "New Location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(location)
            selectedPlace = location
            save()
        }

        func update(location: Location) {
            guard let selectedPlace = selectedPlace else {
                return
            }

            // this is why Location struct has == method
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please auth yourself to get your places"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    // this completion closure is not called on the main actor, so modifying isUnlocked
                    // is a compiler error. Wrap it in a task instead.
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                        Task { @MainActor in
                            self.authError = true
                        }
                    }
                }
            } else {
                // no biometrics
                Task { @MainActor in
                    self.authError = true
                }
            }
        }

    }
}
