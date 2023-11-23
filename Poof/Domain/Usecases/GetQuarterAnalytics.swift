//
//  GetQuarterAnalytics.swift
//  Poof
//
//  Created by Geraldy Kumara on 22/11/23.
//

import Foundation
import Combine

protocol GetQuarterAnalyticsUseCase {
    func execute(start_date: Date) async -> AnyPublisher<[Analytics], Failure>
}

struct GetQuarterAnalyticsImpl {
    
    static let shared = GetQuarterAnalyticsImpl()
    
    private let repository = AnalyticsRepositoryImpl.shared
    
}

extension GetQuarterAnalyticsImpl: GetQuarterAnalyticsUseCase{
    func execute(start_date: Date) async -> AnyPublisher<[Analytics], Failure>{
        return await self.repository.fetchQuarterKambuhData(start_date: start_date)
    }
}
