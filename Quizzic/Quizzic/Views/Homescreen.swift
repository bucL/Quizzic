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
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome Back \(username)")
                        .onAppear{
                            getQuizNames()
                        }
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: QuizzesView()) {
                        GeometryReader { geometry in
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.cyan)
                                    .frame(width: geometry.size.width * 0.5, height: 100, alignment: .trailing)
                                    .padding()
                                Text("Take a Quiz")
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
            .navigationBarHidden(true)
        }
        
    }
    
    
    
    
    
    
}
struct Homescreen_Previews: PreviewProvider {
    static var previews: some View {
        Homescreen()
        
    }
}
