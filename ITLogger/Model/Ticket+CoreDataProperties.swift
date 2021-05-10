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

    @NSManaged public var date: String?
    @NSManaged public var inquiry: String?
    @NSManaged public var priority: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension Ticket : Identifiable {

}

extension Ticket {
    static func getAllTicketItems() -> NSFetchRequest<Ticket> {
        let request:NSFetchRequest<Ticket> = Ticket.fetchRequest()

        let sortDescriptor = NSSortDescriptor(keyPath: \Ticket.date, ascending: true)
        request.sortDescriptors = [sortDescriptor]

        return request
    }
    
    static func fetchAllTicketDetails() -> NSFetchRequest<Ticket> {
        let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")
        fetchRequest.predicate = NSPredicate(format: "user != NULL")
        let sortDescriptor = NSSortDescriptor(keyPath: \Ticket.user, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
}
