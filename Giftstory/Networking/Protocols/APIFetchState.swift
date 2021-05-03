//
//  APIFetchState.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

enum APIFetchState<T: Decodable> {
    case idle
    case noResultsFound
    case loading
    case success(T)
    case failure(APIError)
}

enum APIError: LocalizedError {
    case decodingError
    case errorCode(Int)
    case errorMessage(String)
    case invalidRequest
    case invalidURL
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Unable to decode JSON."
        case .errorCode(let code):
            return "REST API returned code \(code)"
        case .errorMessage(let message):
            return message
        case .invalidRequest:
            return "The request was invalid."
        case .invalidURL:
            return "The request URL is invalid."
        case .unknown:
            return "Unknown error ocurred."
        }
    }
}
