//
//  GetKambuhByMonth.swift
//  Poof
//
//  Created by Angela Christabel on 08/11/23.
//

import Foundation
import Combine

protocol GetKambuhByMonthUsecase {
    func execute(date: Date) async -> AnyPublisher<[Kambuh], Failure>
}

class GetKambuhByMonthImpl {
    static let shared = GetKambuhByMonthImpl()
    
    private let repository: KambuhRepository = KambuhRepositoryImpl.shared
}

extension GetKambuhByMonthImpl: GetKambuhByMonthUsecase {
    func execute(date: Date) async -> AnyPublisher<[Kambuh], Failure> {
        return await repository.fetchKambuhByMonthYear(date: date)
    }
}
