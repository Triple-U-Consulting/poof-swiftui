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

//extension UserRepositoryImpl: UserRepository {
//    func updateInhalerId(userId: String, id: String) async -> AnyPublisher<Void, Failure> {
//        <#code#>
//    }
//}
