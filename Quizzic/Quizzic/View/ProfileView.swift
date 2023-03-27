//
//  ProfileView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 27/3/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            Text("Succesfully authenticated \(user.user?.firstName ?? "") \(user.user?.lastName ?? "")")
            Button(action: {
                user.signOut()
            }) {
                Text("Sign Out")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
