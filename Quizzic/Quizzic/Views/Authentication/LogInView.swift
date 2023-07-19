//
//  LogInView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//
/**
        A SwiftUI view for signing into a pre-existing account.
        This view allows the user to sign into a pre-existing account by providing their email and password. It utilizes Firebase authentication to sign into the account and retrieves user data from the Firestore database and updates the userID and username AppStorage variables  if the provided information is va
*/

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LogInView: View {
    // Binding used to change between the SignUp and Login Views.
    @Binding var currentView: String
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("uid") var userID: String  = ""

    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("username") var username: String = ""
    
    // Variables used to facilitate the use of TextField's and secure fields as well as the isValidPassword and Firebase Functions
    @State private var email: String = ""
    @State private var password: String = ""
    
    // Variables used to determine if an error needs to be displayed. 
    @State var showError = false
    @State var isEmptyAlert = false
    
    var body: some View {
        ZStack {
            // Set the entire page background to white.
            Color.white.edgesIgnoringSafeArea(.all)
            // A vertical stack to display the sign-in form.
            VStack {
                // Horizontal stack to display the welcome text.
                HStack {
                    Text("Welcome Back")
                        .font(.largeTitle) // Set the font size to large title.
                        .bold() // Make the text bold.
                    Spacer() // Add a flexible space to push the text to the left.
                }
                .padding() // Add general padding to the horizontal stack.
                .padding(.top) // Add additional top padding.

                Spacer() // Add a flexible space to push content to the top.

                // Horizontal stack to hold the email input field and validation icon.
                HStack {
                    Image(systemName: "mail") // Email icon.
                    
                    TextField("Email", text: self.$email.max(100))
                        .autocapitalization(.none) // Disable auto-capitalization for the email input field.

                    Spacer() // Add a flexible space to push the content to the right.

                    // Checkmark or Xmark icon based on email validity.
                    if email.count != 0 {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold) // Make the icon's text bold.
                            .foregroundColor(email.isValidEmail() ? .green : .red) // Set the icon's color based on validity.
                    }
                }
                .padding() // Add general padding to the horizontal stack.
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Apply a rounded border to the stack.
                        .stroke(lineWidth: 2) // Set the border width to 2.
                        .foregroundColor(.black) // Set the border color to black.
                )
                .padding() // Add more padding to the stack.

                // Horizontal stack to hold the password input field and validation icon.
                HStack {
                    Image(systemName: "lock") // Lock icon.
                    
                    SecureField("Password", text: $password) // Secure password input field.
                        .autocapitalization(.none) // Disable auto-capitalization for the password input field.

                    Spacer() // Add a flexible space to push the content to the right.

                    // Checkmark or Xmark icon based on password validity.
                    if password.count != 0 {
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold) // Make the icon's text bold.
                            .foregroundColor(isValidPassword(password) ? .green : .red) // Set the icon's color based on validity.
                    }
                }
                .padding() // Add general padding to the horizontal stack.
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Apply a rounded border to the stack.
                        .stroke(lineWidth: 2) // Set the border width to 2.
                        .foregroundColor(.black) // Set the border color to black.
                )
                .padding() // Add more padding to the stack.

                // Button to navigate to the signup page.
                Button(action: {
                    withAnimation() {
                        self.currentView = "signup"
                    }
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7)) // Set the text color to black with 70% opacity.
                }

                Spacer() // Add a flexible space to push content to the center.

                // Button to sign in with email and password.
                Button {
                    if email.isEmpty || password.isEmpty {
                        isEmptyAlert = true // Show an alert if the email or password fields are empty.
                    } else {
                        /**
                         Sign in with the provided email and password using Firebase authentication.
                         This function attempts to sign in the user with the provided email and password using Firebase authentication. If successful, it saves the authenticated user's ID in the `userID` variable and retrieves additional user data from Firestore.
                         - Parameters:
                            - email: The user's email for sign-in.
                            - password: The user's password for sign-in.
                         - Note: The function utilizes Firebase authentication to authenticate the user's email and password. It also fetches additional user data from Firestore if the sign-in process is successful.
                         - Warning: This function should be used securely, and the user's credentials should be handled with care.
                         */
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                showError = true // Set the `showError` variable to true to show an error alert.
                                print(error) // Print any error that occurs during sign-in.
                                return // Exit the function if there is an error to prevent further execution.
                            }

                            if let authResult = authResult {
                                userID = authResult.user.uid // Save the authenticated user's ID to the `userID` variable.
                                print(authResult.user) // Print the authenticated user's data.

                                let db = Firestore.firestore() // Create a Firestore database reference.
                                let docRef = db.collection("users").document("\(userID)") // Create a document reference for the user in the "users" collection with the user's ID.
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let dataDescription = document.data().map(String.init(describing: )) ?? "nil" // Convert the user data to a string representation or set it to "nil" if empty.
                                        print("Document data: \(dataDescription)") // Print the retrieved user data.

                                        let data = document.data() // Get the user data from the document snapshot.
                                        self.username = data!["username"] as? String ?? "" // Assign the username value to the `username` variable if it exists, otherwise set it to an empty string.
                                        print(username) // Print the user's username.
                                    } else {
                                        print("Document does not exist") // Print a message if the user's document does not exist in the Firestore database.
                                    }
                                }
                            }
                            return
                        }
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white) // Set the text color to white.
                        .font(.title3) // Set the font size to title3.
                        .bold() // Make the text bold.
                        .frame(maxWidth: .infinity) // Make the button's width fill the available space.
                        .padding() // Add padding to the button.
                        .background (
                            RoundedRectangle(cornerRadius: 10) // Apply a rounded border to the button.
                                .fill(Color.black) // Set the button background color to black.
                        )
                        .padding(.horizontal) // Add horizontal padding to the button.
                }
                
            }

        }
        .alert(isPresented: $showError, content: {
            Alert(
                title: Text("Uh Oh"),
                message: Text("Please make sure the password you entered was correct and the account with email \(email) exists."),
                dismissButton: .default(Text("Okay"))
                
            )
        })
        
        .alert(isPresented: $isEmptyAlert, content: {
            Alert(
                title: Text("Uh Oh"),
                message: Text("Please make sure you fill in all the text fields before trying to sign in."),
                dismissButton: .default(Text("Okay"))
                
            )
        })
    }
}

