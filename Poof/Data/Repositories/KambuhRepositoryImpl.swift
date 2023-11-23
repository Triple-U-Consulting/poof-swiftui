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
    
    func getKambuhIfScaleAndTriggerIsNull() async -> AnyPublisher<[Kambuh], Failure> {
        let endpoint = APIEndpoints.getKambuhIfScaleAndTriggerIsNull()
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
    
    
    func updateKambuhCondition(kambuh: [Kambuh]) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.updateKambuhCondition(kambuh: kambuh)
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
    
    func fetchKambuhByMonthYear(date: Date) async -> AnyPublisher<[Kambuh], Failure> {
        let endpoint = APIEndpoints.getKambuhByMonthYear(date: date)
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
    
    func deleteKambuhData(kambuh_id: Int) async -> AnyPublisher<String, Failure> {
        let endpoint = APIEndpoints.deleteKambuhData(kambuh_id: kambuh_id)
        let results = await self.dataTransferService.request(with: endpoint)
        
        switch results{
        case.success(let messageResponseDTO):
            return Just(messageResponseDTO)
                .setFailureType(to: Failure.self)
                .map {
                    $0.toDomain()
                }
                .eraseToAnyPublisher()
        case .failure(let failure):
            print(failure)
            return Fail(error: Failure.deleteKambuhFailure).eraseToAnyPublisher()
        }
    }
    
}
