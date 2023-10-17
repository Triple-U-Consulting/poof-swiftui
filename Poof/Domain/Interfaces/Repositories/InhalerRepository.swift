//
//  InhalerRepository.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation
import Combine

protocol InhalerRepository {
    func getInhalerId() async -> AnyPublisher<String?, Failure>
}
