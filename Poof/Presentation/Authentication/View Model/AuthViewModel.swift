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

class AuthViewModel: ObservableObject {
    // MARK: - Attributes
    @Published private(set) var status: LoginStatus = .initial
    @Published private(set) var errorMsg: String = ""
    
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
            return
        }
        
        Task {
            await registUseCase.execute(email: email, password: password, dob: d)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("register done")
                    case .failure(let failure):
                        print(failure)
                    }
                } receiveValue: { message in
                    print(message)
                }
                .store(in: &cancellables)
        }
    }
    
    func login(email: String, password: String) {
        self.status = .loading
        Task {
            await loginUseCase.execute(email: email, password: password)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("login done")
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.status = .success
                        }
                        
                        break
                    case .failure(let failure):
                        print(failure)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.status = .failure(failure: failure)
                        }
                        
                        break
                    }
                } receiveValue: { accessToken in
                    self.userDefaultsController.save(accessToken, asKey: "token")
                    print("accessToken: \(accessToken)")
                }
                .store(in: &cancellables)
        }
    }
}
