//
//  User.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 27/3/2023.
//

import Foundation


struct User: Codable {
    var firstName: String
    var lastName: String
    var UserName: String
    var signUpDate = Date.now
    

}


