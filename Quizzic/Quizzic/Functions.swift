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



/**
Retrieves the names of quizzes from Firestore and populates the `quizzesArray`.
 - Parameter NONE
 - Returns: NONE
            (Modifies quizzesArray 
            in a global state)
 */

func getQuizNames() {
    let db = Firestore.firestore()
    let collectionReference = db.collection("quizzes")
    
    quizzesArray = []   // Clear the quizzesArray
    
    // Retrieve the documents from the "quizzes" collection in Firestore
    collectionReference.getDocuments { (snapshot, error) in
        if let error = error {
            print("Error getting documents: \(error)")   // Print an error message if there's an error
            return
        }
        
        guard let documents = snapshot?.documents else {
            print("No quizzes exist")   // Print a message if no documents exist
            return
        }
        
        // Loop through the retrieved documents
        for document in documents {
            let documentName = document.documentID
            quizzesArray.append(documentName)   // Append the document name to the quizzesArray
            print("Document name: \(documentName)")   // Print the document name
            print(quizzesArray)   // Print the updated quizzesArray
        }
    }
}



// Creates GridItems for the LazyVGrid in QuizzesView.swift
func createGrid() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 10)
    return Array(repeating: gridItem, count: 3)
}

/// Retrieves quiz information from Firestore based on the provided quiz name.
/// - Parameters:
///   - quizName: The name of the quiz to retrieve.
/// - Returns:
///     - NONE. Updates global variables "questions", "actualQuestions" and "nameOfCurrentQuiz
func getQuizInfo(quizName: String) {
    questions = [:]                 // Clear the questions dictionary
    actualQuestions = []            // Clear the actualQuestions array
    nameOfCurrentQuiz = quizName    // Set the nameOfCurrentQuiz
    
    let db = Firestore.firestore()
    let quizReference = db.collection("quizzes").document("\(quizName)")
    
    // Retrieve the quiz document from Firestore
    quizReference.getDocument { (document, error) in
        if let document = document, document.exists {
            // Check if the document exists and retrieve its data
            if let data = document.data() {
                // Loop through the data and populate the questions dictionary and actualQuestions array
                for (key, value) in data {
                    questions[key] = (value as! String)
                    actualQuestions.append(key)
                }
                print(questions)            // Print the populated questions dictionary
                print(actualQuestions)     // Print the populated actualQuestions array
            }
        } else {
            print("quiz doesn't exist")    // Print a message if the quiz document doesn't exist
        }
    }
}


/**
    Compares two dictionaries and returns a string indicating the number of correct matches.

    - Parameters:
        - quiz: The original quiz dictionary which stores the questions and answers as key-value pairs that were defined at the time of its creation.
        - userInput: The user's answers matched with the question they answered as key-value pairs. The keys are identical with "quiz".

    - Returns:
        A string indicating the number of correct matches out of the total number of questions.
*/
func markQuiz(quiz: [String: String], userInput: [String: String]) -> String {
    var correctCount = 0 // Variable to keep track of the number of correct matches
    
    // Iterate over the keys and values of the first dictionary
    for (key, _) in quiz {
        if quiz[key] == userInput[key] {
            // Check if the values match
            correctCount += 1 // Increment correctCount when a match is found
        }
    }
    let totalCount = quiz.count // Total number of key-value pairs in the dictionaries
    let resultString = "Congratulations, you got \(correctCount) out of \(totalCount) questions correct."
    
    return resultString // Return the resulting string
}
