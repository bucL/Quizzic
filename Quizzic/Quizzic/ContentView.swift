//
//  ContentView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("uid") var userID: String  = ""
    
    var body: some View {
        if userID == "" {
            
            AuthView()
        } else {
            Text("Logged In. User id is \(userID)")
            //Homescreen()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
