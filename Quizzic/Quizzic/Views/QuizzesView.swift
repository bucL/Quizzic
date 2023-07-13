//
//  QuizzesView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//
import SwiftUI
import FirebaseFirestore


var currentQuiz: String = ""

struct QuizzesView: View {
    @State private var navigate = false
    
    
    var body: some View {
        if navigate == false {
            VStack {
                Text("Choose A Quiz")
                    .font(.title)
                    .bold()
                
                ScrollView{
                    LazyVGrid (columns: createGrid()){
                        ForEach(quizzesArray, id:\.self) { quiz in
                            Button {
                                nameOfCurrentQuiz = quiz
                                getQuizInfo(quizName: "\(quiz)")
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                    navigate = true
                                }
                                
                            } label: {
                                Text("\(quiz)")
                                    .frame(width: 100, height: 100)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
        } else {
            TakeQuiz()
                .onAppear {
                    // Resets the userAnswers dictionary each time the TakeQuiz View is updated to prevent answers from being collected across different quiz attempts. 
                    userAnswers = [:]
                }
        }
    }
}

struct QuizzesView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesView()
    }
}
