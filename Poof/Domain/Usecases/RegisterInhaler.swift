//
//  GetInhalerId.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation
import Combine

protocol RegisterInhalerUsecase {
    func execute() async -> AnyPublisher<Void, Failure>
}

final class RegisterInhalerImpl {
    static let shared = RegisterInhalerImpl()
    
    private let inhalerRepository = InhalerRepositoryImpl.shared
    private let userRepository = UserRepositoryImpl.shared
    
    private func updateUserInhaler(id: String) -> AnyPublisher<Void, Failure> {
//        return await self.userRepository
    }
}

extension RegisterInhalerImpl: RegisterInhalerUsecase {
    func execute() async -> AnyPublisher<Void, Failure> {
        var requestedId: String?
        let _ = await self.inhalerRepository.getInhalerId()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                }
                
            } receiveValue: { result in
                requestedId = result
            }
        
        guard let id = requestedId else { return Fail(error: Failure.fetchInhalerIdFailure).eraseToAnyPublisher() }
        
        return updateUserInhaler(id: id)
    }
}
