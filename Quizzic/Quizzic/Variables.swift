//
//  Variables.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 10/7/2023.
//

import Foundation

// Dictionary that stores the questions as keys and answers as value.
var questions: [String: String] = [:]
var quizzesArray: [String] = []

// Variables to store user input and questions that are retrieved from firebase
var userAnswers: [String : String] = [:]
var actualQuestions: [String] = []
var nameOfCurrentQuiz = ""
