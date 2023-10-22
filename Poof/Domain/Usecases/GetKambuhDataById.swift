//
//  GetKambuhDataById.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import Foundation
import Combine

protocol GetKambuhDataByIdUseCase {
    func execute(requestValue: Int) async -> AnyPublisher<Kambuh?, Failure>
}


class GetKambuhDataByIdImpl {
    static let shared = GetKambuhDataByIdImpl()
    
    private let repository = KambuhRepositoryImpl.shared
}

extension GetKambuhDataByIdImpl: GetKambuhDataByIdUseCase {
    func execute(requestValue: Int) async -> AnyPublisher<Kambuh?, Failure> {
        return await self.repository.fetchKambuhById(id: requestValue)
    }
}
