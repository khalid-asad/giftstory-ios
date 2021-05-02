//
//  APIServiceable.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Combine
import Foundation

// MARK: - API Service Protocol
protocol APIServiceable {
        
    /// Generic Implementation
    func load<T: Decodable>(request: APIRequestable) -> AnyPublisher<[T], APIError>
}

extension APIServiceable {
    
    /// Generic Implementation
    func load<T>(request: APIRequestable) -> AnyPublisher<[T], APIError> where T: Decodable {
        fetch(request: request)
    }
    
    func fetch<T: Decodable>(request: APIRequestable) -> AnyPublisher<T, APIError> {
        guard let request = request.urlRequest else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { (data, response) -> AnyPublisher<T, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { _ in .decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCollection<T: Decodable>(request: APIRequestable) -> AnyPublisher<[T], APIError> {
        guard let request = request.urlRequest else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { (data, response) -> AnyPublisher<[T], APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: [T].self, decoder: JSONDecoder())
                        .mapError { _ in .decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
