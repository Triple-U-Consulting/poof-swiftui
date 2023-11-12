//
//  AddWifi.swift
//  Poof
//
//  Created by Angelica Patricia on 18/10/23.
//

import Foundation
import Combine

protocol PostWiFiDetailsUseCase {
    func execute(ssid: String, password: String) async -> AnyPublisher<String, Failure>
}

class PostWiFiDetailsUseCaseImpl {
    static let shared = PostWiFiDetailsUseCaseImpl()
    
    private let repository =
    WiFiDetailsRepositoryImpl.shared
    
}

extension PostWiFiDetailsUseCaseImpl: PostWiFiDetailsUseCase {
    func execute(ssid: String, password: String) async -> AnyPublisher<String, Failure> {
        return await self.repository.postWiFiDetails(ssid: ssid, password: password)
    }
}
