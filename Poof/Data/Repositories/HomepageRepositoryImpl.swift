//
//  HomepageRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 06/11/23.
//

import Foundation
import Combine

final class HomepageRepositoryImpl {
    static let shared = HomepageRepositoryImpl()
    
    private let dataTransferService = DataTransferServiceImpl.shared
}

extension HomepageRepositoryImpl: HomepageRepository {
    func fetchHomeData(token: String) async -> AnyPublisher<HomeData, Failure> {
        let endpoint = APIEndpoints.getHomeData(token: token)
        let results = await dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let homeDataResponseDTO):
           return Just(homeDataResponseDTO)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
