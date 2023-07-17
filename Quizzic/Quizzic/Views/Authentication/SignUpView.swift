//
//  SignUpView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @Binding var currentView: String
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    @State private var email: String = ""
    @State var incorrectPassword = false
    @State private var password: String = ""
    @State private var newusername: String = ""
    
    private func isValidPassword(_ password: String) -> Bool {
        // checks if the password matches the specifications
        // min 6 char, at least 1 uppercase and 1 special char
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Text("Create An Account")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: self.$email.max(100))
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    
                    Spacer()
                    
                    if email.count != 0 {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                        
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: self.$password.max(35))
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    Spacer()
                    if password.count != 0 {
                        
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ?  .green : .red)
                    }
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                
                .padding()
                
                HStack {
                    Image(systemName: "person")
                    TextField("Username", text:self.$newusername.max(40))
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                
                .padding()
                
                Button(action: {
                    
                    withAnimation() {
                        self.currentView = "login"
                    }
                    
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                Spacer()
                
                Button {
                    if isValidPassword(password) == true {
                        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
                            if let error = error {
                                print(error)
                                return
                            }
                            if let authResult = authResult {
                                print(authResult.user.uid)
                                userID = authResult.user.uid
                                let db = Firestore.firestore()
                                
                                db.collection("users").document("\(userID)").setData([
                                    "email": "\(email)",
                                    "username": "\(newusername)"
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                username = newusername
                            }
                        }
                    } else {
                        incorrectPassword = true
                    }
                } label: {
                    Text("Create Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)
                }
            }
        }.alert(isPresented: $incorrectPassword, content: {
            Alert(
                title: Text("Uh Oh"),
                message: Text("Please make sure the password you entered is a minimum of 6 characters long and has at least 1 uppercase character and 1 symbol"),
                dismissButton: .default(Text("Okay"))
                
            )
        })
    }
}
