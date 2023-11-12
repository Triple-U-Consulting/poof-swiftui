//
//  GetKambuhByDate.swift
//  Poof
//
//  Created by Geraldy Kumara on 06/11/23.
//

import Foundation
import Combine

protocol GetKambuhDataByDateUseCase {
    func execute(requestDate: Date) async -> AnyPublisher<[Kambuh], Failure>
}

class GetKambuhDataByDateImpl {
    static let shared = GetKambuhDataByDateImpl()
    
    private let repository = KambuhRepositoryImpl.shared
}

extension GetKambuhDataByDateImpl: GetKambuhDataByDateUseCase {
    func execute(requestDate: Date) async -> AnyPublisher<[Kambuh], Failure> {
        return await self.repository.fetchKambuhByDate(date: requestDate)
    }
}
