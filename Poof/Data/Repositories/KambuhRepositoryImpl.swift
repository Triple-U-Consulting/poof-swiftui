//
//  KambuhRepositoryImpl.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation
import Combine

final class KambuhRepositoryImpl {
    
    static let shared = KambuhRepositoryImpl(dataTransferService: DataTransferServiceImpl.shared)
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension KambuhRepositoryImpl: KambuhRepository {
    
    func updateKambuhCondition(kambuh_id: [Int], scale: [Int], trigger: [Bool]) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.updateKambuhCondition(kambuh_id: kambuh_id, scale: scale, trigger: trigger)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results{
        case.success(let MessageResponseDTOs):
            return Just(MessageResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let failure):
            return Fail(error: failure).eraseToAnyPublisher()
        }
    }
    
    func fetchKambuhByDate(date: Date) async -> AnyPublisher<[Kambuh], Failure> {
        let endpoint = APIEndpoints.getKambuhByDate(date: date)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results{
        case.success(let kambuhResponseDTOs):
//            print(kambuhResponseDTOs)
            return Just(kambuhResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchKambuhFailure).eraseToAnyPublisher()
        }
    }
    
    func fetchKambuhById(id: Int) async -> AnyPublisher<Kambuh?, Failure> {
        let endpoint = APIEndpoints.getKambuhById(id: id)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let kambuhResponseDTOs):
            return Just(kambuhResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                        .first
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchKambuhFailure).eraseToAnyPublisher()
        }
    }
    
    func fetchKambuhList() async -> AnyPublisher<[Kambuh], Failure> {
        let endpoint = APIEndpoints.getKambuh()
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results {
        case .success(let kambuhResponseDTOs):
            return Just(kambuhResponseDTOs)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
            
        case .failure(let error):
            print(error)
            return Fail(error: Failure.fetchKambuhFailure).eraseToAnyPublisher()
        }
    }
}
