//
//  TakeQuiz.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI

//this curerntly fails due to some unknown/undefined error. need to consider if not utilising a navigatiion view is the best option here and simply have another view that is enabled when you click a button that updates a boolean value.
struct TakeQuiz: View {
    var body: some View {
        NavigationView{
                VStack {
                    ForEach(0..<questionsCount+1, id: \.self) { number in
                   
                        Text("\(actualQuestions[number])")
                    }
                }
            } .navigationBarBackButtonHidden(true)
            
            
        }
       
        
    }
    


struct TakeQuiz_Previews: PreviewProvider {
    static var previews: some View {
        TakeQuiz()
    }
}
