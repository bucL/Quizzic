//
//  Homescreen.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct Homescreen: View {
    @AppStorage("uid") var userID: String = ""  // Storage property to store the user ID
    @AppStorage("username") var username: String = ""  // Storage property to store the username
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome Back \(username)")  // Displays a welcome message with the username
                        .onAppear {
                            getQuizNames()  // Calls the `getQuizNames()` function when the view appears
                        }
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)  // Applies a green background color
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: QuizzesView()) {  // Navigation link to the QuizzesView
                        GeometryReader { geometry in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.cyan)  // Applies a cyan fill color to the rounded rectangle
                                    .frame(width: geometry.size.width * 0.5, height: 100, alignment: .trailing)
                                    .padding()
                                Text("Take a Quiz")  // Displays the text "Take a Quiz"
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                            .offset(x: 75)
                            .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)  // Hides the navigation bar
    }
}

struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
    }
}
