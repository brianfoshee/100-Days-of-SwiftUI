//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Brian Foshee on 3/5/22.
//

import SwiftUI

@main
struct BookWormApp: App {
    // this loads the core data model once
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // set the container on the Environment object
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
