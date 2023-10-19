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
    
    static func register(email: String, password: String, dob: Date, confirmPassword: String) -> Endpoint<UserResponseDTO> {
        let newDob = DateFormatUtil.shared.dateToString(date: dob, to: "yyyy-MM-dd")
        
        let requestDTO = UserRequestDTO(email: email, password: password, dob: newDob, confirmPassword: confirmPassword)
        return Endpoint(path: "auth/register", method: .post, bodyParametersEncodable: requestDTO)
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
}
