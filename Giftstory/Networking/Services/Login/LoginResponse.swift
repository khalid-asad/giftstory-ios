//
//  LoginResponse.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

struct LoginResponse: Codable {
    let message: String
    
    init(message: String = "") {
        self.message = message
    }
}
