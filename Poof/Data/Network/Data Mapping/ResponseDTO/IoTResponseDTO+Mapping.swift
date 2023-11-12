//
//  InhalerIdResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 16/10/23.
//

import Foundation

struct IoTResponseDTO: Decodable {
    let deviceid: String
}

extension IoTResponseDTO {
    func toDomain() -> String {
        return self.deviceid
    }
}
