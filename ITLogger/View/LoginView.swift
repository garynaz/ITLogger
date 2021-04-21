//
//  LoginView.swift
//  ITLogger
//
//  Created by Gary Naz on 3/14/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var goToContentView:moveToContentView
    
    @State private var selectedUser:User?
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var shouldShowLoginAlert: Bool = false
    @State var selectedImageArray : [UIImage] = []
        
    var disableLoginButton : Bool {
        return self.username.isEmpty || self.password.isEmpty
    }
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                Image(uiImage: #imageLiteral(resourceName: "awText"))
                    .resizable()
                    .frame(width: 180, height: 100)
                    .padding(.bottom, 50)
                
                TextField("Username", text: $username)
                    .padding(.leading)
                    Rectangle().fill(Color.gray.opacity(0.25)).frame(height: 1, alignment: .center).padding(.bottom)
                    .padding(.bottom)
                    .onChange(of: self.username, perform: { value in
                        if value.count > 10 {
                            self.username = String(value.prefix(10)) //Max 10 Characters for Username.
                        }
                    })
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding(.leading)
                    Rectangle().fill(Color.gray.opacity(0.25)).frame(height: 1, alignment: .center)
                    .onChange(of: self.username, perform: { value in
                        if value.count > 10 {
                            self.username = String(value.prefix(10)) //Max 10 Characters for Password.
                        }
                    })
                    .disableAutocorrection(true)
                
                NavigationLink(
                    destination: ContentView(selectedUser: self.selectedUser ?? User(context: moc), selectedImageArray: self.selectedImageArray),
                    isActive: self.$goToContentView.goToViewFromLogin){
                    Text("Login")
                        .onTapGesture {
                            selectedUser = fetchUserDetails(withUser: username)
                            
                            if self.username == selectedUser?.username && self.password == selectedUser?.password {
                                self.selectedImageArray = imagesFromCoreData(object: selectedUser!.photo!)!
                                print(self.selectedUser!)
                                self.goToContentView.goToViewFromLogin = true
                                
                            } else {
                                self.shouldShowLoginAlert = true
                            }
                        }
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding()
                }
                .disabled(disableLoginButton)
                
                NavigationLink(destination: SignUpView(), isActive: self.$goToContentView.goToViewFromRegister, label: {
                    Text("Sign Up").onTapGesture {
                        self.goToContentView.goToViewFromRegister = true
                    }
                })
                .frame(width: 300, height: 50)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .navigationTitle("AW Support")
            .alert(isPresented: $shouldShowLoginAlert, content: {
                Alert(title: Text("Email/Password Incorrect"))
            })
        }
        .navigationViewStyle(StackNavigationViewStyle()) //Makes the constraints error for navigationTitle go away...(Xcode issue)
    }
}

//Allows for the use of Optionals where Binding parameters are required (Ex.TextFields).
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
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
        print("New User Created")
    } catch {
        print(error)
    }
}

func createTicketObject(user: User, inquiry: String, priority: String, status: String, type: String){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm E, d MMM y"
    
    let newTicket = Ticket(context: context)
    newTicket.id = UUID()
    newTicket.date = formatter.string(from: today)
    newTicket.inquiry = inquiry
    newTicket.priority = priority
    newTicket.status = status
    newTicket.type = type
    
    user.addToTickets(newTicket)
    
    do {
        try context.save()
        print("New Ticket Created")
    } catch {
        print(error)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

