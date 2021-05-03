//
//  ForgotPasswordRequest.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

struct ForgotPasswordRequest: APIRequestable {
     
    var email: String
    
    var body: Data? {
        struct ForgotPasswordRequestBody: Codable {
            let email: String
        }
        return try? JSONEncoder().encode(ForgotPasswordRequestBody(email: email))
    }
    
    var httpMethod: HTTPMethod { .put }
    
    var urlString: String {
        Constants.baseURL.rawValue + Constants.authenticationPath.rawValue + Constants.forgotPasswordPath.rawValue
    }
}
