//
//  FaceView.swift
//  NameRemember
//
//  Created by Brian Foshee on 20/5/22.
//

import MapKit
import SwiftUI

struct FaceView: View {
    var face: Face

    @State private var mapRegion: MKCoordinateRegion

    init(face: Face) {
        self.face = face

        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: face.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
    }

    var body: some View {
        VStack {
            Text(face.name)
                .font(.headline)

            Map(coordinateRegion: $mapRegion, annotationItems: [face]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    face.image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 44, height: 44)
                }
            }

            face.image
                .resizable()
                .scaledToFit()
        }
    }

}

