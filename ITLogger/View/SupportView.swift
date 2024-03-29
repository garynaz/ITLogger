//
//  SupportView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct SupportView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var inquiryText : String = "Enter Your Inquiry..."
    @State private var selectedPriority : String = "Low"
    @Binding var selectedUsername: String
    
    var placeholderString = "Enter Your Inquiry..."
    var priorities = ["Low", "Medium", "High"]
    @Environment(\.presentationMode) var presentation //Tells the view to dismiss itself using its presentation mode environment key.
    
    
    var body: some View {
        let selectedUser = fetchUserDetails(withUser: selectedUsername)!
        
        VStack{
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "building.2.crop.circle")
                        .font(.system(size: 40))
                    Text("\(selectedUser.company!)")
                        .disabled(true)
                }
                
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 40))
                    Text("\(selectedUser.name!)")
                        .disabled(true)
                }
            }
            
            VStack {
                VStack {
                    Text("Priority Level")
                        .padding(.top)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Picker(selection: $selectedPriority, label: Text("Priority")) {
                        ForEach(priorities, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                TextEditor(text: $inquiryText)
                    .foregroundColor(.primary)
                    .frame(width: UIScreen.main.bounds.size.width - 20)
                    .frame(maxHeight: .infinity)
                    .background(Color.black)
                    .border(Color.gray)
                    .onTapGesture {
                        if inquiryText == placeholderString {
                            inquiryText = ""
                        }
                    }
            }
            Button("Submit Ticket") {
                createTicketObject(user: selectedUser, inquiry: inquiryText, priority: selectedPriority, status: "OPEN", type: "Support")
                self.presentation.wrappedValue.dismiss()
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 70, alignment: .center)
            .font(.title2)
            .background(Color.gray)
            .opacity(0.8)
            
        }        
    }
    
}

struct SupportView_Previews: PreviewProvider {
    @State static var username : String = "Tester"
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        createUserObject(company: "Carmel", name: "Gary", username: "Tester", password: "Test1234", photo: UIImage(systemName: "person.circle")!, admin: true)
        let fetchedUser = fetchUserDetails(withUser: username)!
        createTicketObject(user: fetchedUser, inquiry: "Help me with emails", priority: "High", status: "OPEN", type: "Support")
        
        return SupportView(selectedUsername: $username).environment(\.managedObjectContext, context)
    }
}
