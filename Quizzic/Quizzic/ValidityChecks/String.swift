//
//  String.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import Foundation

extension String {
    func isValidEmail() -> Bool { // function to test whether the email entered is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil // Regex function that checks whether the email the user enters is valid.
    }
}
