//
//  LoginService.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Combine
import Foundation

// MARK: - Login Service Protocol
protocol LoginServiceable: APIServiceable {
    
    func authenticate(email: String, password: String) -> AnyPublisher<LoginResponse, APIError>
}

class LoginService: LoginServiceable {
    
    static let shared = LoginService()
    
    func authenticate(email: String, password: String) -> AnyPublisher<LoginResponse, APIError> {
        fetch(request: LoginRequest(email: email, password: password))
    }
}
