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
    static let shared = GetKambuhDataImpl()
    
    private let repository = KambuhRepositoryImpl.shared
}

extension GetKambuhDataImpl: GetKambuhDataUseCase {
    func execute() async -> AnyPublisher<[Kambuh], Failure> {
        return await self.repository.fetchKambuhList()
    }
}
