//
//  Ticket+CoreDataProperties.swift
//  ITLogger
//
//  Created by Gary Naz on 3/17/21.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var date: Date?
    @NSManaged public var inquiry: String?
    @NSManaged public var priority: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension Ticket : Identifiable {

}
