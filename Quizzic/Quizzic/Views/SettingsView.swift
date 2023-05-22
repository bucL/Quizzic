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
    // Currently errors occur because view only exists in one file. 
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
//        ZStack{
//            VStack {
//                Text("Currentview is settingsview")
//                    .padding()
//
//                Button {
//                    let firebaseAuth = Auth.auth()
//                    do {
//                      try firebaseAuth.signOut()
//                        userID = ""
//                    } catch let signOutError as NSError {
//                      print("Error signing out: %@", signOutError)
//                    }
//                } label: {
//                    Text("log out")
//                }
//
//                HStack{
//                    Button {
//                        view = "home"
//                    } label: {
//                        VStack {
//                            Image(systemName: "house")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Home")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                    Button {
//                        view = "settings"
//                    } label: {
//                        VStack {
//                            Image(systemName: "gearshape")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Settings")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                    Button {
//                        view = "quizcreator"
//                    } label: {
//                        VStack {
//                            Image(systemName: "plus.square")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Create Quiz")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                }
//            }
//
//        }
        
        VStack {
            Text("Settings View")
            
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
