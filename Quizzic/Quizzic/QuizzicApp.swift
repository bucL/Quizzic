//
//  QuizzicApp.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/3/2023.
//

import SwiftUI
import UIKit
import FirebaseCore
import FirebaseFirestore

/* REMARK @bucL
* What is this variable? 
*
* Can you comment your firebase initialisation better. 
* I understand why you are using Init, but why are you
* Configuring it here, and why no other elements of your 
* app?
*
*/

@main
struct QuizzicApp: App {
    init() {
        /// Initialising the Firebase API to facilitate the use of firebase functions such as firestore and auth which allow for the storing of quizzes on a database online and user management through firebase.
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()   // Set the start point of the Application to the Content View
        }
    }
}
