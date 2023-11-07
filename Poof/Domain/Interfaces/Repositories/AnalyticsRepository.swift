//
//  AnalyticsRepository.swift
//  Poof
//
//  Created by Angelica Patricia on 07/11/23.
//

import Foundation
import Combine

protocol AnalyticsRepository {
    func fetchAnalytics(start_date: Date, end_date: Date, frequency: String) async -> AnyPublisher<[Analytics], Failure>
}
