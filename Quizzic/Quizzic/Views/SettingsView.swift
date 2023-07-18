//
//  SettingsView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import PDFKit

// SettingsView displays the user settings and options.
struct SettingsView: View {
    // AppStorage variables to store the current user's uid and username across app restarts for persistent login.
    @AppStorage("uid") var userID: String = ""
    @AppStorage("username") var username: String = ""
    
    @State private var showHelp = false // State variable to control if the HelpView should be shown or not.
    let pdfName = "help" // Name of the PDF file for HelpView.
    
    var body: some View {
        NavigationView {
            VStack {
                // Display the user's profile image, username, and a help button.
                HStack {
                    Image("UserDefaultImage")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding()
                    Text("\(username)")
                        .font(.headline)
                        .padding(.leading, 10)
                    Spacer()
                }
                // Add a border around the user's profile details.
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.blue)
                        .opacity(0.6)
                )
                .padding()
                
                Spacer() // Add a spacer to separate the user's profile details and buttons.
                
                // Help button to navigate to the HelpView.
                NavigationLink(destination: HelpView(), isActive: $showHelp) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Text("Help")
                            .padding(.trailing)
                            .foregroundColor(Color.white)
                            .font(.subheadline)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                    )
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Spacer() // Add a spacer to separate the help button and the log out button.
                
                // Log out button to sign out the user.
                Button {
                    /**
                        Sign out the current user using Firebase Authentication.
                        This function signs out the current user from the Firebase Authentication service.
                        It resets the `userID` variable to an empty string after successful sign-out.
                    */
                    func signOutUser() {
                        // Get the Firebase Authentication instance.
                        let firebaseAuth = Auth.auth()
                        do {
                            // Attempt to sign out the current user.
                            try firebaseAuth.signOut()
                            // Reset the userID to an empty string after successful sign-out.
                            userID = ""
                        } catch let signOutError as NSError {
                            // Print an error message if there is an error during sign-out.
                            print("Error signing out: \(signOutError)")
                        }
                    }
                } label: {
                    // UI Portion of the Button i.e. what the user will see when the look at this view. 
                    Text("Log Out")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding()
                }
            }
            .padding()
        }
        .navigationBarHidden(true) // Hide the navigation bar for a cleaner UI.
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
