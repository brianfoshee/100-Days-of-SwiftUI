//
//  DataController.swift
//  BookWorm
//
//  Created by Brian Foshee on 3/5/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // this tells core data about the model we want, but doesn't load it yet
    let container = NSPersistentContainer(name: "CoreDataProject")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
