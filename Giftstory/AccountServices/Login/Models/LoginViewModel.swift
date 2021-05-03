//
//  LoginViewModel.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {

    @Published private(set) var state: APIFetchState<APIResponse> = .idle
    @Published private(set) var response = APIResponse()

    private var cancellables = Set<AnyCancellable>()

    func authenticate(email: String, password: String, completion: @escaping ((APIFetchState<APIResponse>) -> Void)) {
        guard !email.isEmpty, !password.isEmpty else { return completion(.failure(.errorMessage("Please fill in all the fields."))) }
        guard email.count >= 4 else { return completion(.failure(.errorMessage("E-mail is not long enough."))) }
        guard password.count >= 8 else { return completion(.failure(.errorMessage("Password is not long enough. Please enter a valid password."))) }
        guard email.isValidEmail else { return completion(.failure(.errorMessage("Please enter a valid e-mail."))) }

        state = .loading
        let cancellable = AccountService.shared
            .authenticate(email: email, password: password)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(self.response)
                case .failure(let error):
                    self.state = .failure(error)
                }
                completion(self.state)
            } receiveValue: { response in
                self.response = response
            }
        cancellables.insert(cancellable)
    }
}
