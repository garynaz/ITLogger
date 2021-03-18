//
//  TicketModel.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI
import Combine


//View Model
class UpdateModel: ObservableObject {
    @Published var updateData: [TicketModel] = [TicketModel(type: "Support", priority: "Low", company: "AccessWeb", user: "Gary Nazarian", inquiry: "This is a test...", date: "21:32 Wed, 01 Aug 2021")]
    
    func addTicket(ticket: TicketModel){
        updateData.append(ticket)
    }
    
}


//Model
struct TicketModel: Identifiable{
    let id = UUID()
    let type : String
    let status : String = "OPEN"
    let priority : String
    let company : String
    let user : String
    let inquiry : String
    let date : String
}


enum Status {
    case Open
    case Closed
    case ReOpened
    case AwaitingCustomerAction
    case InProgress
    case Unfinished
}


