//
//  AuthViewModel.swift
//  Poof
//
//  Created by Angela Christabel on 23/10/23.
//

import Foundation
import Combine

enum LoginRegistStatus: Int8 {
    case initial
    case loading
    case success
    case failure
}

class AuthViewModel: ObservableObject {
    // MARK: - Attributes
    @Published private(set) var status: LoginRegistStatus = .initial
    @Published private(set) var message: String = ""
    //@Published private(set) var message: String = ""
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Usecases
    private let loginUseCase: LoginUserUsecase
    private let registUseCase: RegisterUserUsecase
    
    // MARK: - Utils
    private let userDefaultsController: UserDefaultsController
    
    init(
        status: LoginRegistStatus = .initial,
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
    func register(email: String, password: String, confirmPassword: String) {
//        guard let d = dob else { 
//            print("dob error")
//            return }
        guard email != "" && password != "" && confirmPassword != "" else {
            self.message = "All fields must be filled"
            return
        }
        guard !email.contains("@.com") else {
            self.message = "Email has incorrect format"
            return
        }
        guard password == confirmPassword else {
            self.message = "Passwords don't match"
            return
        }
        guard password.count >= 8 else {
            self.message = "Password must be 8 characters or longer"
            return
        }
        
        self.status = .loading
        
        Task {
            await registUseCase.execute(email: email, password: password)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("register done")
                        DispatchQueue.main.async { [weak self] in
                            self?.status = .success
                        }
                    case .failure(let failure):
                        print(failure)
                        DispatchQueue.main.async { [weak self] in
                            self?.status = .failure
                        }
                    }
                } receiveValue: { message in
                    print(message)
                    self.message = message
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
                            self?.status = .failure
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
