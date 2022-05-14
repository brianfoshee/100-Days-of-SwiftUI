//
//  ContentView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
    )
    @State private var locations = [Location]()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
            .ignoresSafeArea()

            // show a circle in the middle always
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)

            // put a 'plus' button at the bottom right corner of the screen
            VStack {
                // this spacer pushes it down to the bottom
                Spacer()

                HStack {
                    // this spacer pushes it to the right
                    Spacer()

                    Button {
                        // create a new location{
                        let location = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(location)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding() // make sure the button is large before adding bkg
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing) // move it off the edge of the screen
                }
            }
        }
    }

}


extension FileManager {
    static func userDocumentsDirectory() -> URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
