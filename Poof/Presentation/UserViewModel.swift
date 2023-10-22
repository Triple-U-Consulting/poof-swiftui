//
//  UserViewModel.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/10/23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject{
    
    // MARK: - Attributes
    @Published private(set) var message: String? = nil
    @Published private(set) var error: String? = nil
    @Published private(set) var status: LoadingStatus = .initial

    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Use cases
    private let registerUser: RegisterUserUsecase
    
    init(registerUser: RegisterUserUsecase = RegisterUserImpl.shared){
        self.registerUser = registerUser
    }

    func registerUser(email: String, password: String, dob: Date, confirmPassword: String){
        self.status = .loading
        Task {
           await registerUser.execute(email: email, password: password, dob: dob, confirmPassword: confirmPassword)
                .receive(on: DispatchQueue.main)
                .sink{ [weak self] completion in
                    switch completion{
                    case .finished:
                        self?.status = .success
                    case .failure(let failure):
                        self?.status = .failure(failure: failure)
                        self?.error = failure.localizedDescription
                    }
                } receiveValue: { message in
                    self.message = message
                }
        }
    }
    
}
