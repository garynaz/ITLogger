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
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isSignUpValid: Bool = false
    @State private var selectedUser:User?
    
    @State var selectedImageArray : [UIImage] = []
    
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var languages: FetchedResults<User>
    
    var disableSignUpButton : Bool {
        return self.username.isEmpty || self.password.isEmpty || self.name.isEmpty || self.company.isEmpty
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                
                TextField("Company", text: $company)
                    .padding(.leading)
                Divider()
                    .padding(.bottom)
                    .onChange(of: self.company, perform: { value in
                        if value.count > 30 {
                            self.company = String(value.prefix(30))
                        }
                    })
                    .disableAutocorrection(true)
                
                TextField("First and Last Name", text: $name)
                    .padding(.leading)
                Divider()
                    .padding(.bottom, 30)
                    .onChange(of: self.name, perform: { value in
                        if value.count > 30 {
                            self.name = String(value.prefix(30))
                        }
                    })
                    .disableAutocorrection(true)
                
                TextField("Username", text: $username)
                    .padding(.leading)
                Divider()
                    .padding(.bottom)
                    .onChange(of: self.username, perform: { value in
                        if value.count > 30 {
                            self.username = String(value.prefix(30))
                        }
                    })
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding(.leading)
                Divider()
                    .padding(.bottom, 50)
                    .onChange(of: self.password, perform: { value in
                        if value.count > 30 {
                            self.password = String(value.prefix(30))
                        }
                    })
                    .disableAutocorrection(true)
                
                ZStack{
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 200, height: 200)
                    
                    if photo != nil {
                        photo?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 300, height: 300)
                    } else {
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
                    destination: ContentView(selectedUser: self.selectedUser ?? User(context: moc), selectedImageArray: self.selectedImageArray),
                    isActive: self.$isSignUpValid){
                    Text("Sign Up")
                        .onTapGesture {
                            createUserObject(company: self.company, name: self.name, username: self.username, password: self.password, photo: self.inputImage)
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
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
