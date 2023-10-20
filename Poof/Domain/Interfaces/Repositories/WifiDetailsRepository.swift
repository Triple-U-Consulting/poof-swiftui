//
//  WifiRepository.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import Foundation
import Combine

protocol WiFiDetailsRepository {
    func postWiFiDetails(ssid: String, password: String) async -> AnyPublisher<String, Failure>
}
