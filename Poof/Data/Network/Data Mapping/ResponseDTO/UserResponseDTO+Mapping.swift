//
//  UserResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 19/10/23.
//

import Foundation

struct UserResponseDTO: Decodable {
    let message: String
}

extension UserResponseDTO {
    func toDomain() -> String {
        return message
    }
}
