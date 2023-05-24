//
//  QuizzesView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI
import FirebaseFirestore

struct QuizzesView: View {
    var body: some View {
        
        VStack {
            
            Text("Choose A Quiz")
            
            ScrollView{
                LazyVGrid (columns: createGrid()){
                    ForEach(quizzesArray, id:\.self) { quiz in
                        Text("\(quiz)")
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
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
