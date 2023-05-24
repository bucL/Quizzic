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
    var body: some View {
        VStack {
            TextField("Question...", text:$tempQuestion)
                .padding()
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                )

            TextField("Answer...", text:$tempAnswer)
                .padding()
                .frame(height:50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.black)
                        
                        
                        
                )
        }
        .padding()
        
        Button {
            // Bug when attempting to edit questions it adds another key-value pair instead of properly changing the previous question. 
            questions["\(tempQuestion)"] = "\(tempAnswer)"
            print(questions)
        } label: {
            Text("Save Question")
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .padding()
        }
        
        Spacer()
    }
}

struct QuestionMaker_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMaker()
    }
}
