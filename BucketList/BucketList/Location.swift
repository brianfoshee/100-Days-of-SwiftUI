//
//  Location.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import Foundation
import CoreLocation

/*
 Identifiable, so we can create many location markers in our map.
 Codable, so we can load and save map data easily.
 Equatable, so we can find one particular location in an array of locations.
 */
struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)

}
