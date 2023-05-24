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
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        if userID == "" {
            
            AuthView()
        } else {
//            VStack {
//                Text("Logged In. User id is \(userID). Username is \(username)")
//
//                Button {
//                    let firebaseAuth = Auth.auth()
//                    do {
//                        try firebaseAuth.signOut()
//                        userID = ""
//                        username = ""
//                    } catch let signOutError as NSError {
//                        print("Error signing out: %@", signOutError)
//                    }
//                } label: {
//                    Text("Sign Out")
//                }
            
            
            /// I think TabView has to go here in order for it to work properly since it wasn't working when placed in the homescreen file;
            /// Homescreen()
            
            TabView {
                Homescreen()
                    .tabItem {
                        Label("Homepage", systemImage: "house")
                    }
                QuizCreator()
                    .tabItem {
                        Label("Create", systemImage: "plus.square")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.circle")
                    }
                            
            }
            
                
            }
            
        }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
