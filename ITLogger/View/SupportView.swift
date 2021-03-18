//
//  SupportView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct SupportView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor : UIColor.white], for: .selected)
    }
    
//    @EnvironmentObject var supportTicket : UpdateModel
    @State private var inquiryText : String = "Enter Your Inquiry..."
    @State private var selectedPriority : String = "Low"
    @State private var companyName : String = ""
    @State private var userName : String = ""
    var placeholderString = "Enter Your Inquiry..."
    var priorities = ["Low", "Medium", "High"]
    @Environment(\.presentationMode) var presentation //Tells the view to dismiss itself using its presentation mode environment key.
    
    
    var body: some View {
        ScrollView{
            VStack{
                VStack {
                    HStack {
                        Image(systemName: "building.2.crop.circle")
                            .font(.system(size: 40))
                        TextField("Company", text: $companyName)
                    }
                    .offset(x: UIScreen.main.bounds.width / 2 - 120)
                    
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.system(size: 40))
                        TextField("User", text: $userName)
                        
                    }
                    .offset(x: UIScreen.main.bounds.width / 2 - 120)
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
                Button("Submit Ticket") {
//                    let today = Date()
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "HH:mm E, d MMM y"
                    
//                    supportTicket.addTicket(ticket: TicketModel(type: "Support", priority: selectedPriority, company: companyName, user: userName, inquiry: inquiryText, date: formatter.string(from: today)))
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

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
