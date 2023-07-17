//
//  TakeQuiz.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI
struct TakeQuiz: View {
    @State private var completedQuiz = false  // State variable to track if the quiz is completed
    @State var showAlert = false  // State variable to show an alert
    @State var result = ""  // State variable to store the result
    
    var body: some View {
        if completedQuiz == false {  // Check if the quiz is not completed
            VStack {
                Text("\(nameOfCurrentQuiz)")  // Display the name of the current quiz
                    .font(.title2)
                    .padding()
                Text("Please remember to click the save button after answering each question")  // Reminder message
                    .padding()
                Spacer()
                
                ScrollView{
                    VStack{
                        ForEach(0...actualQuestions.count-1, id:\.self) { index in
                            VStack{
                                Text("\(actualQuestions[index])")  // Display the question
                                    .font(.headline)
                                    .fontWeight(.bold) // Set the font weight
                                    .foregroundColor(.white) // Set the text color
                                    .multilineTextAlignment(.center) // Set the text alignment
                                    .padding() // Add padding to the text view
                                    .background(Color.blue) // Set the background color
                                    .cornerRadius(10) // Add corner radius to the text view
                                    .shadow(color: .gray, radius: 5, x: 0, y: 2) // Add a shadow to the text view
                                    .frame(maxWidth:.infinity)
                                DisplayQuestion(questionNumber: index)  // Display the question and answer options
                                    .padding()
                            }
                            .padding()
                        }
                    }
                }
                Spacer()
                Button(action: {
                    if userAnswers.count != actualQuestions.count {
                        showAlert = true  // Show an alert if not all questions are answered
                    } else{
                        result = markQuiz(quiz: questions, userInput: userAnswers)  // Call the markQuiz funciton and calculate the users score.
                        completedQuiz = true  // Set the quiz as completed to update the view.
                    }
                    
                }) {
                    Text("Submit")  // Button to submit the quiz
                        .font(.headline)
                        .foregroundColor(.white) // Set the text color to white
                        .padding() // Add padding to the button
                        .background(Color.green) // Set the background color to green
                        .cornerRadius(10) // Add corner radius to the button
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .alert("Please make sure you have saved all your answers before submitting the quiz", isPresented: $showAlert) {
                Button("Okay!", role: .cancel) {}
            }
        }
        else {
            NavigationView {
                VStack {
                    Text("Congratulations!")  // Display a congratulatory message
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Text("You have completed the quiz \(nameOfCurrentQuiz).")  // Display completion message
                        .font(.headline)
                        .padding()
                    Text(result)  // Display the result
                        .font(.headline)
                        .padding()
                    Spacer()
                    NavigationLink(destination: Homescreen(), label: {
                        Text("Go Back")  // Navigation link to go back to the homescreen
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.green))
                    })
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct TakeQuiz_Previews: PreviewProvider {
    static var previews: some View {
        TakeQuiz()
    }
}
