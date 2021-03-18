//
//  SignUpView.swift
//  ITLogger
//
//  Created by Gary Naz on 3/14/21.
//

import SwiftUI
import CoreData

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var company: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var photo: Image?
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isSignUpValid: Bool = false
    @State private var shoudlShowSignUpAlert: Bool = false
    @State private var selectedUser:User?
        
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        VStack{

            TextField("Company", text: $company)
                .padding(.leading)
            Divider()
                .padding(.bottom)
            
            TextField("First and Last Name", text: $name)
                .padding(.leading)
            Divider()
                .padding(.bottom, 30)
            
            TextField("Username", text: $username)
                .padding(.leading)
            Divider()
                .padding(.bottom)
            
            SecureField("Password", text: $password)
                .padding(.leading)
                
            Divider()
                .padding(.bottom, 50)
            
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
                destination: ContentView(selectedUser: self.selectedUser ?? User()),
                isActive: self.$isSignUpValid){
                Text("Sign Up")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        
                        let isLoginValid = self.username != "" && self.password != ""
                        
                        createUserObject(company: self.company, name: self.name, username: self.username, password: self.password, photo: self.inputImage)
                        
                        if isLoginValid {
                            
                            selectedUser = fetchUserDetails(withUser: username)
                            self.isSignUpValid = true //trigger NavLink
                        } else {
                            self.shoudlShowSignUpAlert = true
                        }
                    }
            }
            .frame(width: 300, height: 50)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
        .navigationTitle("Sign Up")
        .alert(isPresented: $shoudlShowSignUpAlert, content: {
            Alert(title: Text("Fill it out correctly!"))
        })
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
