//
//  KambuhResponseDTO+Mapping.swift
//  Poof
//
//  Created by Angela Christabel on 09/10/23.
//

import Foundation

struct KambuhResponseDTO: Decodable {
    let kambuh_id: Int
    let start_time: String
    let end_time: String
    let total_puff: Int
    let kambuh_interval: String
}

// MARK: - Mappings to Domain

extension KambuhResponseDTO {
    func toDomain() -> Kambuh {
        let formatter = DateFormatUtil()
        let startDate = formatter.stringToDate(string: start_time)
        let endDate = formatter.stringToDate(string: end_time)
        let lamaInt = Int64(kambuh_interval)!
        
        return .init(id: kambuh_id, start: startDate, end: endDate, totalPuff: total_puff, lamaKambuh: lamaInt)
    }
}
