//
//  ContentView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseAuth

/* REMARK @bucL
* What is going on in this file? 
*
* You have almost no commenting, you are not going to
* have a good time going back and commenting these files
* you should ensure that you are commenting as you go.
*
* Likewise, you should make sure you are separating 
* your screen elements into views, using the features
* of swiftui to make your app interactive. Like @state 
*/

struct ContentView: View {
    
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        if userID == "" {
            
            AuthView()
        } else {
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
