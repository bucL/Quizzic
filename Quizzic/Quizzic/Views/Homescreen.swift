//
//  Homescreen.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

/**
 A view that displays the home screen after the user logs in.
 This view is wrapped inside a NavigationView and includes a welcome message showing the current user's username. It also provides a button to navigate to the QuizzesView where the user can take quizzes.
 - Note: The welcome message displays the username stored in AppStorage.
 - Precondition: The user must be logged in to view this screen.
 */

import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct Homescreen: View {
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("uid") var userID: String  = ""
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome Back \(username)") // Displays a welcome message with the current user's username stored in AppStorage.
                        .onAppear {
                            getQuizNames() // Calls the `getQuizNames()` function when the view appears to fetch quiz names for the QuizzesView()
                        }
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green) // Sets the background color to green.
                    
                    Spacer() // Spacer to create some empty space between the welcome message and the button.
                    
                    // Using the GeometryReader view to get the size of a view to correctly position the NavigationLink.
                    GeometryReader { geometry in
                        NavigationLink(destination: QuizzesView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.cyan) // Sets the background color of the button to cyan.
                                    .padding()
                                Text("Take a Quiz") // The button text to navigate to the QuizzesView.
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                            // Offsets the button to the right of the center of the screen using GeometryReader size.
                            .offset(x: geometry.size.width * 0.25)
                            // Sets the size of the button based on a fraction of the GeometryReader size.
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3, alignment: .center)
                            .padding() // Adds padding around the button.
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true) // Hides the navigation bar for a cleaner appearance.
        
    }
}

struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
    }
}
