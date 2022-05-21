//
//  Face.swift
//  NameRemember
//
//  Created by Brian Foshee on 20/5/22.
//

import Foundation
import PhotosUI
import SwiftUI
import MapKit

struct Face: Identifiable, Comparable, Codable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double

    // lazy load the image from storage
    var image: Image {
        if let data = try? Data(contentsOf: imageURL) {
            if let uiImg = UIImage(data: data) {
                return Image(uiImage: uiImg)
            }
        }

        return Image(systemName: "x.square")
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // where the image is stored in the device's documents directory
    var imageURL: URL {
        FileManager.userDocumentsDirectory.appendingPathComponent("\(id).jpg")
    }

    init(image: UIImage, name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
        // save image
        self.saveImage(image: image)
    }

    func saveImage(image: UIImage) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imageURL, options: [.atomic, .completeFileProtection])
        }
    }

    // where the json file containing face names and IDs is stored
    static var dataPath: URL {
        FileManager.userDocumentsDirectory.appendingPathComponent("faces.json")
    }

    static func save(faces: [Face]) throws {
        let data = try JSONEncoder().encode(faces)
        try data.write(to: dataPath, options: [.atomic, .completeFileProtection])
    }

    static func load() throws -> [Face] {
        let data = try Data(contentsOf: dataPath)
        let faces = try JSONDecoder().decode([Face].self, from: data)
        return faces
    }

    static func <(lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
}
