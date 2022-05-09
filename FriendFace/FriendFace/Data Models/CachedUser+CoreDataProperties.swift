//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Brian Foshee on 9/5/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedID: UUID {
        id ?? UUID()
    }

    public var wrappedName: String {
        name ?? "unknown"
    }

    public var wrappedCompany: String {
        company ?? "unknown"
    }

    public var wrappedEmail: String {
        email ?? "unknown"
    }

    public var wrappedAddress: String {
        address ?? "unknown"
    }

    public var wrappedAbout: String {
        about ?? "unknown"
    }

    public var wrappedRegistered: Date {
        registered ?? Date.now
    }

    public var wrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted { a, b in
            a.wrappedName < b.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
