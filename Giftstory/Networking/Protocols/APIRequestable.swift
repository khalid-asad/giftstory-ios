//
//  APIRequestable.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Foundation

enum HTTPMethod: String, Codable, Equatable, Hashable {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

// MARK: - API Requestable Protocol
protocol APIRequestable {
    
    var body: Data? { get }
    var headers: [String: String] { get }
    var httpMethod: HTTPMethod { get }
    var urlString: String { get }
}

extension APIRequestable {
    
    var body: Data? { nil }

    var headers: [String: String] { [:] }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if [.post, .put, .delete].contains(httpMethod) {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
           request.httpBody = body
        }
        
        return request
    }
}
