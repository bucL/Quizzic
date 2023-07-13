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
            HStack {
                TextField("Enter Quiz Name...", text: $searchString)
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
                
            }
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
