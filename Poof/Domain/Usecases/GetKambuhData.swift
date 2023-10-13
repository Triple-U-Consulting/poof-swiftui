//
//  GetKambuhDataUseCase.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation
import Combine

protocol GetKambuhDataUseCase {
    func execute() async -> AnyPublisher<[Kambuh], Failure>
}


class GetKambuhDataImpl {
    static let shared = GetKambuhDataImpl(repository: KambuhRepositoryImpl.shared)
    
    private let repository: KambuhRepositoryImpl
    
    init(repository: KambuhRepositoryImpl) {
        self.repository = repository
    }
}

extension GetKambuhDataImpl: GetKambuhDataUseCase {
    func execute() async -> AnyPublisher<[Kambuh], Failure> {
        return await self.repository.fetchKambuhList()
    }
}
