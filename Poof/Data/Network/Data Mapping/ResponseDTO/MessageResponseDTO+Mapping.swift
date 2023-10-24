//
//  MessageResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angelica Patricia on 19/10/23.
//

import Foundation

struct MessageResponseDTO: Decodable {
    let message: String
}

extension MessageResponseDTO {
    func toDomain() -> String {
        return message
    }
}
