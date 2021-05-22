//
//  User+CoreDataProperties.swift
//  ITLogger
//
//  Created by Gary Naz on 3/17/21.
//
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var admin: Bool
    @NSManaged public var company: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var photo: Data?
    @NSManaged public var username: String?
    @NSManaged public var id: UUID?
    @NSManaged public var tickets: NSSet?
    
}

// MARK: Generated accessors for tickets
extension User {
    
    @objc(addTicketsObject:)
    @NSManaged public func addToTickets(_ value: Ticket)
    
    @objc(removeTicketsObject:)
    @NSManaged public func removeFromTickets(_ value: Ticket)
    
    @objc(addTickets:)
    @NSManaged public func addToTickets(_ values: NSSet)
    
    @objc(removeTickets:)
    @NSManaged public func removeFromTickets(_ values: NSSet)
    
}

extension User : Identifiable {
    
}
