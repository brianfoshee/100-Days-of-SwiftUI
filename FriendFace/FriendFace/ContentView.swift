//
//  ContentView.swift
//  FriendFace
//
//  Created by Brian Foshee on 7/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        UserView(user: user)
                    } label: {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Friend Face")
            .task {
                await fetchUsers()
            }
        }
    }

    func fetchUsers() async {
        guard users.isEmpty == true else {
            print("users isn't empty. not re-downloading.")
            return
        }

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("bad url")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([User].self, from: data)
            users = decodedResponse
        } catch {
            print("could not fetch data \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
