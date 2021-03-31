//
//  QuoteView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct QuoteView: View {
    
    init(selectedUser:User) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor : UIColor.white], for: .selected)
        self.selectedUser = selectedUser
    }
    
    @ObservedObject var selectedUser : User

    @State private var inquiryText : String = "Quote Request..."
    @State private var selectedPriority : String = "Low"
    
    var placeholderString = "Quote Request..."
    var priorities = ["Low", "Medium", "High"]
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ScrollView{
            VStack{
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "building.2.crop.circle")
                            .font(.system(size: 40))
                        TextField("Company", text: $selectedUser.company ?? "")
                        
                    }
                    .offset(x: UIScreen.main.bounds.width / 2 - 120)
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.system(size: 40))
                        TextField("User", text: $selectedUser.name ?? "")
                        
                    }
                    .offset(x: UIScreen.main.bounds.width / 2 - 120)
                }
                
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
                    
                    TextEditor(text: $inquiryText)
                        .foregroundColor(inquiryText == placeholderString ? .gray : .black)
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: 450, alignment: .leading)
                        .background(Color.black)
                        .border(Color.gray)
                        .onTapGesture {
                            if inquiryText == placeholderString {
                                inquiryText = ""
                            }
                        }
                }
                Button("Submit Request") {
                    createTicketObject(user: selectedUser, inquiry: inquiryText, priority: selectedPriority, status: "OPEN", type: "Quote")
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(width: UIScreen.main.bounds.size.width, height: 70, alignment: .center)
                .font(.title2)
                .background(Color.gray)
                .opacity(0.8)
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
//        QuoteView()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   //Test data
        let newUser = User.init(context: context)
        newUser.username = "Tester"
        newUser.password = "Test1234"
        return QuoteView(selectedUser: newUser).environment(\.managedObjectContext, context)
    }
}
