//
//  DetailView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/28/21.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var selectedTicket : Ticket
        
    var body: some View {
        
        List {
            VStack(alignment: .leading) {
                Text(selectedTicket.type!)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 25, weight: .light))
                Spacer()
                Spacer()
                Text(selectedTicket.date!)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                HStack {
                    HStack {
                        Text((selectedTicket.user?.name)!)
                            .font(.system(size: 20, weight: .light))
                    }
                    Spacer()
                    
                    if selectedTicket.priority! == "High"{
                        Text("\(selectedTicket.priority!) Priority")
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    } else if selectedTicket.priority! == "Medium"{
                        Text("\(selectedTicket.priority!) Priority")
                            .padding()
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    } else {
                        Text("\(selectedTicket.priority!) Priority")
                            .padding()
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    
                }
                Spacer()
                Text(selectedTicket.inquiry!)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .light))
            }
            
        }
        .navigationBarTitle((selectedTicket.user?.company)!, displayMode: .inline)
        .listStyle(PlainListStyle())
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        createUserObject(company: "Carmel", name: "Gary", username: "Tester", password: "Test1234", photo: UIImage(systemName: "person.circle")!, admin: true)
        let fetchedUser = fetchUserDetails(withUser: "Tester")!
        createTicketObject(user: fetchedUser, inquiry: "Help me with emails", priority: "High", status: "OPEN", type: "Support")
        let fetchedTicket = fetchUserTicketDetails(inquiry: "Help me with emails")
        
        return DetailView(selectedTicket: fetchedTicket!)
    }
}
