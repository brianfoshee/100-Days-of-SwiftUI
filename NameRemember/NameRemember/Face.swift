//
//  Face.swift
//  NameRemember
//
//  Created by Brian Foshee on 20/5/22.
//

import Foundation
import PhotosUI
import SwiftUI

struct Face: Identifiable, Comparable {
    var id = UUID()
    var image: UIImage
    var name: String

    var displayableImage: Image {
        Image(uiImage: image)
    }

    static func <(lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
}
