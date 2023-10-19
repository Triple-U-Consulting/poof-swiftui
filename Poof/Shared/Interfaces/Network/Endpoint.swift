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
    var headerParameters: [String: String] { get }
    var bodyParameters: [String: Any] { get }
    
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
    let headerParameters: [String: String]
    let bodyParameters: [String : Any]
    let responseDecoder: JSONResponseDecoder
    
    init(path: String, isFullPath: Bool = false, method: HTTPMethodType, queryParameters: [String : Any] = [:], headerParameters: [String : String] = [:], bodyParameters: [String: Any] = [:], responseDecoder: JSONResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.queryParameters = queryParameters
        self.headerParameters = headerParameters
        self.responseDecoder = responseDecoder
        self.bodyParameters = bodyParameters
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
        
        if !bodyParameters.isEmpty {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}
