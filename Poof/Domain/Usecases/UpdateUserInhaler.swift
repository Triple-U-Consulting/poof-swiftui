//
//  UpdateUserInhaler.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation
import Combine

protocol UpdateUserInhalerUsecase {
    func execute(requestValue: String, userToken: String) async -> AnyPublisher<User, Failure>
}

final class UpdateUserInhalerImpl {
    static let shared = UpdateUserInhalerImpl()
    
    private let repository = UserRepositoryImpl.shared
}

//extension UpdateUserInhalerImpl: UpdateUserInhalerUsecase {
//    func execute(requestValue: String, userToken: String) async -> AnyPublisher<User, Failure> {
//        return await self.repository.updateInhalerId(id: requestValue, userToken: userToken)
//    }
//}
