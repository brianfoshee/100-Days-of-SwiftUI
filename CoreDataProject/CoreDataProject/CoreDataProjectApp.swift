//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Brian Foshee on 6/5/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
