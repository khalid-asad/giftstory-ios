//
//  AccountService.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Combine
import Foundation

// MARK: - Account Service Protocol
protocol AccountServiceable: APIServiceable {
    
    func authenticate(email: String, password: String) -> AnyPublisher<APIResponse, APIError>
    
    func forgotPassword(email: String) -> AnyPublisher<APIResponse, APIError>
    
    func registerAccount(firstName: String, lastName: String, email: String, password: String, birthday: String) -> AnyPublisher<APIResponse, APIError>
}

class AccountService: AccountServiceable {
    
    static let shared = AccountService()
    
    func authenticate(email: String, password: String) -> AnyPublisher<APIResponse, APIError> {
        fetch(request: LoginRequest(email: email, password: password))
    }
    
    func forgotPassword(email: String) -> AnyPublisher<APIResponse, APIError> {
        fetch(request: ForgotPasswordRequest(email: email))
    }
    
    func registerAccount(firstName: String, lastName: String, email: String, password: String, birthday: String) -> AnyPublisher<APIResponse, APIError> {
        fetch(request: AccountRegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password, birthday: birthday))
    }
}
