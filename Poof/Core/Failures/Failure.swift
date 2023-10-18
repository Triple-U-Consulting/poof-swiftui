//
//  Failure.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

enum NetworkError: Error {
    // MARK: - Network Error
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

enum Failure: Error {
    // MARK: - Kambuh Failures
    case fetchKambuhFailure
    
    // MARK: - Connect to IoT Error
    case fetchInhalerIdFailure
    case unknownId
    
    // MARK: - Data Transfer Error
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
    case parseDateFailure
}
