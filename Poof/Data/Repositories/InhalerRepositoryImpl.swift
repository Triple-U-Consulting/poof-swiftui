//
//  InhalerRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation
import Combine

final class InhalerRepositoryImpl {
    static let shared = InhalerRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension InhalerRepositoryImpl: InhalerRepository {
    func getInhalerId() async -> AnyPublisher<String?, Failure> {
        let endpoint = APIEndpoints.getInhalerId()
        let results = await dataTransferService.request(with: endpoint)
        return results
            .map {
                $0.map {
                    $0.toDomain()
                }
                .first
            }
            .eraseToAnyPublisher()
    }
}
