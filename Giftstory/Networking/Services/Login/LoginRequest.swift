//
//  LoginRequest.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

struct LoginRequest: APIRequestable {    
     
    var email: String
    var password: String
    
    var body: [String: Any]? {
        [
            "email": email,
            "password": password
        ]
    }
    
    var httpMethod: HTTPMethod { .post }
    
    var urlString: String {
        Constants.baseURL.rawValue + Constants.authenticationPath.rawValue + Constants.loginPath.rawValue
    }
}
