//
//  WifiRepositoryImpl.swift
//  Poof
//
//  Created by Angelica Patricia on 18/10/23.
//

import Foundation
import Combine

final class WiFiDetailsRepositoryImpl {
    
    static let shared = WiFiDetailsRepositoryImpl(dataTransferService: DataTransferServiceImpl.shared)
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension WiFiDetailsRepositoryImpl: WiFiDetailsRepository {
    func postWiFiDetails(ssid: String, password: String) async -> AnyPublisher<String?, Failure> {
        let endpoint = APIEndpoints.postWiFiDetails(ssid: ssid, password: password)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
            case .success(let messageResponseDTOs):
                if let firstMessage = messageResponseDTOs.first {
                    return Just(firstMessage.toDomain())
                        .setFailureType(to: Failure.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: Failure.noResponse).eraseToAnyPublisher()
                }
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            }
    }
}
