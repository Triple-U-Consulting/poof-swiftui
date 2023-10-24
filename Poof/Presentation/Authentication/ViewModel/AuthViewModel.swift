//
//  AuthViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 23/10/23.
//

import Foundation
import Combine

enum LoginStatus {
    case initial
    case loading
    case success
    case failure(failure: Failure)
}

@Observable
class AuthViewModel {
    // MARK: - Attributes
    private(set) var status: LoginStatus = .initial
    private(set) var errorMsg: String = ""
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let loginUseCase: LoginUserUsecase
    private let registUseCase: RegisterUserUsecase
    
    // MARK: - Utils
    private let userDefaultsController: UserDefaultsController
    
    init(
        status: LoginStatus = .initial,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        loginUseCase: LoginUserUsecase = LoginUserImpl.shared,
        registUseCase: RegisterUserUsecase = RegisterUserImpl.shared,
        userDefaultsController: UserDefaultsController = UserDefaultsControllerImpl.shared
    ) {
        self.status = status
        self.cancellables = cancellables
        self.loginUseCase = loginUseCase
        self.registUseCase = registUseCase
        self.userDefaultsController = userDefaultsController
    }
}

extension AuthViewModel {
    func register(email: String, password: String, dob: Date?, confirmPassword: String) {
        guard let d = dob else { return }
        guard password == confirmPassword else {
            self.errorMsg = "Passwords don't match!"
        }
        
        Task {
            await registUseCase.execute(email: email, password: password, dob: d)
        }
    }
    
    func login(email: String, password: String) {
        Task {
            await loginUseCase.execute(email: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("login done")
                        break
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { accessToken in
                    self.userDefaultsController.save(accessToken, asKey: "token")
                    print("accessToken: \(accessToken)")
                }
        }
    }
}
