//
//  QuizCreator.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

import SwiftUI
import FirebaseFirestore


struct QuizCreator: View {
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    @State private var numberOfQuestions: Float = 0
    @State private var quizName: String = ""
    @State private var showAlert = false
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Create A Quiz")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Quiz Name", text: $quizName)
                    .bold()
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.black)
                    )
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
                
                ForEach (0..<Int(numberOfQuestions), id: \.self) {index in
                    VStack {
                        Text("Question \(index+1)")
                            .font(.title2)
                            .fontWeight(.light)
                            .padding()
                            .frame(alignment: .leading)
                        QuestionMaker()
                    }
                }

                
                Button {
                    if questions == [:] {
                        showAlert = true
                    } else {
                        let docData = questions
                        let db = Firestore.firestore()
                        
                        db.collection("quizzes").document("\(quizName)").setData(docData) { err in
                            if err != nil {
                                print("Error uploading quiz")
                            } else {
                                print("successfully uploaded to firebase")
                            }
                        }

                    }
                                        
                    
                } label: {
                    Text("Save Quiz")
                        .alert("Please create a question before trying to save the quiz", isPresented: $showAlert) {
                            Button("Okay!", role: .cancel) {}
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .padding()
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
