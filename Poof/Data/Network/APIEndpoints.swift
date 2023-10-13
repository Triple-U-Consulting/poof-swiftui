//
//  APIEndpoints.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import Foundation

struct APIEndpoints {
    static func getKambuh() -> Endpoint<KambuhResponseDTO> {
        return Endpoint(path: "kambuh", method: .get)
    }
    
    static func getKambuhById(id: Int) -> Endpoint<KambuhResponseDTO> {
        let queryParameters = ["id": id]
        return Endpoint(path: "kambuh", method: .get, queryParameters: queryParameters)
    }
}
