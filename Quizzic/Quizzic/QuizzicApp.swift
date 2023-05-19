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


var view: String?

@main
struct YourApp: App {

    
    init() {
        FirebaseApp.configure()     //Firebase initialised
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
