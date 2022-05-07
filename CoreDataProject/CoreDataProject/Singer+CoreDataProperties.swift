//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Brian Foshee on 7/5/22.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "unknown"
    }

    var wrappedLasttName: String {
        lastName ?? "unknown"
    }

}

extension Singer : Identifiable {

}
