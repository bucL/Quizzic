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
