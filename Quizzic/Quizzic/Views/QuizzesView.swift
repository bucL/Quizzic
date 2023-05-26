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
                            // doesn't acutally navigate to the new view.
                            Button {
                                getQuizInfo(quizName: "\(quiz)")
                                // Scrappy solution to the next screen from being empty as by adding a delay we can ensure that firebase has enough time to retrieve the data. Plans to implement better solution in the future that updates the view when the array of questions is not empty ie != nil.
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                    navigate = true
                                }
                                
                            }label: {
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
        }
    }
}

struct QuizzesView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesView()
    }
}
