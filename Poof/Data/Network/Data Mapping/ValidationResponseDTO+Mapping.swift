//
//  ValidationResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 17/10/23.
//

import Foundation

struct ValidationResponseDTO: Decodable {
    let status: Bool
}


extension ValidationResponseDTO {
    func toDomain() -> Bool {
        return status
    }
}
