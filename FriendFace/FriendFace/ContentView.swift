//
//  ContentView.swift
//  FriendFace
//
//  Created by Brian Foshee on 7/5/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>

    var userMap: [UUID: CachedUser] {
        return users.reduce(into: [UUID: CachedUser]()) { map, user in
            map[user.wrappedID] = user
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink {
                        // UserView(user: user, users: userMap)
                        Text(user.wrappedAbout)
                    } label: {
                        Text(user.wrappedname)
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
            decodedResponse.forEach { user in
                // TODO add users to Core Data
                let c = CachedUser(context: moc)
                c.id = user.id
                c.name = user.name
                c.age = Int16(user.age)
                c.about = user.about
                c.company = user.company
                c.email = user.email
                c.isActive = user.isActive
                c.address = user.address
                c.tags = user.tags.joined(separator: ",")

                // do friends
                user.friends.forEach { friend in
                    let f = CachedFriend(context: moc)
                    f.id = friend.id
                    f.name = friend.name
                    c.addToFriends(f)
                }

                try? moc.save()
            }
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
    static var controller = DataController()
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, controller.container.viewContext)
    }
}
