//
//  SignUpView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//
/**
 A SwiftUI view for creating a new account.
 This view allows the user to create a new account by providing their email, password, and username. It utilizes Firebase authentication to create the account and stores user data in the Firestore database if the provided information is valid.
 */

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    // Binding used to change between the SignUp and Login Views.
    @Binding var currentView: String
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("uid") var userID: String  = ""
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("username") var username: String = ""
    
    // Variables used to facilitate the use of TextField's and secure fields as well as the isValidPassword and Firebase Functions to create a new user account and set the username for a specific user uid.
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var newusername: String = ""
    
    // Variables used to determine if an error needs to be displayed.
    @State var incorrectPassword = false
    @State private var isEmptyAlert = false
    @State var emailInvalid = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Set the background color of the view to black and ignore the safe area edges.
            
            VStack {
                HStack{
                    Text("Create An Account")
                        .font(.largeTitle)
                        .foregroundColor(.white) // Set the text color to white
                        .bold() // Make the text bold
                    
                    Spacer() // Create a flexible space to push the text to the left side.
                }
                .padding() // Add padding to the HStack
                .padding(.top) // Add additional padding at the top of the HStack
                
                Spacer() // Create a flexible space to push the content to the top.
                
                HStack {
                    Image(systemName: "mail") // Add an image to the HStack
                    TextField("Email", text: self.$email.max(100))
                        .autocapitalization(.none) // Disable auto-capitalization
                        .autocorrectionDisabled(true) // Disable auto-correction
                    
                    Spacer() // Create a flexible space to push the text field to the left.
                    
                    if email.count != 0 {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark") // Show a checkmark or an "x" based on whether the email is valid or not.
                            .fontWeight(.bold) // Make the checkmark or "x" bold
                            .foregroundColor(email.isValidEmail() ? .green : .red) // Set the color of the checkmark or "x" based on its validity
                        
                    }
                }
                .foregroundColor(.white) // Set the text color of the HStack to white
                .padding() // Add padding to the HStack
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Add a rounded rectangle overlay
                        .stroke(lineWidth: 2) // Set the stroke width of the overlay to 2
                        .foregroundColor(.white) // Set the color of the overlay to white
                )
                .padding() // Add additional padding to the HStack
                
                HStack {
                    Image(systemName: "lock") // Add an image to the HStack
                    SecureField("Password", text: self.$password.max(35))
                        .autocapitalization(.none) // Disable auto-capitalization
                        .autocorrectionDisabled(true) // Disable auto-correction
                    Spacer() // Create a flexible space to push the secure field to the left.
                    
                    if password.count != 0 {
                        
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark") // Show a checkmark or an "x" based on whether the password is valid or not.
                            .fontWeight(.bold) // Make the checkmark or "x" bold
                            .foregroundColor(isValidPassword(password) ?  .green : .red) // Set the color of the checkmark or "x" based on its validity
                    }
                    
                }
                /**
                 Shows an alert when the user enters an invalid email address when attempting to create an account.
                 This alert is presented when the user attempts to create an account when the email is badly formatted.
                 */
                .alert("Please make sure that email address: \(email) is a valid email address", isPresented: $emailInvalid) {
                    Button("Okay!", role: .cancel) {}
                }
                .foregroundColor(.white) // Set the text color of the HStack to white
                .padding() // Add padding to the HStack
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Add a rounded rectangle overlay
                        .stroke(lineWidth: 2) // Set the stroke width of the overlay to 2
                        .foregroundColor(.white) // Set the color of the overlay to white
                )
                
                .padding() // Add additional padding to the HStack
                
                HStack {
                    Image(systemName: "person") // Add an image to the HStack
                    TextField("Username", text: self.$newusername.max(40))
                        .autocapitalization(.none) // Disable auto-capitalization
                        .autocorrectionDisabled() // Disable auto-correction
                    
                    Spacer() // Create a flexible space to push the text field to the left.
                }
                /**
                 Shows an alert when the user enters an incorrect password format during account creation.
                 This alert is presented when the user's password does not meet the specified requirements, which are a minimum of 6 characters, at least 1 uppercase character, and at least 1 symbol.
                 */
                .alert(isPresented: $incorrectPassword, content: {
                    Alert(
                        title: Text("Uh Oh"),
                        message: Text("Please make sure the password you entered is a minimum of 6 characters long and has at least 1 uppercase character and 1 symbol."),
                        dismissButton: .default(Text("Okay"))
                    )
                })
                .foregroundColor(.white) // Set the text color of the HStack to white
                .padding() // Add padding to the HStack
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Add a rounded rectangle overlay
                        .stroke(lineWidth: 2) // Set the stroke width of the overlay to 2
                        .foregroundColor(.white) // Set the color of the overlay to white
                )
                
                .padding() // Add additional padding to the HStack
                
                Button(action: {
                    
                    withAnimation() {
                        self.currentView = "login" // Change the current view to the login screen using animation.
                    }
                    
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.gray) // Set the text color to gray.
                }
                
                
                Spacer() // Create a flexible space to push the content to the top.
                Spacer() // Create a flexible space to push the content to the top.
                
                Button {
                    if email.isEmpty || password.isEmpty || newusername.isEmpty {
                        isEmptyAlert = true // Show an alert if any of the fields are empty.
                    } else {
                        if isValidPassword(password) == true { // Check if the password is valid using the `isValidPassword` function.
                            /**
                             Create a new user account using Firebase Authentication and store user data in Firestore.
                             
                             This function uses Firebase Authentication to create a new user account with the provided email and password. If successful, it saves the UID of the created user to the `userID` variable and stores user data, including email and username, in the Firestore database.
                             
                             - Parameters:
                             - email: The email address of the new user.
                             - password: The password of the new user.
                             - newusername: The desired username of the new user.
                             - Returns: None. The function handles user account creation and data storage asynchronously.
                             */
                            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                if let error = error {
                                    print(error) // Print any error that occurs during account creation.
                                    emailInvalid = true
                                    return
                                }
                                if let authResult = authResult {
                                    print(authResult.user.uid) // Print the UID of the created user.
                                    userID = authResult.user.uid // Save the UID of the created user to the `userID` variable.
                                    let db = Firestore.firestore() // Create a Firestore database reference.
                                    db.collection("users").document("\(userID)").setData([ // Write Data to firestore making sure that the email and username of the user are set to the entered data.
                                        "email": "\(email)",
                                        "username": "\(newusername)"
                                    ]) { err in
                                        if let err = err {
                                            print("Error writing document: \(err)") // Print any error that occurs while writing the user data to Firestore.
                                        } else {
                                            print("Document successfully written!") // Print a success message after successfully writing the user data to Firestore.
                                            }
                                    }
                                    username = newusername // Save the new username to the `username` variable.
                                }
                            }
                            
                        } else {
                            incorrectPassword = true // Show an alert if the password does not meet the specified criteria.
                        }
                    }
                } label: {
                    Text("Create Account")
                        .foregroundColor(.black) // Set the text color to black.
                        .font(.title3) // Set the font size to title3.
                        .bold() // Make the text bold.
                        .frame(maxWidth: .infinity) // Set the frame width to fill the available space.
                        .padding() // Add padding to the button.
                        .background (
                            RoundedRectangle(cornerRadius: 10) // Add a rounded rectangle background to the button.
                                .fill(Color.white) // Set the background color to white.
                        )
                        .padding(.horizontal) // Add horizontal padding to the button.
                }
            }
        }
        

        /**
         Shows an alert when the user leaves any text fields empty during account creation.
         This alert is presented when the user attempts to create an account without filling in all the required text fields (email, password, and username).
         */
        .alert(isPresented: $isEmptyAlert, content: {
            Alert(
                title: Text("Uh Oh"),
                message: Text("Please make sure you fill in all the text fields before trying to create a new account."),
                dismissButton: .default(Text("Okay"))
            )
        })

    }
}
