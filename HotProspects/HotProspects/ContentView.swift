//
//  ContentView.swift
//  HotProspects
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var user = User()

    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem {
                    Label("One", systemImage: "star")
                }

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
        }
    }

}

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    // user comes from the environment rather than being passed
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    // user comes from the environment rather than being passed
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
