//
//  UpdateKambuhCondition.swift
//  Poof
//
//  Created by Geraldy Kumara on 03/11/23.
//

import Foundation
import Combine

protocol UpdateKambuhConditionUseCase {
    func execute(kambuh_id: [Int], scale: [Int], trigger: [Bool]) async -> AnyPublisher<String, Failure>
}

struct UpdateKambuhConditionImpl {
    static let shared = UpdateKambuhConditionImpl()
    
    private let repository = KambuhRepositoryImpl.shared
}
extension UpdateKambuhConditionImpl: UpdateKambuhConditionUseCase{
    func execute(kambuh_id: [Int], scale: [Int], trigger: [Bool]) async -> AnyPublisher<String, Failure> {
        return await self.repository.updateKambuhCondition(kambuh_id: kambuh_id, scale: scale, trigger: trigger)
    }
}
