//
//  HomepageView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 11/5/2023.
//

import SwiftUI

struct HomepageView: View {
    // Currently errors occur because view only exists in one file. 
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {
//        ZStack{
//            VStack {
//                Text("Currentview is homepageview")
//                Spacer()
//                HStack{
//                    Button {
//                        var view = "home"
//                    } label: {
//                        VStack {
//                            Image(systemName: "house")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Home")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                    Button {
//                        view = "settings"
//                    } label: {
//                        VStack {
//                            Image(systemName: "gearshape")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Settings")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                    Button {
//                        view = "quizcreator"
//                    } label: {
//                        VStack {
//                            Image(systemName: "plus.square")
//                                .resizable()
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .scaledToFill()
//                                .clipped()
//
//                            Text("Create Quiz")
//                                .foregroundColor(.black)
//                                .font(.custom(
//                                    "SanFrancisco",
//                                    size: 8,
//                                    relativeTo: .body))
//
//                        }
//
//                    }
//                    .padding()
//                }
//            }
//
//        }
        
        Text("HomepageView")
        
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
