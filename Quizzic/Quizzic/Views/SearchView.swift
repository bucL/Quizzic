//
//  SearchView.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 19/5/2023.
//

/* REMARK: @bucL
* What does this file even do? 
* You should plan out your user interface and screens
* before you act. This will save you time and 
* give you a direction to head in.
*
*/

import SwiftUI

struct SearchView: View {
    
    @AppStorage("uid") var userID: String  = ""
    @AppStorage("username") var username: String = ""
    
    var body: some View {

        Text("SearchView")
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
