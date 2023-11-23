//
//  AnalyticsRepository.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation
import Combine

protocol AnalyticsRepository {
    func fetchAnalytics(start_date: Date, frequency: String) async -> AnyPublisher<[Analytics], Failure>
    func fetchQuarterKambuhData(start_date: Date) async -> AnyPublisher<[Analytics], Failure>
}
