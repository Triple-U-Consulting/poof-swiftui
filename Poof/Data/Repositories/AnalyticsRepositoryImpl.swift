//
//  AnalyticsRepositoryImpl.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation
import Combine

final class AnalyticsRepositoryImpl {
    static let shared =
    AnalyticsRepositoryImpl(dataTransferService:
                                DataTransferServiceImpl.shared)
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension AnalyticsRepositoryImpl: AnalyticsRepository {
    func fetchAnalytics(start_date: Date, frequency: String) async -> AnyPublisher<[Analytics], Failure> {
        let endpoint = APIEndpoints.getAnalytics(start_date: start_date, frequency: frequency)
        let results = await
        self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let analyticsResponseDTOs):
            return Just(analyticsResponseDTOs)
                .setFailureType(to: Failure.self)
                .map{
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchAnalyticsFailure).eraseToAnyPublisher()
        }
    }
}
