//
//  QuestionMaker.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI
import FirebaseFirestore
import Firebase


struct QuestionMaker: View {
    @State private var tempQuestion: String = ""
    @State private var tempAnswer: String = ""
    @State private var isEditable = true
    var body: some View {
        VStack {
            TextField("Question...", text: self.$tempQuestion.max(250))
                .disabled(!isEditable)
                .padding()
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                )

            TextField("Answer...", text: self.$tempAnswer.max(250))
                .disabled(!isEditable)
                .padding()
                .frame(height:50)
                .autocapitalization(.none)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                        
                        
                        
                )
        }
        .padding()
        Button {

            if isEditable == true {
                isEditable = false
                questions["\(tempQuestion)"] = "\(tempAnswer.lowercased())"
                print(questions)
            } else {
                questions.removeValue(forKey: tempQuestion)
                print(questions)
                isEditable = true
            }
            
        } label: {
            
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
        Spacer()
    }
}

struct QuestionMaker_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMaker()
    }
}
