//
//  UserView.swift
//  FriendFace
//
//  Created by Brian Foshee on 8/5/22.
//

import SwiftUI

struct UserView: View {
    var user: CachedUser
    var users: [UUID: CachedUser]

    var body: some View {
        Form {
            Section("Age") {
                Text("\(user.age)")
            }
            Section("Company") {
                Text(user.wrappedCompany)
            }
            Section("Email") {
                Text(user.wrappedEmail)
            }
            Section("Address") {
                Text(user.wrappedAddress)
            }
            Section("About") {
                Text(user.wrappedAbout)
            }
            Section("Registered") {
                Text(user.wrappedRegistered.formatted())
            }
            /*
            Section("Tags") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
             */
            Section("Friends") {
                ForEach(user.wrappedFriends, id: \.self) { friend in
                    NavigationLink {
                        if let x = users[friend.wrappedID] {
                            UserView(user: x, users: users)
                        } else {
                            Text("no matching user for \(friend.wrappedName)")
                        }
                    } label: {
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserView(user: User.brian, users: [:])
        }
    }
}
*/
