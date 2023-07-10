//
//  QuizzesView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

/* REMARK: @bucL
* Sounding like a broken record at this point
* but you have not commented your code, 
* likewise you are using firestore directly 
* in view code, rather than in your database
* object, which should handle all your database 
* functions.
*
*/

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
                                getQuizInfo(quizName: "\(quiz)")
                                nameOfCurrentQuiz = quiz
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
