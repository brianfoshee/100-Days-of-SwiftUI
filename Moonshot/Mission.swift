//
//  Mission.swift
//  Moonshot
//
//  Created by Brian Foshee on 17/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    // referenced as Mission.CrewRole anywhere else in the project
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        return "Apollo \(id)"
    }

    var image: String {
        return "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
