//
//  GetSummary.swift
//  Poof
//
//  Created by Angelica Patricia on 22/11/23.
//

import Foundation
import Combine

protocol GetSummaryUseCase {
    func execute(start_date: Date) async -> AnyPublisher<[Summary], Failure>
}

class GetSummaryUseCaseImpl {
    static let shared = GetSummaryUseCaseImpl()
    
    private let repository = SummaryRepositoryImpl.shared
}

extension GetSummaryUseCaseImpl: GetSummaryUseCase {
    func execute(start_date: Date) async -> AnyPublisher<[Summary], Failure> {
        return await self.repository.fetchSummary(start_date: start_date)
    }
}
