//
//  DisplayQuestion.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 2/6/2023.
//

import SwiftUI


struct DisplayQuestion: View {
    @State var isEditable = true
    @State var tempUserAnswer: String = ""
    var body: some View {
        VStack{
            TextField("Enter your answer", text: $tempUserAnswer)
                .padding()
                .disabled(!isEditable)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            Button {
                if isEditable == true {
                    isEditable = false
                    userAnswers[QuestionManager.shared.actualQuestion] = tempUserAnswer
                    
                } else {
                    userAnswers.removeValue(forKey: QuestionManager.shared.actualQuestion)
                    print(userAnswers)
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
        }
    }
}

struct DisplayQuestion_Previews: PreviewProvider {
    static var previews: some View {
        DisplayQuestion()
    }
}
