//
//  ContentView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String  = ""
    
    var body: some View {
        if userID == "" {
            
            AuthView()
        } else {
            VStack {
                Text("Logged In. User id is \(userID)")
                
                Button {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        userID = ""
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                } label: {                    Text("Sign Out")
                }
                //Homescreen()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
