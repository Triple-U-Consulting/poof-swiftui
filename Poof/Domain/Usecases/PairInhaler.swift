//
//  PairInhaler.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation
import Combine

protocol PairInhalerUsecase {
    func execute() async -> AnyPublisher<String, Failure>
}

final class PairInhalerImpl {
    static let shared = PairInhalerImpl()
    
    private let repository = IoTRepositoryImpl.shared
}

extension PairInhalerImpl: PairInhalerUsecase {
    func execute() async -> AnyPublisher<String, Failure> {
        return await repository.getIoTInhalerId()
    }
}
