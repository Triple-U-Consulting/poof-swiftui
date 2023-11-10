//
//  HomepageRepository.swift
//  Poof
//
//  Created by Angela Christabel on 06/11/23.
//

import Foundation
import Combine

protocol HomepageRepository {
    func fetchHomeData(token: String) async -> AnyPublisher<HomeData, Failure>
}
