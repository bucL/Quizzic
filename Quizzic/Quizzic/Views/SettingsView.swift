//
//  SettingsView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

import SwiftUI


struct SettingsView: View {
    @AppStorage("currentView") var view: String = "home"
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        Button {
            view = "home"
        } label: {
            Text("Epic transition to home")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
