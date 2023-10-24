//
//  PostRegisterData.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/10/23.
//

import Foundation
import Combine

protocol RegisterUserUsecase {
    func execute(email: String, password: String, dob: Date) async -> AnyPublisher<String, Failure>
}

class RegisterUserImpl {
    static let shared = RegisterUserImpl()
    
    private let repository = UserRepositoryImpl.shared
}

extension RegisterUserImpl: RegisterUserUsecase{
    func execute(email: String, password: String, dob: Date) async -> AnyPublisher<String, Failure> {
        return await self.repository.registerUser(email: email, password: password, dob: dob)
    }
}
