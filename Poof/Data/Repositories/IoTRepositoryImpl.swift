//
//  InhalerRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation
import Combine

final class IoTRepositoryImpl {
    static let shared = IoTRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension IoTRepositoryImpl: IoTRepository {
    func getIoTInhalerId() async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.getIoTInhalerId()
        let results = await dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let iotResponseDTO):
            return Just(iotResponseDTO)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchInhalerIdFailure).eraseToAnyPublisher()
        }
    }
}
