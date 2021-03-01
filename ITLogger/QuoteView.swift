//
//  QuoteView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct QuoteView: View {
    @EnvironmentObject var supportTicket : UpdateModel
    @State private var inquiryText : String = "Quote Request..."
    @State private var selectedPriority : String = "Low"
    @State private var companyName : String = ""
    @State private var userName : String = ""
    var placeholderString = "Quote Request..."
    var priorities = ["Low", "Medium", "High"]
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "building.2.crop.circle")
                        .font(.system(size: 40))
                    TextField("Company Name", text: $companyName)
                }
                .offset(x: UIScreen.main.bounds.width / 2 - 120)
                
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 40))
                    TextField("Staff Name", text: $userName)
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
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 500, alignment: .leading)
                    .background(Color.black)
                    .border(Color.gray)
                    .onTapGesture {
                        if inquiryText == placeholderString {
                            inquiryText = ""
                        }
                    }
            }
            Button("Submit Request") {
                supportTicket.addTicket(ticket: TicketModel(type: "Quote", priority: selectedPriority, company: companyName, user: userName, inquiry: inquiryText))
                self.presentation.wrappedValue.dismiss()
            }
                .frame(width: UIScreen.main.bounds.size.width, height: 70, alignment: .center)
                .font(.title2)
                .background(Color.gray)
                .opacity(0.8)
        }
        
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
