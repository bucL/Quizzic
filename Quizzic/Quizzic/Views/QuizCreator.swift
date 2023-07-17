//
//  QuizCreator.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct QuizCreator: View {
    // AppStorage properties to store user ID and username through restarts
    @AppStorage("uid") var userID: String = ""
    @AppStorage("username") var username: String = ""
    
    // State properties for quiz creation
    @State private var numberOfQuestions: Float = 0
    @State private var quizName: String = ""
    @State private var showAlert = false
    @State private var successAlert = false
    @State private var errorAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Title and header of the quiz creator view
                Text("Create A Quiz")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                // Text field for entering the quiz name
                HStack {
                    TextField("Quiz Name", text: self.$quizName.max(100))
                        .bold()
                        .font(.title)
                    if quizName.count != 0 {
                        Image(systemName: checkQuizExists(searchString: quizName, array: quizzesArray) ? "xmark" : "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(checkQuizExists(searchString: quizName, array: quizzesArray) ?  .red : .green)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray.opacity(0.5))
                )
                .padding()
                
                // Information about adding questions to the quiz
                Text("If you add or remove questions while creating the Quiz Please click 'Edit Question' and then 'Save Question' again to ensure your questions are saved.")
                    .padding()
                
                // Slider to specify the number of questions
                Text("Specify a number of questions: \(Int(numberOfQuestions))")
                    .padding()
                Slider(value: $numberOfQuestions, in: 0...20, step: 1) {
                    Text("Slider")
                } minimumValueLabel: {
                    Text("0")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding()
                } maximumValueLabel: {
                    Text("20")
                        .font(.title2)
                        .fontWeight(.thin)
                        .padding()
                }
                
                // Loop over the number of questions selected by the slider
                ForEach(0..<Int(numberOfQuestions), id: \.self) { index in
                    VStack {
                        // Display the question number
                        Text("Question \(index+1)")
                            .font(.title2)
                            .fontWeight(.light)
                            .padding()
                            .frame(alignment: .leading)
                        
                        // QuestionMaker view for creating and editing questions
                        QuestionMaker()
                    }
                    .onAppear {
                        // Reset the questions dictionary when the user updates the value of the slider.
                        questions = [:]
                    }
                }
                
                // Button for saving the quiz
                Button {
                    // Check if the questions dictionary is empty or if the quiz name is empty
                    if questions == [:] || quizName == "" {
                        showAlert = true // Set showAlert to true if either condition is true
                    } else if checkQuizExists(searchString: quizName, array: quizzesArray) == true {
                        errorAlert = true
                    } else {
                        let docData = questions
                        let db = Firestore.firestore()
                        
                        // Upload the quiz to Firestore in the collection named "quizzes" with the reference for the document being the name of the quiz.
                        db.collection("quizzes").document("\(quizName)").setData(docData) { err in
                            if let err = err {
                                print("Error uploading quiz: \(err)")
                            } else {
                                print("Successfully uploaded to Firebase")
                            }
                        }
                        
                        successAlert = true
                        numberOfQuestions = 0
                        quizName = ""
                    }
                } label: {
                    Text("Save Quiz")
                        .alert("Please create a Question and enter a Quiz Name before trying to save the quiz", isPresented: $showAlert) {
                            Button("Okay!", role: .cancel) {}
                        }
                        .alert("Successfully created a new quiz", isPresented: $successAlert) {
                            Button("Okay!", role: .cancel) {}
                        }
                        .alert(isPresented: $errorAlert, content: {
                            Alert(
                                title: Text("Uh Oh!"),
                                message: Text("Make sure the quiz you are trying to create doesn't already exist."),
                                dismissButton: .default(Text("Okay"))
                                
                            )
                        })
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green) // Green background color
                        .clipShape(Capsule())
                        .foregroundColor(.white) // White foreground color
                        .padding()
                }
            }
        }
    }
}


struct QuizCreator_Previews: PreviewProvider {
    static var previews: some View {
        QuizCreator()
    }
}
