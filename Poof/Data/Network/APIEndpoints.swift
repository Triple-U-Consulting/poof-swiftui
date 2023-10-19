//
//  APIEndpoints.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import Foundation

struct APIEndpoints {
    // MARK: - Authentication
    static func login(email: String, password: String) -> Endpoint<TokenResponseDTO> {
        let bodyParameters = [
            "email": email,
            "password": password
        ]
        
        return Endpoint(path: "auth/login", method: .post, bodyParameters: bodyParameters)
    }
    
    static func register() {
        
    }
    
    // MARK: - Kambuh
    static func getKambuh() -> Endpoint<KambuhResponseDTO> {
        return Endpoint(path: "kambuh", method: .get)
    }
    
    static func getKambuhById(id: Int) -> Endpoint<KambuhResponseDTO> {
        let queryParameters = ["id": id]
        
        return Endpoint(path: "kambuh", method: .get, queryParameters: queryParameters)
    }
    
    // MARK: - Inhaler
//    static func updateUserInhalerId(id: String, token: String) -> Endpoint<ValidationResponseDTO> {
//        let queryParameters = ["id": id]
//        let headerParameters = ["token": token]
//        
//        return Endpoint(path: "user/update/inhaler", method: .put, queryParameters: queryParameters, headerParameters: headerParameters)
//    }
    
    // MARK: - IOT
    static func getIoTInhalerId() -> Endpoint<IoTResponseDTO> {
        return Endpoint(path: "http://192.168.4.1/device-id", isFullPath: true, method: .get)
    }
}
