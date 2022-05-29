//
//  Card.swift
//  FlashZilla
//
//  Created by Brian Foshee on 26/5/22.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String

    static private var savePath = FileManager.documentsDirectory.appendingPathComponent("Cards.json")
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

    static func loadCards() -> [Card] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
               return decoded
            }
        }
        return []
    }

    static func save(_ cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: Self.savePath, options: [.atomic])
        }
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
