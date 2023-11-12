//
//  InhalerRepository.swift
//  Poof
//
//  Created by Angela Christabel on 10/11/23.
//

import Foundation
import Combine

protocol InhalerRepository {
    func updateInhalerBottle(id: String, dose: Int) async -> AnyPublisher<String, Failure>
}
