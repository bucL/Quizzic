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

var view: String?

@main
struct QuizzicApp: App {

    
    init() {
        FirebaseApp.configure()     //Firebase initialised
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
