//
//  ContentView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            if viewModel.isUnlocked {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())

                            Text(location.name)
                                .fixedSize()
                        }
                    }
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
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding() // make sure the button is large before adding bkg
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing) // move it off the edge of the screen
                        }
                    }
                }
            } else {
                // button
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.update(location: newLocation)
            }
        }
        .alert("Auth Error", isPresented: $viewModel.authError) {
            Button("OK") { }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
