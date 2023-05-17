//
//  HomepageView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

import SwiftUI

struct HomepageView: View {
    @AppStorage("currentView") var view: String = "home"
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        Button {
            view = "settings"
        } label: {
            Text("Epic transition to settings")
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
