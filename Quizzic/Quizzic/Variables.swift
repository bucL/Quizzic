//
//  Variables.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 10/7/2023.
//

import Foundation

// Dictionary Variable that  stores the questions and asnwers as a key-value pair.
var questions: [String: String] = [:]

// Array variable that stores a list of all the currently existing quiz names.
var quizzesArray: [String] = []

// Dicitonary Variable to store the user's answers when they are taking a quiz as key value pair with eahc key being a question and each value being the user's answer for that specific question.
var userAnswers: [String : String] = [:]

// Array variable that stores a list of questions for the current quiz
var actualQuestions: [String] = []

// Variable that stores the name of the current quiz when a user is taking a quiz. 
var nameOfCurrentQuiz = ""
