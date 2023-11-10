//
//  Analytics.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation
import Combine

protocol GetAnalyticsUseCase {
    func execute(start_date: Date, frequency: String) async -> AnyPublisher<[Analytics], Failure>
}

class GetAnalyticsUseCaseImpl {
    static let shared = GetAnalyticsUseCaseImpl()
    
    private let repository = AnalyticsRepositoryImpl.shared
}

extension GetAnalyticsUseCaseImpl: GetAnalyticsUseCase {
    func execute(start_date: Date, frequency: String) async -> AnyPublisher<[Analytics], Failure> {
        return await self.repository.fetchAnalytics(start_date: start_date, frequency: frequency)
    }
}
