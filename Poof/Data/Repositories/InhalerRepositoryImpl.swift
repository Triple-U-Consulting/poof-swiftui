//
//  File.swift
//  Poof
//
//  Created by Angela Christabel on 10/11/23.
//

import Foundation
import Combine

final class InhalerRepositoryImpl {
    static let shared = InhalerRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension InhalerRepositoryImpl: InhalerRepository {
    func updateInhalerBottle(id: String, dose: Int) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.updateInhalerBottle(id: id, dose: dose)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let messageResponseDTO):
           return Just(messageResponseDTO)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
