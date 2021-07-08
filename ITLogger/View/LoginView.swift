//
//  LoginView.swift
//  ITLogger
//
//  Created by Gary Naz on 3/14/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var goToContentView : moveToContentView
    
    @State private var selectedUser : User?
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
                    .disableAutocorrection(true)
                    Rectangle().fill(Color.gray.opacity(0.25)).frame(height: 1, alignment: .center).padding(.bottom)
                    .padding(.bottom)
                    .onChange(of: self.username, perform: { value in
                        if value.count > 10 {
                            self.username = String(value.prefix(10)) //Max 10 Characters for Username.
                        }
                    })
                    
                
                SecureField("Password", text: $password)
                    .padding(.leading)
                    .disableAutocorrection(true)
                    Rectangle().fill(Color.gray.opacity(0.25)).frame(height: 1, alignment: .center)
                    .onChange(of: self.username, perform: { value in
                        if value.count > 10 {
                            self.username = String(value.prefix(10)) //Max 10 Characters for Password.
                        }
                    })
                    
                //SignIn Button
                NavigationLink(
                    destination: getDestination(from: selectedUser?.admin ?? false),
                    isActive: self.$goToContentView.goToViewFromLogin){
                    Text("Login")
                        .onTapGesture {
                            selectedUser = fetchUserDetails(withUser: username)
                            
                            if self.username == selectedUser?.username && self.password == selectedUser?.password {
                                self.selectedImageArray = imagesFromCoreData(object: selectedUser!.photo!)!
                                print(selectedImageArray)
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
                
                //SignUp Button
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
    
    //Sets appropariate destination based on value of Admin property.
    func getDestination(from adminValue: Bool) -> AnyView {
        
            if adminValue == false {
                return AnyView(ContentView(selectedUsername: $username, selectedImageArray: self.$selectedImageArray))
            }
            else {
                return AnyView(AdminView(selectedUsername: $username, selectedImageArray: self.$selectedImageArray))
            }
        }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(moveToContentView())
    }
}
