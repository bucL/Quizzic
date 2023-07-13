//
//  TakeQuiz.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 24/5/2023.
//

import SwiftUI
struct TakeQuiz: View {
    
    @State private var completedQuiz = false
    @State var showAlert = false
    @State var result = ""
    
    
    var body: some View {
        if completedQuiz == false {
            VStack {
                
                Text("\(nameOfCurrentQuiz)")
                    .font(.title2)
                    .padding()
                Text("Please remember to click the save button after answering each question")
                    .padding()
                Spacer()
                
                ScrollView{
                    VStack{
                        
                        ForEach(0...actualQuestions.count-1, id:\.self) { index in
                            VStack{
                                Text("\(actualQuestions[index])")
                                    .font(.headline)
                                    .fontWeight(.bold) // Set the font weight
                                    .foregroundColor(.white) // Set the text color
                                    .multilineTextAlignment(.center) // Set the text alignment
                                    .padding() // Add padding to the text view
                                    .background(Color.blue) // Set the background color
                                    .cornerRadius(10) // Add corner radius to the text view
                                    .shadow(color: .gray, radius: 5, x: 0, y: 2) // Add a shadow to the text view
                                    .frame(maxWidth:.infinity)
                                DisplayQuestion(questionNumber: index)
                                    .padding()
                            }
                        }
                    }
                    
                }
                Spacer()
                Button(action: {
                    if userAnswers.count != actualQuestions.count {
                        showAlert = true
                    } else{
                        result = markQuiz(quiz: questions, userInput: userAnswers)
                        completedQuiz = true
                    }
                    
                }) {
                    Text("Submit")
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
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Text("You have completed the quiz \(nameOfCurrentQuiz).")
                        .font(.headline)
                        .padding()
                    Text(result)
                        .font(.headline)
                        .padding()
                    Text("Click the back button to go back to the homescreen.")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                    NavigationLink(destination: Homescreen(), label: {
                        Text("Go Back")
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
