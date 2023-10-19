//
//  UserRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 17/10/23.
//

import Foundation
import Combine

final class UserRepositoryImpl {
    static let shared = UserRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension UserRepositoryImpl: UserRepository {
    func registerUser(email: String, password: String, dob: Date, confirmPassword: String) async -> AnyPublisher<String?, Failure> {
        let endpoint = APIEndpoints.register(email: email, password: password, dob: dob, confirmPassword: confirmPassword)
        let result = await self.dataTransferService.request(with: endpoint)
        return result
            .map{
                $0.map{
                    $0.toDomain()
                }
                .first
            }
            .eraseToAnyPublisher()
    }
}
