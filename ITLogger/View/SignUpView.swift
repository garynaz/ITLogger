//
//  SignUpView.swift
//  ITLogger
//
//  Created by Gary Naz on 3/14/21.
//

import SwiftUI
import CoreData

struct SignUpView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var name: String = ""
    @State private var company: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var photo: Image?
    @State private var admin: Bool = false
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isSignUpValid: Bool = false
    @State private var selectedUser:User?
    
    @State var selectedImageArray : [Image] = []
    
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var languages: FetchedResults<User>
    
    var disableSignUpButton : Bool {
        return self.username.isEmpty || self.password.isEmpty || self.name.isEmpty || self.company.isEmpty
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                Group {
                    TextField("Company", text: $company)
                        .padding(.leading)
                        .disableAutocorrection(true)
                    Divider()
                        .padding(.bottom)
                        .onChange(of: self.company, perform: { value in
                            if value.count > 30 {
                                self.company = String(value.prefix(30))
                            }
                        })
                    
                    TextField("First and Last Name", text: $name)
                        .padding(.leading)
                        .disableAutocorrection(true)
                    Divider()
                        .padding(.bottom, 30)
                        .onChange(of: self.name, perform: { value in
                            if value.count > 30 {
                                self.name = String(value.prefix(30))
                            }
                        })
                    
                    TextField("Username", text: $username)
                        .padding(.leading)
                        .disableAutocorrection(true)
                    Divider()
                        .padding(.bottom)
                        .onChange(of: self.username, perform: { value in
                            if value.count > 30 {
                                self.username = String(value.prefix(30))
                            }
                        })
                    
                    SecureField("Password", text: $password)
                        .padding(.leading)
                        .disableAutocorrection(true)
                    Divider()
                        .padding(.bottom, 50)
                        .onChange(of: self.password, perform: { value in
                            if value.count > 30 {
                                self.password = String(value.prefix(30))
                            }
                        })
                    
                }
                
                VStack{
                    Text("ADMIN")
                        .foregroundColor(admin ? .green : .gray)
                    Toggle("", isOn: $admin)
                        .labelsHidden()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(admin ? .green : .gray)
                )
                .padding(.bottom)
                
                
                ZStack{
                    if photo != nil {
                        photo?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.secondary)
                            .frame(width: 200, height: 200)
                        Text("Tap to select a photo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .padding(.bottom, 50)
                
                NavigationLink(
                    destination: getDestination(from: admin),
                    isActive: self.$isSignUpValid){
                    Text("Sign Up")
                        .onTapGesture {
                            createUserObject(company: self.company, name: self.name, username: self.username, password: self.password, photo: self.inputImage, admin: self.admin)
                            selectedUser = fetchUserDetails(withUser: username)
                            self.selectedImageArray = imagesFromCoreData(object: selectedUser!.photo!)!
                            isSignUpValid = true
                        }
                }
                .disabled(disableSignUpButton)
                .frame(width: 300, height: 50)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
        }
        
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        photo = Image(uiImage: inputImage)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



