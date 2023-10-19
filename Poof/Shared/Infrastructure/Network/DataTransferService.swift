//
//  DataTransferService.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

protocol DataTransferService {
//    typealias CompletionHandler<T> = (Result<[T], Failure>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E
    ) async -> Result<[T], Failure> where E.ResponseType == T
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
    ) async -> Result<[T], Failure> where E.ResponseType == T {
        let data = await networkService.request(endpoint: endpoint)
        let decoded: Result<[T], Failure> = self.decode(
            data: data,
            decoder: endpoint.responseDecoder
        )
        return decoded
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(
        data: Data?,
        decoder: JSONResponseDecoder
    ) -> Result<[T], Failure> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: [T] = try decoder.decode(data)
            return .success(result)
        } catch {
//            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
}

// MARK: - Response Decoders
class JSONResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> [T] {
//        let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//        print(nstr)
        return try jsonDecoder.decode([T].self, from: data)
    }
}
