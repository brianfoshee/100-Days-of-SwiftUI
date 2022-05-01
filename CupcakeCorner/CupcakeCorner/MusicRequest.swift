//
//  MusicRequest.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}


struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
