//
//  ContentView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String  = ""  // Storage property to store the user ID
    @AppStorage("username") var username: String = ""  // Storage property to store the username
    
    var body: some View {
        if userID == "" {
            AuthView()  // If the userID is empty, display the AuthView
        } else {
            TabView () {
                Homescreen()
                    .tabItem {
                        Label("Homepage", systemImage: "house")  // Display a tab item for the Homescreen view
                    }
                QuizCreator()
                    .tabItem {
                        Label("Create", systemImage: "plus.square")  // Display a tab item for the QuizCreator view
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")  // Display a tab item for the SearchView
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.circle")  // Display a tab item for the SettingsView
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
