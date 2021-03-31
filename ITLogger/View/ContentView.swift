//
//  ContentView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
            
    @ObservedObject var selectedUser : User //Assign logged in user to this variable...
        
    @State var selectedImageArray : [UIImage]
    
    var body: some View {
        
            VStack{
                Spacer()
                VStack(spacing: 50){
                    
                    NavigationLink(destination: SupportView(selectedUser: self.selectedUser)){
                        awButton(content: "Request Support", backColor: Color(#colorLiteral(red: 0, green: 0.723585546, blue: 0.9907287955, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }

                    NavigationLink(destination: QuoteView(selectedUser: self.selectedUser)){
                        awButton(content: "Request Quote", backColor: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }

                    NavigationLink(destination: TicketView(selectedUser: self.selectedUser)){
                        awButton(content: "Ticket Status", backColor: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                            .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                            .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                    }
                }
                Spacer()
            }
            .navigationTitle(selectedUser.company!)
            .navigationBarItems(trailing: HStack{
                Image(systemName: "bell")
                    .font(.system(size: 30))
                Image(uiImage: selectedImageArray.first!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                Text(selectedUser.name!)
                    .font(.system(size: 20))
            })
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   //Test data
        let newUser = User.init(context: context)
        newUser.username = "Tester"
        newUser.password = "Test1234"
        return ContentView(selectedUser: newUser, selectedImageArray: [UIImage(systemName: "person.circle")!]).environment(\.managedObjectContext, context)
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

//Produces an Array of Images from a Data object.
func imagesFromCoreData(object: Data?) -> [UIImage]? {
    var retVal = [UIImage]()

    guard let object = object else { return nil }
    if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
        for data in dataArray {
            if let data = data as? Data, let image = UIImage(data: data) {
                retVal.append(image)
            }
        }
    }
    return retVal
}
