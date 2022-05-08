//
//  ContentView.swift
//  FriendFace
//
//  Created by Brian Foshee on 7/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()

    var userMap: [UUID: User] {
        return users.reduce(into: [UUID: User]()) { map, user in
            map[user.id] = user
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        UserView(user: user, users: userMap)
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
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
