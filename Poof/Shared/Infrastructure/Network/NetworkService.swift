//
//  NetworkService.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation
import Combine

protocol NetworkService {
    func request(endpoint: Requestable) async  -> Data?
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
    func request(endpoint: Requestable) async -> Data? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            let (data, _): (Data, URLResponse) = try await startSession(request: urlRequest)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
}
