//
//  UpdateInhalerDose.swift
//  Poof
//
//  Created by Angela Christabel on 10/11/23.
//

import Foundation
import Combine

protocol UpdateInhalerDoseUsecase {
    func execute(inhalerId: String, dose: Int) async -> AnyPublisher<String, Failure>
}

class UpdateInhalerDoseImpl {
    static let shared = UpdateInhalerDoseImpl()
    
    private let repository: InhalerRepository = InhalerRepositoryImpl.shared
}

extension UpdateInhalerDoseImpl: UpdateInhalerDoseUsecase {
    func execute(inhalerId: String, dose: Int) async -> AnyPublisher<String, Failure> {
        return await self.repository.updateInhalerBottle(id: inhalerId, dose: dose)
    }
}
