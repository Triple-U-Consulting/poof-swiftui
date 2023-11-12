//
//  Endpoint.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var queryParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var headerParameters: [String: String] { get }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest
}

protocol ResponseRequestable: Requestable {
    associatedtype ResponseType
    
    var responseDecoder: JSONResponseDecoder { get }
}

class Endpoint<R>: ResponseRequestable {
    typealias ResponseType = R
    
    let path: String
    let isFullPath: Bool
    let method: HTTPMethodType
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable?
    let bodyParameters: [String: Any]
    let headerParameters: [String: String]
    let responseDecoder: JSONResponseDecoder
    
    init(
        path: String,
        isFullPath: Bool = false,
        method: HTTPMethodType,
        queryParameters: [String : Any] = [:],
        bodyParametersEncodable: Encodable? = nil,
        bodyParameters: [String : Any] = [:],
        headerParameters: [String : String] = [:],
        responseDecoder: JSONResponseDecoder = JSONResponseDecoder()
    ) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
        self.headerParameters = headerParameters
        self.responseDecoder = responseDecoder
    }
}

extension Requestable {
    func url(with config: NetworkConfigurable) throws -> URL {

        let baseURL = config.baseURL.absoluteString.last != "/"
        ? config.baseURL.absoluteString + "/"
        : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents = URLComponents(
            string: endpoint
        ) else { throw NetworkError.urlGeneration }
        
        var urlQueryItems = [URLQueryItem]()

        if !self.queryParameters.isEmpty {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
            config.queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
            }
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw NetworkError.urlGeneration }
        print(url)
        return url
    }
    
    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach {
            allHeaders.updateValue($1, forKey: $0)
        }

        let bodyParameters = try self.bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
        if !bodyParameters.isEmpty {
            urlRequest.httpBody = encodeBody(bodyParameters: bodyParameters)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func encodeBody(bodyParameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: bodyParameters)
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
