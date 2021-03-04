//
//  TicketView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct TicketView: View {
        
    @EnvironmentObject var ticketStatus : UpdateModel
    
    var body: some View {
        List{
            ForEach(ticketStatus.updateData){ ticket in
                NavigationLink(
                    destination: DetailView(ticketDetail: ticket)){
                    VStack(alignment: .leading) {
                        Text(ticket.type)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
                            .font(.system(size: 20, weight: .semibold))
                            
                        HStack(alignment: .center) {
                            Text(ticket.company)
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                            Text(ticket.status)
                                .padding()
                                .minimumScaleFactor(0.5)
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .lineLimit(1)
                        }
                        Text(ticket.date)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        Spacer()
                        Spacer()
                        Text("Submitted By: \(ticket.user)")
                            .font(.system(size: 15, weight: .light))
                            .padding(.bottom, 5)
                        Text(ticket.inquiry)
                            .lineLimit(2)
                            .foregroundColor(.gray)
                    }
                }
                
            }
            .onDelete(perform: { index in
                self.ticketStatus.updateData.remove(atOffsets: index)
            })
        }
        .toolbar(content: {
            EditButton()
        })
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TicketView().environmentObject(UpdateModel())
        }
    }
}
