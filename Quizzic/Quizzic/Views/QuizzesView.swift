//
//  QuizzesView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//
import SwiftUI
import FirebaseFirestore

/**
 A view displaying a list of quizzes for the user to choose from.
 This view allows the user to select a quiz from the list, and upon selection, it navigates to the TakeQuiz view for the selected quiz.
 */
struct QuizzesView: View {
    // State property to control navigation to the TakeQuiz view
    @State private var navigate = false

    var body: some View {
        // Check the navigation state to display either the list of quizzes or the TakeQuiz view
        if navigate == false {
            VStack {
                // Title and header of the quiz selection view
                Text("Choose A Quiz")
                    .font(.title)
                    .bold()

                // ScrollView to display the list of quizzes in a LazyVGrid
                ScrollView {
                    LazyVGrid(columns: createGrid()) {
                        // Loop over the quizzesArray to display each quiz as a button
                        ForEach(quizzesArray, id: \.self) { quiz in
                            Button {
                                // When a quiz is selected, set `nameOfCurrentQuiz` to the quiz name
                                nameOfCurrentQuiz = quiz

                                // Call the `getQuizInfo()` function to retrieve the quiz information
                                getQuizInfo(quizName: "\(quiz)")

                                // After a short delay, set `navigate` to true to trigger navigation to the TakeQuiz view
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigate = true
                                }
                            } label: {
                                // Display the quiz name as a button with blue background and white text
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
            // Navigate to the TakeQuiz view when `navigate` is true
            TakeQuiz()
                .onAppear {
                    // Reset the `userAnswers` dictionary each time the TakeQuiz view appears
                    // This prevents answers from being carried over across different quiz attempts
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
