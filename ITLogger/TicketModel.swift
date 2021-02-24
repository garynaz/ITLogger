//
//  TicketModel.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI
import Combine

class UpdateModel: ObservableObject {
    @Published var updateData: [TicketModel] = []
}

struct TicketModel: Identifiable{
    let id = UUID()
    let status : String = "OPEN"
    let priority : String
    let company : String
    let user : String
    let inquiry : String
    let date : String = "Aug 01"
}

//enum Status {
//    case INPROGRESS
//    case COMPLETED
//    case INCOMPLETE
//    case OPEN
//    case CLOSED
//}
//
//func shareImage(on status: Status){
//    switch status {
//    case .INPROGRESS:
//        Color.green
//    case .COMPLETED:
//        Color.blue
//    case .INCOMPLETE:
//        Color.gray
//    case .OPEN:
//        Color.yellow
//    case .CLOSED:
//        Color.red
//    }
//}
