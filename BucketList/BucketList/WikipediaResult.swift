//
//  WikipediaResult.swift
//  BucketList
//
//  Created by Brian Foshee on 14/5/22.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
