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

/* REMARK @bucL
* Overall comment
* What is the purpose of this file? Have you actually thought about how 
* your project should be structured? I would recommend that you have 
* logic in a separate file and your storage (models) placed in a different place.
* Currently you seem to have a bunch of logic in this file, and it also 
* stores data about what a quiz or question is. 
*
* I would separate a quiz and a question out into separate files. 
* I would then have a separate file for the logic in the quiz screen
* Likewise, I would also want to separate out the database logic into 
* an OBSERVABLE object, that way when the database updates,
* your UI can update automatically
*
* Furthermore, your commenting is fairly bare bones.
* You need to make sure you are explaining your logic and your 
* decisions. you should also explain your variables, as they 
* are a decision that you have made. 
*
* You should use a docstring for your functions. I have provided
* an example for your first function, notice how it is displayed in
* XCode.
*
*/

// Dictionary that stores the questions as keys and answers as value.
var questions: [String: String] = [:]
var quizzesArray: [String] = []
var quizzesArrayLength = 0

//these may or may not be needed depedning on how the navigation view implementation goes ahead in TakeQuiz.swift
// Variables to store user input and questions that are retrieved from firebase
var userAnswers: [String : String] = [:]
var actualQuestions: [String] = []
var questionsCount: Int = 0
var nameOfCurrentQuiz = ""

/**
 Retrieves the name of a quiz from firebase.

 - Parameter NONE

 - Throws: `MyError.FIREBASEERROR`
           if `recipient` is "Derek"
           (he knows what he did).

 - Returns: NONE 
            (Modifies quizzesArray 
            in a global state)
 */
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
            //This line may be causing issues needs to be traced back
            questionsCount += 1
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

// Gets questions dictionary from Firebase
func getQuizInfo(quizName: String) {
    questions = [:]
    actualQuestions = []
    questionsCount = 0
    let db = Firestore.firestore()
    let quizReference = db.collection("quizzes").document("\(quizName)")
    quizReference.getDocument { (document, error) in
        if let document = document, document.exists {
            if let data = document.data() {
                for (key, value) in data {
                    questions[key] = (value as! String)
                    actualQuestions.append(key)
                    questionsCount += 1
                }
                print(questions)
                print(questionsCount)
                print(actualQuestions)
            }
        } else {
            print("quiz doesn't exist")
        }
    }
}
