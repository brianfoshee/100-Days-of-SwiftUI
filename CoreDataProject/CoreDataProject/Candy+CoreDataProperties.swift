//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Brian Foshee on 7/5/22.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "unknown candy"
    }
}

extension Candy : Identifiable {

}
