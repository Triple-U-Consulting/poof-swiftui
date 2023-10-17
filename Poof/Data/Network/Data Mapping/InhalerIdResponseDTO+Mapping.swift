//
//  InhalerIdResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation

struct InhalerIdResponseDTO: Decodable {
    let deviceid: String
}

extension InhalerIdResponseDTO {
    func toDomain() -> String {
        return self.deviceid
    }
}
