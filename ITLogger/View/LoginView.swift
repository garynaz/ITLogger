//
//  LoginView.swift
//  ITLogger
//
//  Created by Gary Naz on 3/14/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @State private var username : String = ""
    @State private var password : String = ""
    
    @State private var isLoginValid: Bool = false
    @State private var shoudlShowLoginAlert: Bool = false
    
    @State private var selectedUser:User?
    
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image(uiImage: #imageLiteral(resourceName: "awText"))
                    .resizable()
                    .frame(width: 180, height: 100)
                    .padding(.bottom, 50)
                
                TextField("Username", text: $username)
                    .padding(.leading)
                    Divider()
                    .padding(.bottom)
                
                TextField("Password", text: $password)
                    .padding(.leading)
                    Divider()
                
                NavigationLink(
                    destination: ContentView(selectedUser: self.selectedUser ?? User()),
                    isActive: self.$isLoginValid,
                    label: {
                        Text("Login")
                    })
                    .onTapGesture {
                        selectedUser = fetchUserDetails(withUser: username)
                        let isLoginValid = self.username == selectedUser?.username && self.password == selectedUser?.password
                        
                        if isLoginValid {
                            self.isLoginValid = true //trigger NavLink
                        } else {
                            self.shoudlShowLoginAlert = true
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                
                NavigationLink(
                    destination: SignUpView(),
                    label: {
                        Text("Sign Up")
                    })
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .navigationTitle("AW Support")
            .alert(isPresented: $shoudlShowLoginAlert, content: {
                Alert(title: Text("Email/Password Incorrect"))
            })
        }
        
    }
}

func fetchUserDetails(withUser user: String) -> User? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<User>(entityName: "User")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "username == %@", user)
    
    do {
        let fetchUser = try context.fetch(fetchRequest)
        return fetchUser.first
    } catch let fetchError {
        print("Failed to fetch: \(fetchError)")
    }
    return nil
}

func createUserObject(company: String, name: String, username: String, password: String, photo: UIImage?){
    
    //Produces a Data object from an Array of Images.
    func coreDataObjectFromImages(image: UIImage) -> Data? {
        let dataArray = NSMutableArray()
        
            if let data = image.pngData() {
                dataArray.add(data)
            }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let newUser = User(context: context)
    newUser.id = UUID()
    newUser.admin = false
    newUser.company = company
    newUser.name = name
    newUser.username = username
    newUser.password = password
    newUser.photo = coreDataObjectFromImages(image: (photo ?? UIImage(systemName:"person.circle")!))

    do {
        try context.save()
    } catch {
        print(error)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
