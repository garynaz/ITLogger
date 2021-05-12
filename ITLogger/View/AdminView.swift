//
//  AdminView.swift
//  ITLogger
//
//  Created by Gary Naz on 5/2/21.
//

import SwiftUI

struct AdminView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var goToContentView: moveToContentView
    @Binding var selectedUsername : String
    @State var selectedImageArray : [UIImage]
    
    @FetchRequest(fetchRequest: Ticket.fetchAllTicketDetails()) var allTickets:FetchedResults<Ticket>
    

    var body: some View {
        
        let selectedUser = fetchUserDetails(withUser: selectedUsername)

        List{
            ForEach(self.allTickets) { ticket in
                VStack{
                    
                    NavigationLink(
                        destination: DetailView(selectedTicket: ticket)){
                        VStack(alignment: .leading) {
                            
                            Text("\(ticket.type!)")
                                .frame(maxWidth: .infinity)
                                .padding(.bottom)
                                .font(.system(size: 20, weight: .semibold))
                            
                            HStack(alignment: .center) {
                                Text("\((ticket.user?.company!)!)")
                                    .font(.system(size: 20, weight: .bold))
                                Spacer()
                                Text("\(ticket.status!)")
                                    .padding()
                                    .minimumScaleFactor(0.5)
                                    .background(Color.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .lineLimit(1)
                            }
                            Text("\(ticket.date!)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            Spacer()
                            Spacer()
                            Text("Submitted By: \((ticket.user?.name)!)")
                                .font(.system(size: 15, weight: .light))
                                .padding(.bottom, 5)
                            Text("\(ticket.inquiry!)")
                                .lineLimit(2)
                                .foregroundColor(.gray)
                        }
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
        })
        .animation(.default)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("ADMIN")
        .navigationBarItems(leading: Button(action: {
            
            if self.goToContentView.goToViewFromLogin == true {
                self.goToContentView.goToViewFromLogin = false
            } else {
                self.goToContentView.goToViewFromRegister = false
            }
            
        }) {
            HStack {
                Text("Sign Out")
            }
        },trailing: HStack{
            Image(systemName: "bell")
                .font(.system(size: 30))
            Image(uiImage: selectedImageArray.first!)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            Text(selectedUser!.name!)
                .font(.system(size: 20))
        })
        
    }
}

//struct AdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminView()
//    }
//}

