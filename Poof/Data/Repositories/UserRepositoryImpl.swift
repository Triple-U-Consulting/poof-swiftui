//
//  UserRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation
import Combine

final class UserRepositoryImpl {
    static let shared = UserRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension UserRepositoryImpl: UserRepository {
    func login(email: String, password: String) async -> AnyPublisher<String?, Failure> {
        let endpoint = APIEndpoints.login(email: email, password: password)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let tokenResponseDTOs):
            return Just(tokenResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.map {
                        $0.toDomain()
                    }
                    .first
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.loginFailure).eraseToAnyPublisher()
        }
    }
    
//    func updateInhalerId(id: String, userToken: String) async -> AnyPublisher<User, Failure> {
//        let endpoint = APIEndpoints.updateUserInhalerId(id: id, token: userToken)
//        let results = await self.dataTransferService.request(with: endpoint)
//    }
}
