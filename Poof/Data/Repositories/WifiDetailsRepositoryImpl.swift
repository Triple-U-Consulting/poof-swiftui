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
