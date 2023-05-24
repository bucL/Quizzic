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
        
        VStack {
            
            Text("Choose A Quiz")
                .font(.title)
                .bold()
            
            
            
            
            ScrollView{
                LazyVGrid (columns: createGrid()){
                    ForEach(quizzesArray, id:\.self) { quiz in
                        // doesn't acutally navigate to the new view.
                        NavigationLink (destination: TakeQuiz(), isActive: $navigate) {
                            Button {
                                getQuizInfo(quizName: "\(quiz)")
                                navigate = true
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
        }
        
    }
}

struct QuizzesView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesView()
    }
}
