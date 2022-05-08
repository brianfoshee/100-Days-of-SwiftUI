//
//  UserView.swift
//  FriendFace
//
//  Created by Brian Foshee on 8/5/22.
//

import SwiftUI

struct UserView: View {
    var user: User
    var body: some View {
        Form {
            Section("Age") {
                Text("\(user.age)")
            }
            Section("Company") {
                Text(user.company)
            }
            Section("Email") {
                Text(user.email)
            }
            Section("Address") {
                Text(user.address)
            }
            Section("About") {
                Text(user.about)
            }
            Section("Registered") {
                Text(user.registered.formatted())
            }
            Section("Tags") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            Section("Friends") {
                ForEach(user.friends, id: \.self) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserView(user: User.brian)
        }
    }
}
