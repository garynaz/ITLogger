//
//  ContentView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var tickets = UpdateModel()
    
    var body: some View {
        
        
        NavigationView{
            VStack{
                Spacer()
                VStack(spacing: 50){
                    
                    NavigationLink(destination: SupportView()){
                        awButton(content: "Request Support", backColor: Color(#colorLiteral(red: 0, green: 0.723585546, blue: 0.9907287955, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }

                    NavigationLink(destination: QuoteView()){
                        awButton(content: "Request Quote", backColor: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }

                    NavigationLink(destination: TicketView()){
                        awButton(content: "Ticket Status", backColor: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }
                }
                Spacer()
            }
            .navigationTitle("AccessWeb")
            .navigationBarItems(trailing: HStack{
                Image(systemName: "bell")
                    .font(.system(size: 30))
                Image(systemName:"person.circle")
                    .font(.system(size: 30))
                Text("Tester")
                    .font(.system(size: 20))
            })
            
        }.environmentObject(tickets)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct awButton: View {
    var content : String
    var backColor : Color
    var body: some View {
            VStack {
                HStack {
                    Image(uiImage: #imageLiteral(resourceName: "awText"))
                        .resizable()
                        .frame(width: 30, height: 20)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top)
                HStack {
                    Text("\(content)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .offset(y: 10.0)
                }
                Spacer()
            }
        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .frame(width: 300, height: 150, alignment: .center)
        .background(backColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        
    }
}
