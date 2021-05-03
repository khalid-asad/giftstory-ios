//
//  APIResponse.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

struct APIResponse: Codable {
    let message: String?
    let error: String?
    
    init(message: String? = nil, error: String? = nil) {
        self.message = message
        self.error = error
    }
}
