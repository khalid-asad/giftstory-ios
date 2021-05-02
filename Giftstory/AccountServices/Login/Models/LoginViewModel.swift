//
//  LoginViewModel.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Combine
import Foundation

// MARK: - Non-generic way
class LoginViewModel: ObservableObject {

    @Published private(set) var state: APIFetchState<LoginResponse> = .idle
    @Published private(set) var response = LoginResponse()

    private var cancellables = Set<AnyCancellable>()

    func authenticate(email: String, password: String) {
        state = .loading
        let cancellable = LoginService.shared
            .authenticate(email: email, password: password)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success([self.response])
                case .failure(let error):
                    self.state = .failure(error)
                }
            } receiveValue: { response in
                self.response = response
            }
        cancellables.insert(cancellable)
    }
}
