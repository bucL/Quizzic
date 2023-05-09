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
    
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        Text("\(username)")
    }
}

struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
    }
}
