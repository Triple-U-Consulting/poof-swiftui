//
//  NetworkService.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation
import Combine

protocol NetworkService {
//    typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
//    typealias RequestCompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable) async  -> (Data?, URLResponse?)
}

final class NetworkServiceImpl {
    static let shared: NetworkServiceImpl = NetworkServiceImpl(
        config: ApiDataNetworkConfig (
            baseURL: URL(string: AppConfiguration().apiBaseURL)!
        )
    )
    
    private let config: NetworkConfigurable
    
    init(config: NetworkConfigurable) {
        self.config = config
    }
    
    private func startSession(request: URLRequest) async throws -> (Data, URLResponse) {
        let (result, response) = try await URLSession.shared.data(for: request)
        return (result, response)
    }
}

extension NetworkServiceImpl: NetworkService {
    func request(endpoint: Requestable) async -> (Data?, URLResponse?) {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            let (data, response): (Data, URLResponse) = try await startSession(request: urlRequest)
            
            return (data, response)
        } catch {
            print(error)
        }
        return (nil, nil)
    }
}
