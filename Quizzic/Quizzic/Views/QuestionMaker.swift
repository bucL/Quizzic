//
//  QuestionMaker.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI
import FirebaseFirestore
import Firebase


/**
 A view for creating and editing a single question which can be used in a ForEach loop to be multiplied for a specified number of questions.
 This view allows the user to enter a question and its corresponding answer. The user can toggle between "editable" and "non-editable" states to save or edit the question in the `questions` dictionary.
 */
struct QuestionMaker: View {
    // State properties to hold the temporary question and answer entered by the user
    @State private var tempQuestion: String = ""
    @State private var tempAnswer: String = ""
    
    // State property to control the editable state of the view
    @State private var isEditable = true

    var body: some View {
        VStack {
            // TextField for entering the question
            TextField("Question...", text: self.$tempQuestion.max(250))
                .disabled(!isEditable) // Disable the TextField when not in the editable state
                .padding()
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                )

            // TextField for entering the answer
            TextField("Answer...", text: self.$tempAnswer.max(250))
                .disabled(!isEditable) // Disable the TextField when not in the editable state
                .padding()
                .frame(height: 50)
                .autocapitalization(.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                )
        }
        .padding()

        // Button for saving or editing the question based on the `isEditable` state
        Button {
            // Toggle between editable and non-editable states
            if isEditable == true {
                isEditable = false
                questions["\(tempQuestion)"] = "\(tempAnswer.lowercased())" // Save the question and its answer to the `questions` dictionary
                print(questions) // Print the updated `questions` dictionary for debugging purposes
            } else {
                questions.removeValue(forKey: tempQuestion) // Remove the question from the `questions` dictionary when editing
                print(questions) // Print the updated `questions` dictionary for debugging purposes
                isEditable = true
            }
            
        } label: {
            // Show "Save Question" label when in the editable state, otherwise show "Edit Question" label
            if isEditable == true {
                Text("Save Question")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
                    .padding()
                    .offset(y: -25)
            } else {
                Text("Edit Question")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
                    .padding()
                    .offset(y: -25)
            }
        }
        Spacer() // Spacer to push the content to the top and center it vertically
    }
}


struct QuestionMaker_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMaker()
    }
}
