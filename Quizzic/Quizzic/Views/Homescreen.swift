//
//  Homescreen.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct Homescreen: View {
    @AppStorage("currentView") var view: String = "home"
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {

//        TabView {
//            Homescreen()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gearshape.fill")
//                }
//        }
        
        
        
        if view == "home" {
            HomepageView()

//            ZStack {
//                Button {
//                    view = "settings"
//                } label: {
//                    Text("Click Me. Current View \(view). \(username)")
//                }
//            }
        } else if view == "settings" {
            SettingsView()

//            Button {
//                view =  "home"
//            } label: {
//                Text("Click Me. Current view \(view). \(username)")
//            }
        } else if view == "quizcreate" {

        }
        
    }
}

struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
            
    }
}
