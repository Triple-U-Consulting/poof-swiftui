//
//  APIEndpoints.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import Foundation

struct APIEndpoints {
    static func login() {
        
    }
    
    static func register() {
        
    }
    
    static func getKambuh() -> Endpoint<KambuhResponseDTO> {
        return Endpoint(path: "kambuh", method: .get)
    }
    
    static func getKambuhById(id: Int) -> Endpoint<KambuhResponseDTO> {
        let queryParameters = ["id": id]
        
        return Endpoint(path: "kambuh", method: .get, queryParameters: queryParameters)
    }
    
    static func getInhalerId() -> Endpoint<InhalerIdResponseDTO> {
        return Endpoint(path: "http://192.168.4.1/device-id", isFullPath: true, method: .get)
    }
    
    static func updateUserInhalerId(token: String, id: String) -> Endpoint<ValidationResponseDTO> {
        let queryParameters = ["id": id]
        let headerParameters = ["token": token]
        
        return Endpoint(path: "user/update/inhaler", method: .put, queryParameters: queryParameters, headerParameters: headerParameters)
    }
    
    static func postWiFiDetails(ssid: String, password: String) -> Endpoint<MessageResponseDTO> {
            let bodyParameters = ["ssid": ssid, "password": password]
            print(ssid, password)
            return Endpoint(path: "http://192.168.4.1/config-wifi",
                            isFullPath: true,
                            method: .post,
                            bodyParameters: bodyParameters)
        }

}
