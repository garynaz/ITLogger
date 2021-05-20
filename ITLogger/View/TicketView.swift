//
//  TicketView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct TicketView: View {
            
    @Environment(\.managedObjectContext) var moc
    @Binding var selectedUsername : String
    
    
    var body: some View {
        
        let selectedUser = fetchUserDetails(withUser: selectedUsername)
        
        List{
            ForEach(Array(selectedUser!.tickets! as Set), id: \.self) { ticket in
                NavigationLink(
                    destination: DetailView(selectedTicket: ticket as! Ticket)){
                    VStack(alignment: .leading) {
                        Text("\((ticket as! Ticket).type!)")
                            .frame(maxWidth: .infinity)
                            .padding(.bottom)
                            .font(.system(size: 20, weight: .semibold))

                        HStack(alignment: .center) {
                            Text("\(((ticket as! Ticket).user?.company!)!)")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                            Text("\((ticket as! Ticket).status!)")
                                .padding()
                                .minimumScaleFactor(0.5)
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .lineLimit(1)
                        }
                        Text("\((ticket as! Ticket).date!)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        Spacer()
                        Spacer()
                        Text("Submitted By: \(((ticket as! Ticket).user?.name)!)")
                            .font(.system(size: 15, weight: .light))
                            .padding(.bottom, 5)
                        Text("\((ticket as! Ticket).inquiry!)")
                            .lineLimit(2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: { selectedIndex in
                let selectedTicket = Array(selectedUser!.tickets! as Set)[selectedIndex.first!]
                    self.moc.delete(selectedTicket as! Ticket)

                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
            }).animation(.default)
        }
        .toolbar(content: {
            EditButton()
        }).animation(.default)
    }
}

struct TicketView_Previews: PreviewProvider {
    @State static var username : String = "Tester"

    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        createUserObject(company: "Carmel", name: "Gary", username: "Tester", password: "Test1234", photo: UIImage(systemName: "person.circle")!, admin: true)
        let fetchedUser = fetchUserDetails(withUser: username)!
        createTicketObject(user: fetchedUser, inquiry: "Help me with emails", priority: "High", status: "OPEN", type: "Support")

        return TicketView(selectedUsername: $username).environment(\.managedObjectContext, context)
    }
}
