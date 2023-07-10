//
//  DisplayQuestion.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 2/6/2023.
//

import SwiftUI


struct DisplayQuestion: View {
    let questionNumber: Int
    @State var isEditable = true
    @State var tempUserAnswer: String = ""
    var body: some View {
        VStack{
            TextField("Enter your answer", text: $tempUserAnswer)
                .padding()
                .disabled(!isEditable)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding() // Add padding to the text field
                .background(Color.gray.opacity(0.2)) // Set the background color
                .cornerRadius(8) // Add corner radius to the text field
                .padding(.horizontal) // Add horizontal padding
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Apply a rounded border style
                .frame(maxWidth:.infinity)
            Button {
                if isEditable == true {
                    isEditable = false
                    userAnswers[actualQuestions[questionNumber]] = tempUserAnswer.lowercased()
                    print(userAnswers)
                } else {
                    isEditable = true
                    userAnswers[actualQuestions[questionNumber]] = ""
                    print(userAnswers)
                }
                
            } label: {
                if isEditable == true {
                    Text("Save Answer")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .padding()
                        .offset(y: -25)
                } else {
                    Text("Edit Answer")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .padding()
                        .offset(y: -25)
                }
            }
        }
    }
}

