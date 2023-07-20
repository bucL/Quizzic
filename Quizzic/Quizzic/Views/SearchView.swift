//
//  SearchView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

import SwiftUI

struct SearchView: View {
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("uid") var userID: String  = ""
    
    // AppStorage variable that stores the current user's uid across restarts of the application to esnrue they stay logged in
    @AppStorage("username") var username: String = ""
    
    // State variables used to facilitate search. 
    @State var searchString: String  = "" //Used to store string the user searches for and subsequently passed to the searchArray function
    @State var searchResult: [String] = [] // Used to store the result of the searchArray function
    @State var navigate = false //Used to delay navigation and navigate to TakeQuiz. 
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Search for a Quiz")
                    .font(.title)
                    .padding()

                HStack {
                    // Horizontal stack to hold the search input field and search button.
                    TextField("Enter Quiz Name...", text: self.$searchString.max(100))
                        // Textfield to input the quiz name for search.
                        .autocapitalization(.none) // Disable auto-capitalization.
                        .autocorrectionDisabled(true) // Disable auto-correction.
                        .frame(height: 25)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                        )
                        .padding()
                    // Button to initiate the search.
                    Button {
                        searchResult = searchArray(searchTerm: searchString, array: quizzesArray)
                        // Call 'searchArray' function to get the search results
                        print(searchResult) // Print the search results array.
                    } label: {
                        // Button label with magnifying glass icon.
                        Image(systemName: "magnifyingglass") // Magnifying glass icon.
                            .frame(width: 25, height: 25) // Set the icon size.
                            .foregroundColor(Color.white) // Set the icon color to white.
                            .padding() // Add padding to the button.
                            .background(
                                RoundedRectangle(cornerRadius: 4) 
                                    .foregroundColor(Color.blue)
                            )
                            .padding(.trailing, 5)
                    }

                    Spacer() // Add a flexible space to push the button to the right.
                }

                Spacer()
                ScrollView {
                    // Scroll view to make content scrollable if it exceeds the screen size.
                    LazyVGrid(columns: createGrid()) {
                        // LazyVGrid arranges items in a grid with flexible columns.
                        // 'createGrid()' function creates grid items with specified layout.
                        ForEach(searchResult, id: \.self) { quiz in
                            // Iterate through each 'quiz' item in the search result 'searchResult' array to create clickable navigation links
                            NavigationLink(destination: TakeQuiz(navigateFromSearch: true), isActive: $navigate) {
                                // NavigationLink creates a link to 'TakeQuiz' view destination and sets the navigateFromSearch value to true to make sure that when the user completes the quiz they get redirected back to the SearchView
                                Button {
                                    // Button to handle quiz selection.
                                    nameOfCurrentQuiz = quiz
                                    // Set 'nameOfCurrentQuiz' to the selected quiz.
                                    getQuizInfo(quizName: "\(quiz)")
                                    // Call 'getQuizInfo' function to fetch quiz details.
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        // Use DispatchQueue to set navigate to true after a delay of 0.5s
                                        navigate = true
                                    }
                                } label: {
                                    // Button label with text representing the quiz name.
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
        .navigationBarBackButtonHidden(true)
       
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
