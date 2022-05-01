//
//  User.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import Foundation

class User: ObservableObject, Codable {
    // this tells Codable what properties to work with
    enum CodingKeys: CodingKey {
        case name
    }

    @Published var name = "Paul Hudson"

    // this tells Codable how to decode the properties
    // anyone who subclasses our User class must override this initializer with a custom implementation to make sure they add their own values. We mark this using the required keyword
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    // the opposite to init
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
