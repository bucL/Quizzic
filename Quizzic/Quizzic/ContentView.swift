//
//  ContentView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
 
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("uid") var userID: String  = ""
    
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


