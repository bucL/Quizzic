//
//  QuizCreator.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

import SwiftUI

struct QuizCreator: View {
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    @State private var numberOfQuestions: Float = 0
    @State private var question = [String]()
//    @State private var question = ""
//    @State private var option1 = ""
//    @State private var option2 = ""
//    @State private var option3 = ""
//    @State private var answer = ""
    var body: some View {
        ScrollView{
            VStack {
                Text("Create A Quiz")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                
                // Need feedback/advice from the class on how to continue from this stage and what my users would prefer. A scrollview where the user sets a number of questions that they want and keeps scrolling to find new boxes to fill or a navigationstyle view thing where they want buttons that take them to the next question. In terms of implementation a scrollview will be easier
                Text("Specify a number of questions: \(Int(numberOfQuestions))")
                Slider(value: $numberOfQuestions, in: 0...20, step: 1)
                     {
                    Text("Slider")
                }   minimumValueLabel:  {
                    Text("0")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding()
                }   maximumValueLabel: {
                    Text("20")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding()
                }
                
                ForEach (1..<Int(numberOfQuestions)+1, id: \.self) {index in
                     Text("question \(index)")
//                    VStack {
//                        TextField("Question...", text: $question[index])
//                        TextField("Option 1...", text: $option1)
//                        TextField("Option 2...", text: $option2)
//                        TextField("Option 3...", text: $option3)
//                        TextField("Answer...", text: $answer)
//
//                    }
                    
                    
                }
                    
                    
                    
                
                
            }
            
            
        }
    }
}
    struct QuizCreator_Previews: PreviewProvider {
        static var previews: some View {
            QuizCreator()
        }
    }
