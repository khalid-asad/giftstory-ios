//
//  Constants.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

enum Constants: String {
    case baseURL
    case authenticationPath
    case loginPath
    case forgotPasswordPath
    case registerAccountPath
    
    var rawValue: String {
        switch self {
        case .baseURL:
            return "https://giftstory-js.herokuapp.com/api/"
        case .authenticationPath:
            return "user/"
        case .loginPath:
            return "login"
        case .forgotPasswordPath:
            return "forgotPassword"
        case .registerAccountPath:
            return "register"
        }
    }
}
