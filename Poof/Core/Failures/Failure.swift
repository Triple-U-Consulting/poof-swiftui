//
//  Failure.swift
//  Poof
//
//  Created by Angela Christabel on 06/10/23.
//

import Foundation

enum NetworkError: Error {
    // MARK: - Network Error
    case badRequest
    case unauthenticated
    case unknownURL
    case serverError
    case urlGeneration
}

enum Failure: Error {
    // MARK: - Kambuh Failures
    case fetchKambuhFailure
    case deleteKambuhFailure
    
    // MARK: - Connect to IoT Error
    case fetchInhalerIdFailure
    case unknownId
    
    // MARK: - User Failure
    case updateInhalerFailure
    case loginFailure
    case registerFailure
    
    // MARK: - Analytics Failures
    case fetchAnalyticsFailure
    case fetchSummaryFailure
    
    // MARK: - Data Transfer Error
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case parseDateFailure
}
