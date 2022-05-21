//
//  ContentView.swift
//  HotProspects
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

@MainActor class DelayedUpdater: ObservableObject {
    // Instead of using @Published, you can use objectWillChange
    // @Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
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
