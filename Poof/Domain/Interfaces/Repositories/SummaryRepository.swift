//
//  SummaryRepository.swift
//  Poof
//
//  Created by Angelica Patricia on 22/11/23.
//

import Foundation
import Combine

protocol SummaryRepository {
    func fetchSummary(start_date: Date) async -> AnyPublisher<[Summary], Failure>
}
