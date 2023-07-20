//
//  String.swift
//  Quizzic
//
//  Created by Aaditya Shankar on 8/5/2023.
//

import Foundation

extension String {
    /*
    Validates whether the email address is in a correct format.
     This method uses a regular expression to validate the email address. It checks whether the given string represents a valid email address with correct syntax.
     - Returns: A Boolean value indicating whether the email address is valid (true) or not (false).
     - Note: The regular expression used for validation is as follows:
       "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$"
     */
    func isValidEmail() -> Bool {
        // Define the regular expression pattern for email validation
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$", options: .caseInsensitive)
        // Use the regular expression to check for a match in the email string
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
}

