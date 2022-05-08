//
//  User.swift
//  FriendFace
//
//  Created by Brian Foshee on 7/5/22.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int = 0
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    struct Friend: Codable, Identifiable, Hashable {
        var id: UUID
        var name: String
    }

    static let brian = User(
        id: UUID(),
        isActive: true,
        name: "Brian Foshee",
        age: 33,
        company: "The Brian Foshee Company, LLC",
        email: "brian@brianfoshee.com",
        address: "123 Main Street, City, State",
        about: "Brian has feelings",
        registered: Date.now,
        tags: ["ginger"],
        friends: [Friend(id: UUID(), name: "James")]
    )
}


/*
 {
 "id": "50a48fa3-2c0f-4397-ac50-64da464f9954",
 "isActive": false,
 "name": "Alford Rodriguez",
 "age": 21,
 "company": "Imkan",
 "email": "alfordrodriguez@imkan.com",
 "address": "907 Nelson Street, Cotopaxi, South Dakota, 5913",
 "about": "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
 "registered": "2015-11-10T01:47:18-00:00",
 "tags": [
 "cillum",
 "consequat",
 "deserunt",
 "nostrud",
 "eiusmod",
 "minim",
 "tempor"
 ],
 "friends": [
 {
 "id": "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
 "name": "Hawkins Patel"
 },
 */
