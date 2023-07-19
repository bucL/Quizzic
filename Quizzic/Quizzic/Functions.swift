//
//  Functions.swift
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



/// Creates an array of GridItems for use in a SwiftUI grid view.
/// The grid layout consists of flexible-sized items with a fixed spacing between them.
/// - Parameters:
///     - NONE
/// - Returns: An array of GridItems with a flexible size and a fixed spacing.
func createGrid() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 10)  // Create a single GridItem with flexible size and spacing of 10
    return Array(repeating: gridItem, count: 3)        // Return an array of GridItems, repeating the single GridItem 3 times
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
    let resultString = "You got \(correctCount) out of \(totalCount) questions correct."
    
    return resultString // Return the resulting string
}

/// Searches an array of quizzes for the specified quizname and returns an array with all the quizzes that contain the specific searchterm.
/// of strings containing the elements where the search term is found.
/// - Parameters:
///   - searchTerm: The search term to look for within the array of quizNames.
///   - array: The array of quizNames to be searched.
/// - Returns: An array of strings containing the elements where the search term is found.
func searchArray(searchTerm: String, array: [String]) -> [String] {
    var foundElements: [String] = []   // Array to store the found elements
    
    for element in array {
        if element.lowercased().contains(searchTerm.lowercased()) {
            foundElements.append(element)   // Append the element to the foundElements array
        }
    }
    
    return foundElements   // Return the array of found elements
}

/// Checks if a quiz exists in an array of strings.
/// - Parameters:
///   - searchString: The quizname to check for.
///   - array: The array of quizzes to search in.
/// - Returns: A Boolean value indicating whether the quiz exists in the array of quiz names. .
func checkQuizExists(searchString: String, array: [String]) -> Bool {
    for element in array {
        if element == searchString {
            return true   // The quiz exists
        }
    }
    return false   // The quiz does not exist
}


/// Setting a maxlength for a textfield solution acquired from https://stackoverflow.com/a/68167518
extension Binding where Value == String {
    /// Limits the maximum number of characters that can be entered into a `TextField`.
    /// If the current string value exceeds the specified limit, the extra characters are automatically removed.
    /// - Parameters:
    ///    - limit: The maximum character limit.
    /// - Returns: The modified `Binding` with the maximum character limit applied.
    func max(_ limit: Int) -> Self {
        // Check if the current string length exceeds the specified limit
        if self.wrappedValue.count > limit {
            // Asynchronously update the string value to remove the extra characters
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}

/**
    A  helper function to check if a password matches the specified criteria.
     
    - Parameters:
        - password: The password string to be validated.
     
    - Returns:
        A Boolean value indicating whether the password is valid or not. `true` if the password meets the criteria, otherwise `false`.
*/
func isValidPassword(_ password: String) -> Bool {
    // Regular expression to validate the password format:
    // - Minimum 6 characters
    // - At least 1 lowercase letter
    // - At least 1 uppercase letter
    // - At least 1 special character (e.g., $, @, #, !, %, *, ?, &)
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    
    // Evaluate the password against the regular expression and return the result.
    return passwordRegex.evaluate(with: password)
}
