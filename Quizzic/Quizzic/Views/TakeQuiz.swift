//
//  TakeQuiz.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI

//this curerntly fails due to some unknown/undefined error. need to consider if not utilising a navigatiion view is the best option here and simply have another view that is enabled when you click a button that updates a boolean value.

//Above issue has been solved and program no longer crashes or displays 0.


struct TakeQuiz: View {
    var body: some View {
        VStack {
            
            Text("\(nameOfCurrentQuiz)")
                .font(.title2)
                .padding()
            Text("Please remember to click the save button after answering each question")
            Spacer()
            
            ScrollView{
                VStack{
                    
                    ForEach(actualQuestions, id:\.self) { actualQuestion in
                        VStack{
                            Text("\(actualQuestion)")
                                
                            // Need to do something similar to the QuestionMaker in order to fix the multiple textboes being the same.
                            DisplayQuestion()
                            
                        }
                        .onAppear {
                            QuestionManager.shared.actualQuestion = actualQuestion
                        }
                    }
                    
                    
                }
            }
        }
        
        
        Spacer()
        Button {
            print(userAnswers)
        } label: {
            Text("submit quiz")
        }
        
    }
}


struct TakeQuiz_Previews: PreviewProvider {
    static var previews: some View {
        TakeQuiz()
    }
}
