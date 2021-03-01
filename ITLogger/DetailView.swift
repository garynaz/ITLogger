//
//  DetailView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/28/21.
//

import SwiftUI

struct DetailView: View {
    
    var ticketDetail: TicketModel = TicketModel(type: "Support Ticket", priority: "Urgent", company: "AccessWeb", user: "Gary Naz", inquiry: "This is a test...")
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text(ticketDetail.type)
                    .frame(maxWidth: .infinity)
                    .font(.title)
                HStack {
                    HStack {
                        Text("User:")
                            .font(.title3)
                        Text(ticketDetail.user)
                            .font(.system(size: 20, weight: .thin))
                    }
                    
                    Spacer()
                    Text(ticketDetail.priority)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
                Spacer()
                Spacer()
                Text(ticketDetail.inquiry)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .light))
            }
            
        }
        .navigationBarTitle(ticketDetail.company)
        .listStyle(PlainListStyle())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
