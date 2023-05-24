//
//  Question.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

// Dictionary that creates 
var questions: [String: String] = [:]
var quizzesArray: [String] = []
var quizzesArrayLength = 0


// Function to retrive the names of quizzes from Firebase
func getQuizNames() {
    let db = Firestore.firestore()
    let collectionReference = db.collection("quizzes")
    quizzesArray = []
    quizzesArrayLength = 0
    
    collectionReference.getDocuments { (snapshot, error) in
        if let error = error {
            print("error getting documents: \(error)")
            return
        }
        
        guard let documents = snapshot?.documents else {
            print("No quizzes exist")
            return
        }
        
        for document in documents {
            quizzesArrayLength = quizzesArrayLength + 1
            let documentName = document.documentID
            quizzesArray.append(documentName)
            print("Document name: \(documentName)")
            print(quizzesArray)
        }
        
        print(quizzesArrayLength)
    }
}


// Creates GridItems for the LazyVGrid in QuizzesView.swift
func createGrid() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 10)
    return Array(repeating: gridItem, count: 3)
}
