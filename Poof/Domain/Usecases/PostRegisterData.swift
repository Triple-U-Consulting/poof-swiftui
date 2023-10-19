//
//  PostRegisterData.swift
//  Poof
//
//  Created by Geraldy Kumara on 19/10/23.
//

import Foundation
import Combine

protocol PostRegisterDataUseCase {
    func execute(email: String, password: String, dob: Date, confirmPassword: String) async -> AnyPublisher<String?, Failure>
}

class PostRegisterDataImpl {
    static let shared = PostRegisterDataImpl()
    
    private let repository = UserRepositoryImpl.shared
}

extension PostRegisterDataImpl: PostRegisterDataUseCase{
    func execute(email: String, password: String, dob: Date, confirmPassword: String) async -> AnyPublisher<String?, Failure> {
        return await self.repository.registerUser(email: email, password: password, dob: dob, confirmPassword: confirmPassword)
    }
}
