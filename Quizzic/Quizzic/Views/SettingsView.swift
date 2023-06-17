//
//  SettingsView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

/*
* REMARK: @bucL
* Once again you have not commented your code,
* it is very clear when you return to a file 
* with less understanding of what happened and 
* attempt to comment that code. 
*
* You are also not binding this to any kind of 
* state or environment object. So these settings
* will not be persisted around the application.
* You need to look into the best practices for handling
* data and its transfer. 
*/

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsView: View {
    
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        
        VStack {
            HStack{
                Image("UserDefaultImage")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding()
                Text("\(username)")
                    .font(.headline)
                    .padding(.leading, 10)
                Spacer()


            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
                    .opacity(0.6)
                
            )
            .padding()
            
            Spacer()
            
            
            Button {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    userID = ""
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            } label: {
                Text("log out")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                    )
                    .padding()
            }
            
            
        }
        .padding()
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
