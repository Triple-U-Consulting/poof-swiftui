//
//  DeleteKambuhData.swift
//  Poof
//
//  Created by Geraldy Kumara on 23/11/23.
//

import Foundation
import Combine

protocol DeleteKambuhDataUseCase {
    func execute(kambuh_id: Int) async -> AnyPublisher<String, Failure>
}

class DeleteKambuhDataImpl {
    
    static let shared = DeleteKambuhDataImpl()
    
    private let repository = KambuhRepositoryImpl.shared
    
}

extension DeleteKambuhDataImpl: DeleteKambuhDataUseCase {
    func execute(kambuh_id: Int) async -> AnyPublisher<String, Failure> {
        return await self.repository.deleteKambuhData(kambuh_id: kambuh_id)
    }
}
