//
//  TicketModel.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI
import Combine

class UpdateModel: ObservableObject {
    @Published var updateData: [TicketModel] = [TicketModel(type: "Support", priority: "Urgent", company: "AccessWeb", user: "Gary Naz", inquiry: "This is a test...")]
    
    func addTicket(ticket: TicketModel){
        updateData.append(ticket)
    }
    
}

struct TicketModel: Identifiable{
    let id = UUID()
    let type : String
    let status : String = "OPEN"
    let priority : String
    let company : String
    let user : String
    let inquiry : String
    let date : String = "Aug 01"
}
