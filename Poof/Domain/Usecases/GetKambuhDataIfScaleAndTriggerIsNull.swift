//
//  GetKambuhDataIfScaleAndTriggerIsNull.swift
//  Poof
//
//  Created by Geraldy Kumara on 09/11/23.
//

import Foundation
import Combine

protocol GetKambuhDataIfScaleAndTriggerIsNullUseCase{
    func execute() async -> AnyPublisher<[Kambuh], Failure>
}

class GetKambuhDataIfScaleAndTriggerIsNullImpl {
    static let shared = GetKambuhDataIfScaleAndTriggerIsNullImpl()
    
    private let repository: KambuhRepository = KambuhRepositoryImpl.shared
}

extension GetKambuhDataIfScaleAndTriggerIsNullImpl: GetKambuhDataIfScaleAndTriggerIsNullUseCase{
    func execute() async -> AnyPublisher<[Kambuh], Failure> {
        return await self.repository.getKambuhIfScaleAndTriggerIsNull()
    }
}
