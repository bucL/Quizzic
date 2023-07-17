//
//  SearchView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

import SwiftUI

struct SearchView: View {
    
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    @State var searchString: String  = ""
    @State var searchResult: [String] = []
    @State var displayResult: Bool = false
    
    var body: some View {
        VStack {
            Text("Search for a Quiz")
                .font(.title)
                .padding()
                HStack {
                    TextField("Enter Quiz Name...", text: self.$searchString.max(100))
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .frame(height: 25)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    )
                    .padding()
                Button {
                    searchResult = searchArray(searchTerm: searchString, array: quizzesArray)
                    print(searchResult)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color.blue)
                        )
                        .padding(.trailing, 5)
                }
                Spacer()
            }
            Spacer()
            ScrollView {
                LazyVGrid (columns: createGrid()){
                    ForEach(searchResult, id:\.self) { quiz in
                        Button {
                            nameOfCurrentQuiz = quiz
                            getQuizInfo(quizName: "\(quiz)")
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
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
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
