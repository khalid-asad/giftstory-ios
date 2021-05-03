//
//  RegisterAccountRequest.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

struct AccountRegistrationRequest: APIRequestable {
     
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var birthday: String
    
    var body: Data? {
        struct AccountRegistrationRequestBody: Codable {
            let firstName: String
            let lastName: String
            let email: String
            let password: String
            let birthday: String
        }
        return try? JSONEncoder().encode(AccountRegistrationRequestBody(firstName: firstName, lastName: lastName, email: email, password: password, birthday: birthday))
    }
    
    var httpMethod: HTTPMethod { .post }
    
    var urlString: String {
        Constants.baseURL.rawValue + Constants.authenticationPath.rawValue + Constants.registerAccountPath.rawValue
    }
}
