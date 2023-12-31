//
//  DataTransferService.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

protocol DataTransferService {
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E
    ) async -> Result<T, Failure> where E.ResponseType == T
}

final class DataTransferServiceImpl {
    static let shared = DataTransferServiceImpl(networkService: NetworkServiceImpl.shared)
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DataTransferServiceImpl: DataTransferService {
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E
    ) async -> Result<T, Failure> where E.ResponseType == T {
        let (data, response) = await networkService.request(endpoint: endpoint)
        
        // resolve url response
        if let r = response as? HTTPURLResponse {
            let code = r.statusCode
            
            if code == 200 || code == 201 {
                let decoded: Result<T, Failure> = self.decode(
                    data: data,
                    decoder: endpoint.responseDecoder
                )
                return decoded
            } else if code == 400 {
                return .failure(.networkFailure(.badRequest))
            } else if code == 401 {
                return .failure(.networkFailure(.unauthenticated))
            } else if code == 403 || code == 404 {
                return .failure(.networkFailure(.unknownURL))
            } else if code == 500 {
                return .failure(.networkFailure(.serverError))
            }
        }
        
        return .failure(.noResponse)
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(
        data: Data?,
        decoder: JSONResponseDecoder
    ) -> Result<T, Failure> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
}

// MARK: - Response Decoders
class JSONResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
