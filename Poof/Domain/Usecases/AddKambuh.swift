//
//  AddKambuh.swift
//  Poof
//
//  Created by Angelica Patricia on 23/11/23.
//

import Foundation
import Combine

protocol AddKambuhDataUsecase {
    func execute(start_time: String, total_puff: Int, scale: String, trigger: String) async -> AnyPublisher<String, Failure>
}

class AddKambuhDataUsecaseImpl {
    static let shared = AddKambuhDataUsecaseImpl()
    
    private let repository =
    KambuhRepositoryImpl.shared
    
}

extension AddKambuhDataUsecaseImpl: AddKambuhDataUsecase {
    func execute(start_time: String, total_puff: Int, scale: String, trigger: String) async -> AnyPublisher<String, Failure> {
        return await self.repository.addKambuh(start_time: start_time, total_puff: total_puff, scale: scale, trigger: trigger)
    }
}
