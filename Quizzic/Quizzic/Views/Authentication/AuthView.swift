//
//  AuthView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI

/**
 The main authentication view that allows users to log in or sign up.
 This view displays either the login view or the sign-up view based on the value of the `currentView` state variable.
 */
struct AuthView: View {
    @State private var currentView: String = "login"
    var body: some View {
        // Conditionally render either the login view or the sign-up view based on the value of `currentView`.
        if currentView == "login" {
            // Display the login view and set the preferred color scheme to light.
            LogInView(currentView: $currentView)
                .preferredColorScheme(.light)
        } else {
            // Display the sign-up view and set the preferred color scheme to dark.
            SignUpView(currentView: $currentView)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .top)) // Apply a transition when switching from login view to sign-up view.
        }
    }
}
