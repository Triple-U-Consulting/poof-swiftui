//
//  SummaryRepositoryImpl.swift
//  Poof
//
//  Created by Angelica Patricia on 22/11/23.
//

import Foundation
import Combine

final class SummaryRepositoryImpl {
    static let shared =
    SummaryRepositoryImpl(dataTransferService:
                                DataTransferServiceImpl.shared)
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension SummaryRepositoryImpl: SummaryRepository {
    func fetchSummary(start_date: Date) async -> AnyPublisher<[Summary], Failure> {
        let endpoint = APIEndpoints.getSummary(start_date: start_date)
        let results = await
        self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let summaryResponseDTOs):
            return Just(summaryResponseDTOs)
                .setFailureType(to: Failure.self)
                .map{
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchSummaryFailure).eraseToAnyPublisher()
        }
    }
}
