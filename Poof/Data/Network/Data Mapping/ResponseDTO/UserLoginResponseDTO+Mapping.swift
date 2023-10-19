//
//  TokenResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation

struct UserLoginResponseDTO: Decodable {
    let message: String
    let accessToken: String
}

extension UserLoginResponseDTO {
    func toDomain() -> String {
        return accessToken
    }
}
