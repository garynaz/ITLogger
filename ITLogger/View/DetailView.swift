//
//  DetailView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/28/21.
//

import SwiftUI

struct DetailView: View {
    
    

    var ticketDetail: TicketModel = TicketModel(type: "Support", priority: "Low", company: "AccessWeb", user: "Gary Nazarian", inquiry: "This is a test...", date: "21:32 Wed, 01 Aug 2021")
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text(ticketDetail.type)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 25, weight: .light))
                Spacer()
                Spacer()
                Text(ticketDetail.date)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                HStack {
                    HStack {
                        Text(ticketDetail.user)
                            .font(.system(size: 20, weight: .light))
                    }
                    Spacer()
                    
                    if ticketDetail.priority == "High"{
                        Text("\(ticketDetail.priority) Priority")
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    } else if ticketDetail.priority == "Medium"{
                        Text("\(ticketDetail.priority) Priority")
                            .padding()
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    } else {
                        Text("\(ticketDetail.priority) Priority")
                            .padding()
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    
                }
                Spacer()
                Text(ticketDetail.inquiry)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .light))
            }
            
        }
        .navigationBarTitle(ticketDetail.company, displayMode: .inline)
        .listStyle(PlainListStyle())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
