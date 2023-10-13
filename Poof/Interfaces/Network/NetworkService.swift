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
    
    func request(endpoint: Requestable) async -> Data?
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
    
//    private func resolve(error: Error) -> NetworkError {
//        let code = URLError.Code(rawValue: (error as NSError).code)
//        switch code {
//        case .notConnectedToInternet: return .notConnected
//        case .cancelled: return .cancelled
//        default: return .generic(error)
//        }
//    }
}

extension NetworkServiceImpl: NetworkService {
    func request(endpoint: Requestable) async -> Data? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            let (data, _): (Data, URLResponse) = try await startSession(request: urlRequest)
            return data
//            { data, response, error in
//                if let requestError = error {
//                    var error: NetworkError
//                    if let response = response as? HTTPURLResponse {
//                        error = .error(statusCode: response.statusCode, data: data)
//                    } else {
//                        error = self.resolve(error: requestError)
//                    }
//                    self.logger.log(error: error)
//                    completion(.failure(error))
//                } else {
//                    self.logger.log(responseData: data, response: response)
//                    completion(.success(data))
//                }
//            }
        } catch {
            print(error)
        }
        return nil
    }
    
}
