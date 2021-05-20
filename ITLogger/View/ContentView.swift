//
//  ContentView.swift
//  ITLogger
//
//  Created by Gary Naz on 2/23/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var goToContentView: moveToContentView
    @Binding var selectedUsername : String
    @Binding var selectedImageArray : [UIImage]
    
    
    
    var body: some View {
        
        let selectedUser = fetchUserDetails(withUser: selectedUsername)
        
        VStack{
            Spacer()
            VStack(spacing: 50){
                
                NavigationLink(destination: SupportView(selectedUsername: $selectedUsername)){
                    awButton(content: "Request Support", backColor: Color(#colorLiteral(red: 0, green: 0.723585546, blue: 0.9907287955, alpha: 1)))
                        .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                        .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                }
                
                NavigationLink(destination: QuoteView(selectedUsername: $selectedUsername)){
                    awButton(content: "Request Quote", backColor: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                        .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                        .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                }
                
                NavigationLink(destination: TicketView(selectedUsername: $selectedUsername)){
                    awButton(content: "Ticket Status", backColor: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                        .shadow(color: Color.primary.opacity(0.5), radius: 20, x: 0, y: 20)
                        .rotation3DEffect(Angle(degrees:10), axis: (x: 10.0, y: 0, z: 0))
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(selectedUser!.company!)
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

struct ContentView_Previews: PreviewProvider {
    @State static var selectedImageArray : [UIImage] = [UIImage(systemName: "person.circle")!]
    @State static var username : String = "Tester"
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        createUserObject(company: "Carmel", name: "Gary", username: "Tester", password: "Test1234", photo: UIImage(systemName: "person.circle")!, admin: true)
        let fetchedUser = fetchUserDetails(withUser: username)!
        createTicketObject(user: fetchedUser, inquiry: "Help me with emails", priority: "High", status: "OPEN", type: "Support")
        
        return ContentView(selectedUsername: $username, selectedImageArray: $selectedImageArray).environment(\.managedObjectContext, context)
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
