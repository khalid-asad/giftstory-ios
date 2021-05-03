//
//  String+Extensions.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

// MARK: - Date Strings
extension String {
    
    /// Converts a string to Date format of yyyy-MM-dd.
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)
    }
}

// MARK: - Regular Expression
extension String {
    
    /// Checks if a regular expression is valid on a String.
    func isRegularExpressionValid(for regularExpression: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        return test.evaluate(with: self)
    }
    
    /// Checks if an E-mail is valid.
    var isValidEmail: Bool {
        let regEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        return isRegularExpressionValid(for: regEx)
    }
}
