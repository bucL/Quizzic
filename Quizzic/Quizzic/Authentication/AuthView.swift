//
//  AuthView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI

struct AuthView: View {
    @State private var currentView: String = "login"
    
    var body: some View {
        if currentView == "login" {
            LogInView(currentView: $currentView)
                .preferredColorScheme(.light)
        } else {
            SignUpView(currentView: $currentView)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .top))
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
