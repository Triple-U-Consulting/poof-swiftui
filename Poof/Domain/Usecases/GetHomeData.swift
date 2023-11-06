//
//  GetHomeData.swift
//  Poof
//
//  Created by Angela Christabel on 06/11/23.
//

import Foundation
import Combine

protocol GetHomeDataUsecase {
    func execute() async -> AnyPublisher<HomeData, Failure>
}


class GetHomeDataImpl {
    static let shared = GetHomeDataImpl()
    
    private let repository = HomepageRepositoryImpl.shared
}

extension GetHomeDataImpl: GetHomeDataUsecase {
    func execute() async -> AnyPublisher<HomeData, Failure> {
        return await self.repository.fetchHomeData()
    }
}
