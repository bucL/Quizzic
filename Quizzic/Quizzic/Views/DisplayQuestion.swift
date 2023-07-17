//
//  DisplayQuestion.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 2/6/2023.
//

import SwiftUI


struct DisplayQuestion: View {
    let questionNumber: Int  // The question number
    @State var isEditable = true  // State variable to track editability
    @State var tempUserAnswer: String = ""  // State variable to store the user's answer
    
    var body: some View {
        VStack {
            TextField("Enter your answer", text: self.$tempUserAnswer.max(250))  // TextField for user input with a maximum length of 250 characters.
                .padding()
                .disabled(!isEditable)  // Disable the TextField based on the isEditable state
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))  // Set the background color
                .cornerRadius(8)  // Add corner radius to the text field
                .padding(.horizontal)  // Add horizontal padding
                .textFieldStyle(RoundedBorderTextFieldStyle())  // Apply a rounded border style
                .frame(maxWidth:.infinity)  // Set the TextField width to maximum
                
            Button {
                if isEditable == true {
                    isEditable = false
                    userAnswers[actualQuestions[questionNumber]] = tempUserAnswer.lowercased() // Update the UserAnswers dictionary with the user's input
                    print(userAnswers)  // Print the updated userAnswers dictionary
                } else {
                    isEditable = true
                    userAnswers[actualQuestions[questionNumber]] = "" // Reset the user's input for a specific question when they decide to edit their answer. 
                    print(userAnswers)  // Print the updated userAnswers dictionary
                }
            } label: {
                if isEditable == true {
                    Text("Save Answer")  // Display the label "Save Answer"
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)  // Set the button's background color to red
                        .clipShape(RoundedRectangle(cornerRadius: 10))  // Apply a rounded rectangle shape to the button
                        .foregroundColor(.white)  // Set the text color to white
                        .padding()  // Add padding to the button content
                        .offset(y: -25)  // Offset the button vertically
                } else {
                    Text("Edit Answer")  // Display the label "Edit Answer"
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)  // Set the button's background color to red
                        .clipShape(RoundedRectangle(cornerRadius: 10))  // Apply a rounded rectangle shape to the button
                        .foregroundColor(.white)  // Set the text color to white
                        .padding()  // Add padding to the button content
                        .offset(y: -25)  // Offset the button vertically
                }
            }

        }
    }
}


