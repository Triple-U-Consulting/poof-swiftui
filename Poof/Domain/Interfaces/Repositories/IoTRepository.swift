//
//  InhalerRepository.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation
import Combine

protocol IoTRepository {
    func getIoTInhalerId() async -> AnyPublisher<String?, Failure>
}
