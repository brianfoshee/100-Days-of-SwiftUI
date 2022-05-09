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
    @NSManaged public var user: NSSet?

    public var wrappedID: UUID {
        id ?? UUID()
    }

    public var wrappedName: String {
        name ?? "unknown"
    }

    public var wrappedUsers: [CachedUser] {
        let set = user as? Set<CachedUser> ?? []
        return set.sorted { a, b in
            a.wrappedName < b.wrappedName
        }
    }

}

// MARK: Generated accessors for user
extension CachedFriend {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
