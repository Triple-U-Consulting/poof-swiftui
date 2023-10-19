//
//  TokenResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation

struct TokenResponseDTO: Decodable {
    let message: String
    let accessToken: String
}

extension TokenResponseDTO {
    func toDomain() -> String {
        return accessToken
    }
}
