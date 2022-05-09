//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Brian Foshee on 7/5/22.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var controller = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, controller.container.viewContext)
        }
    }
}
