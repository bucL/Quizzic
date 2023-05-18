//
//  SettingsView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsView: View {
    @AppStorage("currentView") var view: String = "home"
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        Button {
            view = "home"
        } label: {
            Text("Epic transition to home. username = \(username)")
        }
        
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
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
