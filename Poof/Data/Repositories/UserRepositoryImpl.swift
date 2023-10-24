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
    func registerUser(email: String, password: String, dob: Date, confirmPassword: String) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.register(email: email, password: password, dob: dob, confirmPassword: confirmPassword)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let tokenResponseDTOs):
            return Just(tokenResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
//            print(error)
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func login(email: String, password: String) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.login(email: email, password: password)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let tokenResponseDTOs):
            return Just(tokenResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
//            print(error)
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func updateInhalerId(id: String, userToken: String) async -> AnyPublisher<String, Failure> {
        print(id)
        print(userToken)
        let endpoint = APIEndpoints.updateUserInhalerId(id: id, token: userToken)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let userResponseDTO):
            return Just(userResponseDTO)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let error):
//            print(error)
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
