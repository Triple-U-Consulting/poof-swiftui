//
//  LoginUser.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation
import Combine

protocol LoginUserUsecase {
    func execute(email: String, password: String) async -> AnyPublisher<String?, Failure>
}

final class LoginUserImpl {
    static let shared = LoginUserImpl()
    
    private let repository = UserRepositoryImpl.shared
}

extension LoginUserImpl: LoginUserUsecase {
    func execute(email: String, password: String) async -> AnyPublisher<String?, Failure> {
        return await self.repository.login(email: email, password: password)
    }
}
