//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Brian Foshee on 9/5/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var wrappedID: UUID {
        id ?? UUID()
    }

    public var wrappedName: String {
        name ?? "unknown"
    }
}

extension CachedFriend : Identifiable {

}
