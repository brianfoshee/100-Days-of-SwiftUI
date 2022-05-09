//
//  DataController.swift
//  FriendFace
//
//  Created by Brian Foshee on 9/5/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
